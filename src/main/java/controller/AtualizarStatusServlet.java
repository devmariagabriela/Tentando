package controller;

import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List; // NOVO

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.EntregaDAO;
import dao.ItemEntregaDAO; // NOVO
import model.Entrega;
import model.ItemEntrega; // NOVO
import bo.ProdutoBO; // NOVO

@WebServlet("/entregas/atualizar-status"  )
public class AtualizarStatusServlet extends HttpServlet {
    
    private static final long serialVersionUID = 1L;
	private EntregaDAO entregaDAO = new EntregaDAO();
    private ItemEntregaDAO itemEntregaDAO = new ItemEntregaDAO(); // NOVO
    private ProdutoBO produtoBO = new ProdutoBO(); // NOVO
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        
        try {
            Integer entregaId = Integer.parseInt(request.getParameter("entregaId"));
            String novoStatus = request.getParameter("status");
            
            
            Entrega entrega = entregaDAO.buscarPorId(entregaId);
            
            if (entrega != null) {
                
                String statusAnterior = entrega.getStatus(); 
                entrega.setStatus(novoStatus);
                
                
                if ("REALIZADA".equals(novoStatus)) {
                    entrega.setDataEntregaRealizada(LocalDate.now());
                } else if ("CANCELADA".equals(novoStatus)) {
                	
                	
                    entrega.setDataEntregaRealizada(null);
                    
                    if (!"CANCELADA".equals(statusAnterior)) { // Usa o statusAnterior
                        List<ItemEntrega> itens = itemEntregaDAO.listarPorEntrega(entregaId);
                        for (ItemEntrega item : itens) {
                            produtoBO.atualizarEstoque(item.getProdutoId(), item.getQuantidade());
                        }
                        System.out.println("Estoque reposto para a entrega cancelada ID: " + entregaId);
                    }
                }
                
                
                entregaDAO.atualizar(entrega);
                
                
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
            request.setAttribute("erro", "Erro de banco de dados ao atualizar status: " + e.getMessage());
            try {
                request.getRequestDispatcher("/WEB-INF/views/erro.jsp")
                       .forward(request, response);
            } catch (ServletException | IOException se) {
                se.printStackTrace();
            }
		}
    }
}