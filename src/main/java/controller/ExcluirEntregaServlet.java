package controller;

import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import dao.EntregaDAO;
import dao.ItemEntregaDAO;

@WebServlet("/entregas/excluir" )
public class ExcluirEntregaServlet extends HttpServlet {
    
    private static final long serialVersionUID = 1L;
    private EntregaDAO entregaDAO = new EntregaDAO();
    private ItemEntregaDAO itemEntregaDAO = new ItemEntregaDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        
        String idParam = request.getParameter("id");
        
        if (idParam == null || idParam.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/entregas/listar?erro=id_invalido");
            return;
        }
        
        try {
            Integer id = Integer.parseInt(idParam);
            
            itemEntregaDAO.deletarPorEntrega(id);
            
            entregaDAO.deletar(id);
            
            response.sendRedirect(request.getContextPath() + "/entregas/listar?removido=true");
            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/entregas/listar?erro=id_invalido");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/entregas/listar?erro=falha_sql");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/entregas/listar?erro=erro_geral");
        }
    }
}