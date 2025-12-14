package controller;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.ProdutoDAO;

@WebServlet("/produtos/remover" )
public class RemoverProdutoServlet extends HttpServlet {
    
    private static final long serialVersionUID = 1L;
	private ProdutoDAO produtoDAO = new ProdutoDAO();
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            Integer produtoId = Integer.parseInt(request.getParameter("produtoId"));
            
            produtoDAO.deletar(produtoId);
            
            // Redireciona para a listagem com uma mensagem de sucesso
            response.sendRedirect(request.getContextPath() + "/produtos?removido=true");
            
        } catch (NumberFormatException e) {
            e.printStackTrace();
            request.setAttribute("erro", "ID de produto inválido.");
            request.getRequestDispatcher("/WEB-INF/views/erro.jsp")
                   .forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            // Trata o erro de chave estrangeira (se o produto estiver em uma entrega)
            if (e.getMessage().contains("foreign key constraint")) {
                request.setAttribute("erro", "Não é possível excluir o produto. Ele está associado a uma ou mais entregas.");
            } else {
                request.setAttribute("erro", "Erro ao remover produto: " + e.getMessage());
            }
            request.getRequestDispatcher("/WEB-INF/views/erro.jsp")
                   .forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("erro", "Erro inesperado ao remover produto.");
            request.getRequestDispatcher("/WEB-INF/views/erro.jsp")
                   .forward(request, response);
        }
    }
}
