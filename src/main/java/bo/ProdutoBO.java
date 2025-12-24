package bo;

import java.sql.SQLException;
import java.util.List;

import dao.ProdutoDAO;
import model.Produto;

public class ProdutoBO {
    
    private ProdutoDAO produtoDAO = new ProdutoDAO();

    public List<Produto> listarTodos() throws SQLException {
        return produtoDAO.listarTodos();
    }

    public Produto buscarPorId(Integer id) throws SQLException {
        return produtoDAO.buscarPorId(id);
    }


    public void atualizarEstoque(Integer produtoId, Integer quantidade) throws SQLException { // NOVO MÉTODO
        produtoDAO.atualizarEstoque(produtoId, quantidade);
    }
    
    
}