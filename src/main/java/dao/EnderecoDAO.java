package dao;

import db.ConnectionFactory;
import model.Endereco;
import java.sql.*;

public class EnderecoDAO {

    public Integer salvar(Endereco endereco) throws SQLException {
        String sql = "INSERT INTO endereco (logradouro, numero, complemento, bairro, cidade, estado, cep) VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = ConnectionFactory.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setString(1, endereco.getLogradouro());
            stmt.setString(2, endereco.getNumero());
            stmt.setString(3, endereco.getComplemento());
            stmt.setString(4, endereco.getBairro());
            stmt.setString(5, endereco.getCidade());
            stmt.setString(6, endereco.getEstado());
            stmt.setString(7, endereco.getCep());

            stmt.executeUpdate();

            ResultSet rs = stmt.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return null;
    }

    public Endereco buscarPorId(Integer id) throws SQLException {
        String sql = "SELECT * FROM endereco WHERE id = ?";

        try (Connection conn = ConnectionFactory.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                Endereco endereco = new Endereco();
                endereco.setId(rs.getInt("id"));
                endereco.setLogradouro(rs.getString("logradouro"));
                endereco.setNumero(rs.getString("numero"));
                endereco.setComplemento(rs.getString("complemento"));
                endereco.setBairro(rs.getString("bairro"));
                endereco.setCidade(rs.getString("cidade"));
                endereco.setEstado(rs.getString("estado"));
                endereco.setCep(rs.getString("cep"));
                return endereco;
            }
        }
        return null;
    }
}