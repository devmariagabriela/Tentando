package dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import db.ConnectionFactory;
import model.Entrega;

public class EntregaDAO {
    
    private ClienteDAO clienteDAO = new ClienteDAO();
    private EnderecoDAO enderecoDAO = new EnderecoDAO();
    private ItemEntregaDAO itemEntregaDAO = new ItemEntregaDAO();

     
    public Integer salvar(Entrega entrega) throws SQLException {

    	String sql = "INSERT INTO entrega (codigo_rastreio, remetente_id, destinatario_id, " +
                    "endereco_origem_id, endereco_destino_id, data_coleta, data_prevista_entrega, status, valor_frete, observacoes) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = ConnectionFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            stmt.setString(1, entrega.getCodigo());
            stmt.setInt(2, entrega.getRemetenteId());
            stmt.setInt(3, entrega.getDestinatarioId());
            
            //  Meuu tratamento para EnderecoOrigem 

            if (entrega.getEnderecoOrigemId() != null && entrega.getEnderecoOrigemId() > 0) {
                stmt.setInt(4, entrega.getEnderecoOrigemId());
            } else {
                stmt.setNull(4, Types.INTEGER);
            }
            
            if (entrega.getEnderecoDestinoId() != null && entrega.getEnderecoDestinoId() > 0) {
                stmt.setInt(5, entrega.getEnderecoDestinoId());
            } else {
                stmt.setNull(5, Types.INTEGER);
            }
            
            if (entrega.getDataColeta() != null) {
                stmt.setDate(6, Date.valueOf(entrega.getDataColeta()));
            } else {
                stmt.setNull(6, Types.DATE);
            }
            
            if (entrega.getDataEntregaPrevista() != null) {
                stmt.setDate(7, Date.valueOf(entrega.getDataEntregaPrevista()));
            } else {
                stmt.setNull(7, Types.DATE);
            }
            
            stmt.setString(8, entrega.getStatus());
            stmt.setDouble(9, entrega.getValorFrete());
            stmt.setString(10, entrega.getObservacoes());
            
            stmt.executeUpdate();
            
            try (ResultSet rs = stmt.getGeneratedKeys()) {
                if (rs.next()) {
                    Integer id = rs.getInt(1);
                    entrega.setId(id);
                    return id;
                }
            }
        }
        return null;
    }
    
  
    public Entrega buscarPorId(Integer id) throws SQLException {
        String sql = "SELECT * FROM entrega WHERE id = ?";
        
        try (Connection conn = ConnectionFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToEntrega(rs);
                }
            }
        }
        return null;
    }
    
  
    public Entrega buscarPorCodigo(String codigo_rastreio) throws SQLException {
        String sql = "SELECT * FROM entrega WHERE codigo_rastreio = ?";
        
        try (Connection conn = ConnectionFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, codigo_rastreio);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToEntrega(rs);
                }
            }
        }
        return null;
    }
   
    public List<Entrega> listarTodas() throws SQLException {
        String sql = "SELECT * FROM entrega ORDER BY data_coleta DESC"; // CORRIGIDO
        List<Entrega> entregas = new ArrayList<>();
        
        try (Connection conn = ConnectionFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                entregas.add(mapResultSetToEntrega(rs));
            }
        }
        return entregas;
    }
    
   
    public List<Entrega> listarPorStatus(String status) throws SQLException {
        String sql = "SELECT * FROM entrega WHERE status = ? ORDER BY data_coleta DESC"; // CORRIGIDO
        List<Entrega> entregas = new ArrayList<>();
        
        try (Connection conn = ConnectionFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, status);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    entregas.add(mapResultSetToEntrega(rs));
                }
            }
        }
        return entregas;
    }
    
   
    public void atualizar(Entrega entrega) throws SQLException {

    	String sql = "UPDATE entrega SET codigo_rastreio = ?, remetente_id = ?, destinatario_id = ?, " +
                     "endereco_origem_id = ?, endereco_destino_id = ?, data_coleta = ?, data_prevista_entrega = ?, data_entrega_realizada = ?, status = ?, " +
                     "valor_frete = ?, observacoes = ? WHERE id = ?";
        
        try (Connection conn = ConnectionFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, entrega.getCodigo());
            stmt.setInt(2, entrega.getRemetenteId());
            stmt.setInt(3, entrega.getDestinatarioId());
            
            //  E aqui é o tratamento para enderecoOrigemId
            if (entrega.getEnderecoOrigemId() != null && entrega.getEnderecoOrigemId() > 0) {
                stmt.setInt(4, entrega.getEnderecoOrigemId());
            } else {
                stmt.setNull(4, Types.INTEGER);
            }
            
            if (entrega.getEnderecoDestinoId() != null && entrega.getEnderecoDestinoId() > 0) {
                stmt.setInt(5, entrega.getEnderecoDestinoId());
            } else {
                stmt.setNull(5, Types.INTEGER);
            }
            
            if (entrega.getDataColeta() != null) {
                stmt.setDate(6, Date.valueOf(entrega.getDataColeta()));
            } else {
                stmt.setNull(6, Types.DATE);
            }
            
            if (entrega.getDataEntregaPrevista() != null) {
                stmt.setDate(7, Date.valueOf(entrega.getDataEntregaPrevista()));
            } else {
                stmt.setNull(7, Types.DATE);
            }
            
            if (entrega.getDataEntregaRealizada() != null) {
                stmt.setDate(8, Date.valueOf(entrega.getDataEntregaRealizada()));
            } else {
                stmt.setNull(8, Types.DATE);
            }
            
            stmt.setString(9, entrega.getStatus());
            stmt.setDouble(10, entrega.getValorFrete());
            stmt.setString(11, entrega.getObservacoes());
            stmt.setInt(12, entrega.getId());
            
            stmt.executeUpdate();
        }
    }
    
    
    public void atualizarStatus(Integer id, String novoStatus) throws SQLException {
        String sql = "UPDATE entrega SET status = ? WHERE id = ?";
        
        try (Connection conn = ConnectionFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, novoStatus);
            stmt.setInt(2, id);
            stmt.executeUpdate();
        }
    }
    
   
    public void deletar(Integer id) throws SQLException {
        String sql = "DELETE FROM entrega WHERE id = ?";
        
        try (Connection conn = ConnectionFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            stmt.executeUpdate();
        }
    }
    
   
    private Entrega mapResultSetToEntrega(ResultSet rs) throws SQLException {
        Entrega entrega = new Entrega();
        entrega.setId(rs.getInt("id"));
        entrega.setCodigo(rs.getString("codigo_rastreio")); 
        entrega.setRemetenteId(rs.getInt("remetente_id"));
        entrega.setDestinatarioId(rs.getInt("destinatario_id"));
        
        entrega.setEnderecoOrigemId(rs.getInt("endereco_origem_id"));
        entrega.setEnderecoDestinoId(rs.getInt("endereco_destino_id"));
        
        Date dataColeta = rs.getDate("data_coleta");
        if (dataColeta != null) {
            entrega.setDataColeta(dataColeta.toLocalDate());
        }
        
        Date dataEntregaPrevista = rs.getDate("data_prevista_entrega");
        if (dataEntregaPrevista != null) {
            entrega.setDataEntregaPrevista(dataEntregaPrevista.toLocalDate());
        }
        
        Date dataEntregaRealizada = rs.getDate("data_entrega_realizada");
        if (dataEntregaRealizada != null) {
            entrega.setDataEntregaRealizada(dataEntregaRealizada.toLocalDate());
        }
        
        entrega.setStatus(rs.getString("status"));
        entrega.setValorFrete(rs.getDouble("valor_frete"));
        entrega.setObservacoes(rs.getString("observacoes"));
        
        // Tenta ler data_criacao e updated_at (aiii vai ignorar se não existirem)
        try {
            Timestamp createdAt = rs.getTimestamp("data_criacao"); // CORRIGIDO
            if (createdAt != null) {
                entrega.setCreatedAt(createdAt.toLocalDateTime());
            }
        } catch (SQLException e) {}
        
        try {
            Timestamp updatedAt = rs.getTimestamp("updated_at");
            if (updatedAt != null) {
                entrega.setUpdatedAt(updatedAt.toLocalDateTime());
            }
        } catch (SQLException e) {}
        
        // To tentando carregar os objetos relacionados
        try {
            entrega.setRemetente(clienteDAO.buscarPorId(entrega.getRemetenteId()));
            entrega.setDestinatario(clienteDAO.buscarPorId(entrega.getDestinatarioId()));
            
            // Carrega endereços se os IDs forem válidos
            if (entrega.getEnderecoOrigemId() != 0) {
                entrega.setEnderecoOrigem(enderecoDAO.buscarPorId(entrega.getEnderecoOrigemId()));
            }
            if (entrega.getEnderecoDestinoId() != 0) {
                entrega.setEnderecoDestino(enderecoDAO.buscarPorId(entrega.getEnderecoDestinoId()));
            }
            entrega.setItens(itemEntregaDAO.listarPorEntrega(entrega.getId()));
        } catch (SQLException e) {
            System.err.println("Erro ao carregar dados relacionados da entrega: " + e.getMessage());
        }
        
        return entrega;
    }
}