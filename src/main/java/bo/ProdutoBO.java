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

    /**
     * Atualiza a quantidade em estoque de um produto.
     * @param produtoId ID do produto.
     * @param quantidade Variação do estoque (positivo para adicionar, negativo para remover).
     * @throws SQLException
     */
    public void atualizarEstoque(Integer produtoId, Integer quantidade) throws SQLException { // NOVO MÉTODO
        produtoDAO.atualizarEstoque(produtoId, quantidade);
    }
    
    // Outros métodos de BO (salvar, atualizar, deletar) podem ser adicionados aqui se necessário.
    // Por enquanto, focamos no controle de estoque.
}