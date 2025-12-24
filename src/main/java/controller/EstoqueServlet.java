package controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bo.ProdutoBO;
import model.Produto;

@WebServlet("/produtos/estoque" )
public class EstoqueServlet extends HttpServlet {
    
    private static final long serialVersionUID = 1L;
    private ProdutoBO produtoBO = new ProdutoBO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            List<Produto> produtos = produtoBO.listarTodos();
            request.setAttribute("produtos", produtos);
            
            // O caminho do JSP deve ser /WEB-INF/views/produtos/estoque/gerenciar.jsp
            request.getRequestDispatcher("/WEB-INF/views/produtos/estoque/gerenciar.jsp")
                   .forward(request, response);
            
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("erro", "Erro ao carregar a lista de produtos: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/erro.jsp")
                   .forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        
        try {
            Integer produtoId = parseInteger(request.getParameter("produtoId"), "Produto");
            Integer quantidade = parseInteger(request.getParameter("quantidade"), "Quantidade");
            String tipoOperacao = request.getParameter("tipoOperacao"); // ENTRADA ou SAIDA
            
            if (quantidade <= 0) {
                throw new IllegalArgumentException("A quantidade deve ser um número positivo.");
            }
            
            // A lógica do BO/DAO é: positivo para adicionar, negativo para remover.
            Integer variacaoEstoque = quantidade;
            String mensagemSucesso = "Entrada de estoque realizada com sucesso!";
            
            if ("SAIDA".equalsIgnoreCase(tipoOperacao)) {
                variacaoEstoque = -quantidade;
                mensagemSucesso = "Saída de estoque realizada com sucesso!";
                
                // Verificação de estoque antes de subtrair
                Produto produto = produtoBO.buscarPorId(produtoId);
                if (produto == null) {
                    throw new IllegalArgumentException("Produto não encontrado.");
                }
                // Verifica se o estoque atual (produto.getQuantidadeEstoque()) menos a quantidade a ser removida (variacaoEstoque é negativo) é menor que zero.
                if (produto.getQuantidadeEstoque() + variacaoEstoque < 0) {
                    throw new IllegalArgumentException("Estoque insuficiente para realizar a saída. Estoque atual: " + produto.getQuantidadeEstoque());
                }
            } else if (!"ENTRADA".equalsIgnoreCase(tipoOperacao)) {
                throw new IllegalArgumentException("Tipo de operação inválido.");
            }
            
            produtoBO.atualizarEstoque(produtoId, variacaoEstoque);
            
            response.sendRedirect(request.getContextPath() + "/produtos/estoque?sucesso=" + mensagemSucesso);
            
        } catch (IllegalArgumentException e) {
            request.setAttribute("erro", e.getMessage());
            doGet(request, response); // Recarrega a página com a mensagem de erro
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("erro", "Erro de banco de dados ao atualizar estoque: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/erro.jsp")
                   .forward(request, response);
        }
    }
    
    private Integer parseInteger(String value, String fieldName) {
        if (value == null || value.trim().isEmpty()) {
            throw new IllegalArgumentException(fieldName + " é obrigatório.");
        }
        try {
            return Integer.parseInt(value.trim());
        } catch (NumberFormatException e) {
            throw new IllegalArgumentException("O valor para " + fieldName + " deve ser um número inteiro válido.");
        }
    }
}