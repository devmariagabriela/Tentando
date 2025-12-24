package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import db.ConnectionFactory;
import model.Produto;

public class ProdutoDAO {
    
    
    public Integer salvar(Produto produto) throws SQLException {
        String sql = "INSERT INTO produto (nome, descricao, peso_kg, volume_m3, unidade_volume, valor_unitario, quantidade_estoque) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?)"; // ALTERADO - adicionado unidade_volume
        
        try (Connection conn = ConnectionFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            stmt.setString(1, produto.getNome());
            stmt.setString(2, produto.getDescricao());
            stmt.setDouble(3, produto.getPesoKg());
            stmt.setDouble(4, produto.getVolumeM3());
            stmt.setString(5, produto.getUnidadeVolume() != null ? produto.getUnidadeVolume() : "m3"); // NOVO
            stmt.setDouble(6, produto.getValorUnitario());
            stmt.setInt(7, produto.getQuantidadeEstoque());
            
            stmt.executeUpdate();
            
            try (ResultSet rs = stmt.getGeneratedKeys()) {
                if (rs.next()) {
                    Integer id = rs.getInt(1);
                    produto.setId(id);
                    return id;
                }
            }
        }
        return null;
    }
    
   
    public Produto buscarPorId(Integer id) throws SQLException {
        String sql = "SELECT * FROM produto WHERE id = ?";
        
        try (Connection conn = ConnectionFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToProduto(rs);
                }
            }
        }
        return null;
    }
    
   
    public List<Produto> listarTodos() throws SQLException {
        String sql = "SELECT * FROM produto ORDER BY nome";
        List<Produto> produtos = new ArrayList<>();
        
        try (Connection conn = ConnectionFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                produtos.add(mapResultSetToProduto(rs));
            }
            
            System.out.println("DEBUG: Consulta listarTodos() retornou " + produtos.size() + " produtos.");
            
        }
        return produtos;
    }
    
  
    public void atualizar(Produto produto) throws SQLException {
        String sql = "UPDATE produto SET nome = ?, descricao = ?, peso_kg = ?, " +
                     "volume_m3 = ?, unidade_volume = ?, valor_unitario = ?, quantidade_estoque = ? WHERE id = ?"; // ALTERADO
        
        try (Connection conn = ConnectionFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, produto.getNome());
            stmt.setString(2, produto.getDescricao());
            stmt.setDouble(3, produto.getPesoKg());
            stmt.setDouble(4, produto.getVolumeM3());
            stmt.setString(5, produto.getUnidadeVolume() != null ? produto.getUnidadeVolume() : "m3"); // NOVO
            stmt.setDouble(6, produto.getValorUnitario());
            stmt.setInt(7, produto.getQuantidadeEstoque());
            stmt.setInt(8, produto.getId());
            
            stmt.executeUpdate();
        }
    }
    
    
    public void deletar(Integer id) throws SQLException {
        String sql = "DELETE FROM produto WHERE id = ?";
        
        try (Connection conn = ConnectionFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            stmt.executeUpdate();
        }
    }
    
   
    private Produto mapResultSetToProduto(ResultSet rs) throws SQLException {
        Produto produto = new Produto();
        produto.setId(rs.getInt("id"));
        produto.setNome(rs.getString("nome"));
        
        // Tenta ler a descrição, mas ignora se a coluna não existir
        try {
            produto.setDescricao(rs.getString("descricao"));
        } catch (SQLException e) {
            // Ignora o erro se a coluna 'descricao' não existir
        }
        
        produto.setPesoKg(rs.getDouble("peso_kg"));
        produto.setVolumeM3(rs.getDouble("volume_m3"));
        
        // NOVO: Ler unidade de volume
        try {
            String unidadeVolume = rs.getString("unidade_volume");
            produto.setUnidadeVolume(unidadeVolume != null ? unidadeVolume : "m3");
        } catch (SQLException e) {
            // Se a coluna não existir, usa m3 como padrão
            produto.setUnidadeVolume("m3");
        }
        
        produto.setValorUnitario(rs.getDouble("valor_unitario"));
        
        // Adicionando o campo de estoque
        try {
            produto.setQuantidadeEstoque(rs.getInt("quantidade_estoque"));
        } catch (SQLException e) {
            // Ignora o erro se a coluna 'quantidade_estoque' não existir
        }
        
        // Tenta ler a data de criação, mas ignora se a coluna não existir
        try {
            Timestamp createdAt = rs.getTimestamp("data_criacao");
            if (createdAt != null) {
                produto.setCreatedAt(createdAt.toLocalDateTime());
            }
        } catch (SQLException e) {
            // Ignora o erro se a coluna 'data_criacao' não existir
        }
        
        return produto;
    }

    /**
     * Atualiza a quantidade em estoque de um produto.
     * @param produtoId ID do produto.
     * @param quantidade Variação do estoque (positivo para adicionar, negativo para remover).
     * @throws SQLException
     */
    public void atualizarEstoque(Integer produtoId, Integer quantidade) throws SQLException {
        String sql = "UPDATE produto SET quantidade_estoque = quantidade_estoque + ? WHERE id = ?";
        
        try (Connection conn = ConnectionFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, quantidade);
            stmt.setInt(2, produtoId);
            
            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected == 0) {
                throw new SQLException("Produto com ID " + produtoId + " não encontrado para atualização de estoque.");
            }
        }
    }

}