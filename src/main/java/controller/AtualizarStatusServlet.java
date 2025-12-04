package controller;

import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.EntregaDAO;
import model.Entrega;

@WebServlet("/entregas/atualizar-status")
public class AtualizarStatusServlet extends HttpServlet {
    
    private EntregaDAO entregaDAO = new EntregaDAO();
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        
        try {
            Integer entregaId = Integer.parseInt(request.getParameter("entregaId"));
            String novoStatus = request.getParameter("status");
            
            // Busca a entrega
            Entrega entrega = entregaDAO.buscarPorId(entregaId);
            
            if (entrega != null) {
                entrega.setStatus(novoStatus);
                
                // Se o status for REALIZADA, define a data de entrega realizada
                if ("REALIZADA".equals(novoStatus)) {
                    entrega.setDataEntregaRealizada(LocalDate.now());
                }
                
                // Atualiza no banco
                entregaDAO.atualizar(entrega);
                
                // Redireciona de volta para a listagem
                response.sendRedirect(request.getContextPath() + "/entregas/listar?atualizado=true");
            } else {
                request.setAttribute("erro", "Entrega não encontrada!");
                request.getRequestDispatcher("/WEB-INF/views/erro.jsp")
                       .forward(request, response);
            }
            
        } catch (ServletException e) { 
            e.printStackTrace();
            request.setAttribute("erro", "Erro ao atualizar status: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/erro.jsp")
                   .forward(request, response);
        } catch (IOException e) {
            e.printStackTrace();
            request.setAttribute("erro", "Erro ao processar dados: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/erro.jsp")
                   .forward(request, response);
        }
    }
}
