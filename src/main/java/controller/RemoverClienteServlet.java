package controller;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.ClienteDAO;

@WebServlet("/clientes/remover" )
public class RemoverClienteServlet extends HttpServlet {
    
    private static final long serialVersionUID = 1L;
    private ClienteDAO clienteDAO = new ClienteDAO(); // Chamando o DAO diretamente

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String idParam = request.getParameter("id");
        
        if (idParam == null || idParam.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/clientes?erro=id_invalido");
            return;
        }
        
        try {
            Integer id = Integer.parseInt(idParam);
            
            // Lógica de remoção: Servlet chama diretamente o DAO
            
            clienteDAO.deletar(id);
            
            // Redireciona para a lista de clientes com mensagem de sucessooooooooooo
            
            response.sendRedirect(request.getContextPath() + "/clientes?sucesso=removido");
            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/clientes?erro=id_invalido");
        } catch (SQLException e) {
            e.printStackTrace();
            
            // Redireciona para a lista de clientes com mensagem de errooooooooooo

            response.sendRedirect(request.getContextPath() + "/clientes?erro=falha_remocao");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/clientes?erro=falha_remocao");
        }
    }
}