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
    private ClienteDAO clienteDAO = new ClienteDAO();

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
            clienteDAO.deletar(id);
            
            
            response.sendRedirect(request.getContextPath() + "/clientes?removido=true");
            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/clientes?erro=id_invalido");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/clientes?erro=falha_remocao");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/clientes?erro=falha_remocao");
        }
    }
}
