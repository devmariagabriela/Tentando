package dao;

import db.ConnectionFactory;
import model.Cliente;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ClienteDAO {

    public void salvar(Cliente cliente) throws SQLException {
        String sql = "INSERT INTO cliente (documento, nome, tipo, telefone, email) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = ConnectionFactory.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setString(1, cliente.getDocumento());
            stmt.setString(2, cliente.getNome());
            stmt.setString(3, cliente.getTipo());
            stmt.setString(4, cliente.getTelefone());
            stmt.setString(5, cliente.getEmail());

            stmt.executeUpdate();

            ResultSet rs = stmt.getGeneratedKeys();
            if (rs.next()) {
                cliente.setId(rs.getInt(1));
            }
        }
    }

    public Cliente buscarPorDocumento(String documento) throws SQLException {
        String sql = "SELECT * FROM cliente WHERE documento = ?";

        try (Connection conn = ConnectionFactory.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, documento);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                Cliente c = new Cliente();
                c.setId(rs.getInt("id"));
                c.setDocumento(rs.getString("documento"));
                c.setNome(rs.getString("nome"));
                c.setTipo(rs.getString("tipo"));
                c.setTelefone(rs.getString("telefone"));
                c.setEmail(rs.getString("email"));
                return c;
            }
        }
        return null;
    }

    public List<Cliente> listarTodos() throws SQLException {
        List<Cliente> clientes = new ArrayList<>();
        String sql = "SELECT * FROM cliente ORDER BY nome";

        try (Connection conn = ConnectionFactory.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Cliente c = new Cliente();
                c.setId(rs.getInt("id"));
                c.setDocumento(rs.getString("documento"));
                c.setNome(rs.getString("nome"));
                c.setTipo(rs.getString("tipo"));
                c.setTelefone(rs.getString("telefone"));
                c.setEmail(rs.getString("email"));
                clientes.add(c);
            }
        }
        return clientes;
    }
}