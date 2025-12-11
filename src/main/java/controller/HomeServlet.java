package controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.EntregaDAO;
import model.Entrega;

@WebServlet(urlPatterns = {"", "/"})
public class HomeServlet extends HttpServlet {
    
    private static final long serialVersionUID = 1L;
	private EntregaDAO entregaDAO = new EntregaDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            // Pra que isso funcione precisa de dados, ent coloquei isso aqui pra fazer a busca de dados para o meu dashboard
        	
            List<Entrega> todasEntregas = entregaDAO.listarTodas();
            List<Entrega> entregasPendentes = entregaDAO.listarPorStatus("PENDENTE");
            List<Entrega> entregasEmTransito = entregaDAO.listarPorStatus("EM_TRANSITO");
            List<Entrega> entregasRealizadas = entregaDAO.listarPorStatus("REALIZADA");
            
            // E ai preciso que seja adicionado os atributos nas minhas requisiçoes, usei o set	:
            
            request.setAttribute("totalEntregas", todasEntregas.size());
            request.setAttribute("totalPendentes", entregasPendentes.size());
            request.setAttribute("totalEmTransito", entregasEmTransito.size());
            request.setAttribute("totalRealizadas", entregasRealizadas.size());
            request.setAttribute("ultimasEntregas", todasEntregas.subList(0, Math.min(5, todasEntregas.size())));
            
            // Agora vou usar um get para encaminhar tudo para a página inicial
            
            request.getRequestDispatcher("/WEB-INF/views/home.jsp")
                   .forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("erro", "Erro ao carregar dashboard: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/erro.jsp")
                   .forward(request, response);
        }
    }
}
