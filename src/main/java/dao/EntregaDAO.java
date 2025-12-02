package dao;

import db.ConnectionFactory;
import model.Entrega;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EntregaDAO {

    public void salvar(Entrega entrega) throws SQLException {
        Connection conn = null;
        try {
            conn = ConnectionFactory.getInstance().getConnection();
            conn.setAutoCommit(false);

            // Salvar entrega
            String sql = "INSERT INTO entrega (codigo_rastreio, data_prevista_entrega, status, valor_frete, observacoes) VALUES (?, ?, ?, ?, ?)";

            try (PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
                String codigo = "TC" + System.currentTimeMillis();

                stmt.setString(1, codigo);
                stmt.setDate(2, Date.valueOf(entrega.getDataPrevistaEntrega()));
                stmt.setString(3, entrega.getStatus());
                stmt.setDouble(4, entrega.getValorFrete());
                stmt.setString(5, entrega.getObservacoes());

                stmt.executeUpdate();

                ResultSet rs = stmt.getGeneratedKeys();
                if (rs.next()) {
                    entrega.setId(rs.getInt(1));
                    entrega.setCodigoRastreio(codigo);
                }
            }

            conn.commit();

        } catch (SQLException e) {
            if (conn != null) conn.rollback();
            throw e;
        } finally {
            if (conn != null) conn.close();
        }
    }

    public List<Entrega> listarTodas() throws SQLException {
        List<Entrega> entregas = new ArrayList<>();
        String sql = "SELECT * FROM entrega ORDER BY data_criacao DESC";

        try (Connection conn = ConnectionFactory.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Entrega e = new Entrega();
                e.setId(rs.getInt("id"));
                e.setCodigoRastreio(rs.getString("codigo_rastreio"));
                e.setDataCriacao(rs.getDate("data_criacao").toLocalDate());
                e.setDataPrevistaEntrega(rs.getDate("data_prevista_entrega").toLocalDate());
                e.setStatus(rs.getString("status"));
                e.setValorFrete(rs.getDouble("valor_frete"));
                e.setObservacoes(rs.getString("observacoes"));
                entregas.add(e);
            }
        }
        return entregas;
    }
}