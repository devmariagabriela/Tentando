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
import model.Endereco;

public class EnderecoDAO {
    
   
    public Integer salvar(Endereco endereco) throws SQLException {
        String sql = "INSERT INTO endereco (cep, logradouro, numero, complemento, bairro, cidade, estado) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = ConnectionFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            stmt.setString(1, endereco.getCep());
            stmt.setString(2, endereco.getLogradouro());
            stmt.setString(3, endereco.getNumero());
            stmt.setString(4, endereco.getComplemento());
            stmt.setString(5, endereco.getBairro());
            stmt.setString(6, endereco.getCidade());
            stmt.setString(7, endereco.getEstado());
            
            stmt.executeUpdate();
            
            // Aqui é pra recumperar o ID gerado
            
            try (ResultSet rs = stmt.getGeneratedKeys()) {
                if (rs.next()) {
                    Integer id = rs.getInt(1);
                    endereco.setId(id);
                    return id;
                }
            }
        }
        return null;
    }
    

    public Endereco buscarPorId(Integer id) throws SQLException {
        String sql = "SELECT * FROM endereco WHERE id = ?";
        
        try (Connection conn = ConnectionFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToEndereco(rs);
                }
            }
        }
        return null;
    }
    
    
    public List<Endereco> listarTodos() throws SQLException {
        String sql = "SELECT * FROM endereco ORDER BY id DESC";
        List<Endereco> enderecos = new ArrayList<>();
        
        try (Connection conn = ConnectionFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                enderecos.add(mapResultSetToEndereco(rs));
            }
        }
        return enderecos;
    }
    
    
    public void atualizar(Endereco endereco) throws SQLException {
        String sql = "UPDATE endereco SET cep = ?, logradouro = ?, numero = ?, " +
                     "complemento = ?, bairro = ?, cidade = ?, estado = ? WHERE id = ?";
        
        try (Connection conn = ConnectionFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, endereco.getCep());
            stmt.setString(2, endereco.getLogradouro());
            stmt.setString(3, endereco.getNumero());
            stmt.setString(4, endereco.getComplemento());
            stmt.setString(5, endereco.getBairro());
            stmt.setString(6, endereco.getCidade());
            stmt.setString(7, endereco.getEstado());
            stmt.setInt(8, endereco.getId());
            
            stmt.executeUpdate();
        }
    }
    
  
    public void deletar(Integer id) throws SQLException {
        String sql = "DELETE FROM endereco WHERE id = ?";
        
        try (Connection conn = ConnectionFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            stmt.executeUpdate();
        }
    }
    
  
    private Endereco mapResultSetToEndereco(ResultSet rs) throws SQLException {
        Endereco endereco = new Endereco();
        endereco.setId(rs.getInt("id"));
        endereco.setCep(rs.getString("cep"));
        endereco.setLogradouro(rs.getString("logradouro"));
        endereco.setNumero(rs.getString("numero"));
        endereco.setComplemento(rs.getString("complemento"));
        endereco.setBairro(rs.getString("bairro"));
        endereco.setCidade(rs.getString("cidade"));
        endereco.setEstado(rs.getString("estado"));
        
        Timestamp createdAt = rs.getTimestamp("data_criacao");
        if (createdAt != null) {
            endereco.setCreatedAt(createdAt.toLocalDateTime());
        }
        
        return endereco;
    }
}
