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
import model.ItemEntrega;

public class ItemEntregaDAO {
    
    private ProdutoDAO produtoDAO = new ProdutoDAO();
    
   
    public Integer salvar(ItemEntrega item) throws SQLException {
        String sql = "INSERT INTO item_entrega (entrega_id, produto_id, quantidade, valor_total) " +
                     "VALUES (?, ?, ?, ?)";
        
        try (Connection conn = ConnectionFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            stmt.setInt(1, item.getEntregaId());
            stmt.setInt(2, item.getProdutoId());
            stmt.setInt(3, item.getQuantidade());
            stmt.setDouble(4, item.getValorTotal());
            
            stmt.executeUpdate();
            
            // A meta é recuperar o ID gerado
            try (ResultSet rs = stmt.getGeneratedKeys()) {
                if (rs.next()) {
                    Integer id = rs.getInt(1);
                    item.setId(id);
                    return id;
                }
            }
        }
        return null;
    }
    
   
    public ItemEntrega buscarPorId(Integer id) throws SQLException {
        String sql = "SELECT * FROM item_entrega WHERE id = ?";
        
        try (Connection conn = ConnectionFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToItemEntrega(rs);
                }
            }
        }
        return null;
    }
    
   
    public List<ItemEntrega> listarPorEntrega(Integer entregaId) throws SQLException {
        String sql = "SELECT * FROM item_entrega WHERE entrega_id = ?";
        List<ItemEntrega> itens = new ArrayList<>();
        
        try (Connection conn = ConnectionFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, entregaId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    itens.add(mapResultSetToItemEntrega(rs));
                }
            }
        }
        return itens;
    }
    
  
    public void atualizar(ItemEntrega item) throws SQLException {
        String sql = "UPDATE item_entrega SET entrega_id = ?, produto_id = ?, " +
                     "quantidade = ?, valor_total = ? WHERE id = ?";
        
        try (Connection conn = ConnectionFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, item.getEntregaId());
            stmt.setInt(2, item.getProdutoId());
            stmt.setInt(3, item.getQuantidade());
            stmt.setDouble(4, item.getValorTotal());
            stmt.setInt(5, item.getId());
            
            stmt.executeUpdate();
        }
    }
    
  
    public void deletar(Integer id) throws SQLException {
        String sql = "DELETE FROM item_entrega WHERE id = ?";
        
        try (Connection conn = ConnectionFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            stmt.executeUpdate();
        }
    }
    
   
    public void deletarPorEntrega(Integer entregaId) throws SQLException {
        String sql = "DELETE FROM item_entrega WHERE entrega_id = ?";
        
        try (Connection conn = ConnectionFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, entregaId);
            stmt.executeUpdate();
        }
    }
    
  
    private ItemEntrega mapResultSetToItemEntrega(ResultSet rs) throws SQLException {
        ItemEntrega item = new ItemEntrega();
        item.setId(rs.getInt("id"));
        item.setEntregaId(rs.getInt("entrega_id"));
        item.setProdutoId(rs.getInt("produto_id"));
        item.setQuantidade(rs.getInt("quantidade"));
        item.setValorTotal(rs.getDouble("valor_total"));
        
        Timestamp createdAt = rs.getTimestamp("created_at");
        if (createdAt != null) {
            item.setCreatedAt(createdAt.toLocalDateTime());
        }
        
        // Aqui eu vou carregar o produto relacionado
        try {
            item.setProduto(produtoDAO.buscarPorId(item.getProdutoId()));
        } catch (SQLException e) {
            System.err.println("Erro ao carregar produto do item: " + e.getMessage());
        }
        
        return item;
    }
}
