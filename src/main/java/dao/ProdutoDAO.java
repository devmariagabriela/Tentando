package dao;

import db.ConnectionFactory;
import model.Produto;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProdutoDAO {

    public void salvar(Produto produto) throws SQLException {
        String sql = "INSERT INTO produto (nome, peso_kg, volume_m3, valor_unitario) VALUES (?, ?, ?, ?)";

        try (Connection conn = ConnectionFactory.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setString(1, produto.getNome());
            stmt.setDouble(2, produto.getPeso());
            stmt.setDouble(3, produto.getVolume());
            stmt.setDouble(4, produto.getValor());

            stmt.executeUpdate();

            ResultSet rs = stmt.getGeneratedKeys();
            if (rs.next()) {
                produto.setId(rs.getInt(1));
            }
        }
    }

    public List<Produto> listarTodos() throws SQLException {
        List<Produto> produtos = new ArrayList<>();
        String sql = "SELECT * FROM produto ORDER BY nome";

        try (Connection conn = ConnectionFactory.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Produto p = new Produto();
                p.setId(rs.getInt("id"));
                p.setNome(rs.getString("nome"));
                p.setPeso(rs.getDouble("peso_kg"));
                p.setVolume(rs.getDouble("volume_m3"));
                p.setValor(rs.getDouble("valor_unitario"));
                produtos.add(p);
            }
        }
        return produtos;
    }

    public Produto buscarPorId(Integer id) throws SQLException {
        String sql = "SELECT * FROM produto WHERE id = ?";

        try (Connection conn = ConnectionFactory.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                Produto p = new Produto();
                p.setId(rs.getInt("id"));
                p.setNome(rs.getString("nome"));
                p.setPeso(rs.getDouble("peso_kg"));
                p.setVolume(rs.getDouble("volume_m3"));
                p.setValor(rs.getDouble("valor_unitario"));
                return p;
            }
        }
        return null;
    }
}