package controller;

import java.awt.List;
import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.EntregaDAO;

@WebServlet("/entregas/listar")
public class ListarEntregasServlet extends HttpServlet {
    
    private EntregaDAO entregaDAO = new EntregaDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            // Verifica se há filtro por status
        	
            String statusFiltro = request.getParameter("status");
            List entregas;
            
            if (statusFiltro != null && !statusFiltro.isEmpty()) {
                entregas = (List) entregaDAO.listarPorStatus(statusFiltro);
            } else {
                entregas = (List) entregaDAO.listarTodas();
            }
            
            // Adiciona a lista na requisição
            
            request.setAttribute("entregas", entregas);
            request.setAttribute("statusFiltro", statusFiltro);
            
            // Encaminha para a página JSP
            
            request.getRequestDispatcher("/WEB-INF/views/entregas/listar.jsp")
                   .forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("erro", "Erro ao listar entregas: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/erro.jsp")
                   .forward(request, response);
        }
    }
}
