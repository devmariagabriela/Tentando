package controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.ProdutoDAO;
import model.Produto;

@WebServlet("/produtos")
public class ProdutoServlet extends HttpServlet {
    
    private ProdutoDAO produtoDAO = new ProdutoDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String acao = request.getParameter("acao");
        
        try {
            if ("novo".equals(acao)) {
                // Exibe formulário de novo produto
            	
                request.getRequestDispatcher("/WEB-INF/views/produtos/form.jsp")
                       .forward(request, response);
            } else {
                // Lista todos os produtos
            	
                List<Produto> produtos = produtoDAO.listarTodos();
                request.setAttribute("produtos", produtos);
                request.getRequestDispatcher("/WEB-INF/views/produtos/listar.jsp")
                       .forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("erro", "Erro ao processar requisição: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/erro.jsp")
                   .forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        
        try {
            // Captura dados do produto
        	
            String nome = request.getParameter("nome");
            String descricao = request.getParameter("descricao");
            Double pesoKg = new Double(request.getParameter("pesoKg"));
            Double volumeM3 = new Double(request.getParameter("volumeM3"));
            Double valorUnitario = new Double(request.getParameter("valorUnitario"));
            
            // Cria e salva o produto
            
            Produto produto = new Produto();
            produto.setNome(nome);
            produto.setDescricao(descricao);
            produto.setPesoKg(pesoKg);
            produto.setVolumeM3(volumeM3);
            produto.setValorUnitario(valorUnitario);
            
            produtoDAO.salvar(produto);
            
            // Redireciona para a listagem
            
            response.sendRedirect(request.getContextPath() + "/produtos?sucesso=true");
            
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("erro", "Erro ao cadastrar produto: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/erro.jsp")
                   .forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("erro", "Erro ao processar dados: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/erro.jsp")
                   .forward(request, response);
        }
    }
}
