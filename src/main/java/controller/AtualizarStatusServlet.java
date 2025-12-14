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

@WebServlet("/entregas/atualizar-status" )
public class AtualizarStatusServlet extends HttpServlet {
    
    private static final long serialVersionUID = 1L;
	private EntregaDAO entregaDAO = new EntregaDAO();
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        
        try {
            Integer entregaId = Integer.parseInt(request.getParameter("entregaId"));
            String novoStatus = request.getParameter("status");
            
            // Pra que a algo seja atualizado eu tenho que buscar, aquii ele vai buscar a entrega: 
            
            Entrega entrega = entregaDAO.buscarPorId(entregaId);
            
            if (entrega != null) {
                entrega.setStatus(novoStatus);
                
                // Se o status for REALIZADA, define a data de entrega realizada
                
                if ("REALIZADA".equals(novoStatus)) {
                    entrega.setDataEntregaRealizada(LocalDate.now());
                } else if ("CANCELADA".equals(novoStatus)) {
                    // Ao cancelar, remove a data de entrega realizada (se houver)
                    entrega.setDataEntregaRealizada(null);
                }
                
                // E é ai que entra a atualização:
                
                entregaDAO.atualizar(entrega);
                
                // Depois da atualização ele vai redirecionar de volta para a listagem, com os novos dados que foram alterados:
                
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
        } catch (SQLException e) {
			e.printStackTrace();
		}
    }
}
