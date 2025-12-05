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
import model.Cliente;
import model.Endereco;

public class ClienteDAO {
    
    private EnderecoDAO enderecoDAO = new EnderecoDAO();
    
 
    public Integer salvar(Cliente cliente) throws SQLException {
        String sql = "INSERT INTO cliente (tipo_documento, documento, nome, telefone, email, endereco_id) " +
                     "VALUES (?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = ConnectionFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            stmt.setString(1, cliente.getTipoDocumento());
            stmt.setString(2, cliente.getDocumento());
            stmt.setString(3, cliente.getNome());
            stmt.setString(4, cliente.getTelefone());
            stmt.setString(5, cliente.getEmail());
            stmt.setInt(6, cliente.getEnderecoId());
            
            stmt.executeUpdate();
            
            // Aqui to tentando recomperar o ID gerado :/
            try (ResultSet rs = stmt.getGeneratedKeys()) {
                if (rs.next()) {
                    Integer id = rs.getInt(1);
                    cliente.setId(id);
                    return id;
                }
            }
        }
        return null;
    }
    
   
    public Cliente buscarPorId(Integer id) throws SQLException {
        String sql = "SELECT * FROM cliente WHERE id = ?";
        
        try (Connection conn = ConnectionFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToCliente(rs);
                }
            }
        }
        return null;
    }
    
  
    public Cliente buscarPorDocumento(String documento) throws SQLException {
        String sql = "SELECT * FROM cliente WHERE documento = ?";
        
        try (Connection conn = ConnectionFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, documento);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToCliente(rs);
                }
            }
        }
        return null;
    }
    
    
    public List<Cliente> listarTodos() throws SQLException {
        String sql = "SELECT * FROM cliente ORDER BY nome";
        List<Cliente> clientes = new ArrayList<>();
        
        try (Connection conn = ConnectionFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                clientes.add(mapResultSetToCliente(rs));
            }
        }
        return clientes;
    }
    
   
    public void atualizar(Cliente cliente) throws SQLException {
        String sql = "UPDATE cliente SET tipo_documento = ?, documento = ?, nome = ?, " +
                     "telefone = ?, email = ?, endereco_id = ? WHERE id = ?";
        
        try (Connection conn = ConnectionFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, cliente.getTipoDocumento());
            stmt.setString(2, cliente.getDocumento());
            stmt.setString(3, cliente.getNome());
            stmt.setString(4, cliente.getTelefone());
            stmt.setString(5, cliente.getEmail());
            stmt.setInt(6, cliente.getEnderecoId());
            stmt.setInt(7, cliente.getId());
            
            stmt.executeUpdate();
        }
    }
    
   
    public void deletar(Integer id) throws SQLException {
        String sql = "DELETE FROM cliente WHERE id = ?";
        
        try (Connection conn = ConnectionFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            stmt.executeUpdate();
        }
    }
    
   
    private Cliente mapResultSetToCliente(ResultSet rs) throws SQLException {
        Cliente cliente = new Cliente();
        cliente.setId(rs.getInt("id"));
        cliente.setTipoDocumento(rs.getString("tipo_documento"));
        cliente.setDocumento(rs.getString("documento"));
        cliente.setNome(rs.getString("nome"));
        cliente.setTelefone(rs.getString("telefone"));
        cliente.setEmail(rs.getString("email"));
        cliente.setEnderecoId(rs.getInt("endereco_id"));
        
        Timestamp createdAt = rs.getTimestamp("created_at");
        if (createdAt != null) {
            cliente.setCreatedAt(createdAt.toLocalDateTime());
        }
        
        // Aquii vai Carregar o endereço relacionado
        try {
            Endereco endereco = enderecoDAO.buscarPorId(cliente.getEnderecoId());
            cliente.setEndereco(endereco);
        } catch (SQLException e) {
            System.err.println("Erro ao carregar endereço do cliente: " + e.getMessage());
        }
        
        return cliente;
    }
}
