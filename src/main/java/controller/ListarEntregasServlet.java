package controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.EntregaDAO;
import model.Entrega;

@WebServlet("/entregas/listar")
public class ListarEntregasServlet extends HttpServlet {
    
    private static final long serialVersionUID = 1L;
	private EntregaDAO entregaDAO = new EntregaDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
        	
            String statusFiltro = request.getParameter("status");
            ArrayList<Entrega> entregas = new ArrayList<Entrega>();
            
            if (statusFiltro != null && !statusFiltro.isEmpty()) {
                entregas =  (ArrayList<Entrega>) entregaDAO.listarPorStatus(statusFiltro);
            } else {
                entregas =  (ArrayList<Entrega>) entregaDAO.listarTodas();
            }
            
            
            request.setAttribute("entregas", entregas);
            request.setAttribute("statusFiltro", statusFiltro);
            
            
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