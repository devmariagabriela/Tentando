package controller;

import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.ClienteDAO;
import dao.EnderecoDAO;
import dao.EntregaDAO;
import dao.ItemEntregaDAO;
import dao.ProdutoDAO;
import model.Cliente;
import model.Entrega;
import model.ItemEntrega;
import model.Produto;

@WebServlet("/entregas/nova")
public class NovaEntregaServlet extends HttpServlet {
    
    private ClienteDAO clienteDAO = new ClienteDAO();
    private ProdutoDAO produtoDAO = new ProdutoDAO();
    private EntregaDAO entregaDAO = new EntregaDAO();
    private EnderecoDAO enderecoDAO = new EnderecoDAO();
    private ItemEntregaDAO itemEntregaDAO = new ItemEntregaDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            // Carrega listas para os selects do formulário
            List<Cliente> clientes = clienteDAO.listarTodos();
            List<Produto> produtos = produtoDAO.listarTodos();
            
            request.setAttribute("clientes", clientes);
            request.setAttribute("produtos", produtos);
            
            // Encaminha para o formulário
            request.getRequestDispatcher("/WEB-INF/views/entregas/form.jsp")
                   .forward(request, response);
            
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("erro", "Erro ao carregar formulário: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/erro.jsp")
                   .forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        
        try {
            // Gera código único para a entrega
        	
            String codigo = "ENT-" + UUID.randomUUID().toString().substring(0, 8).toUpperCase();
            
            // Captura dados da entrega
            
            Integer remetenteId = Integer.parseInt(request.getParameter("remetenteId"));
            Integer destinatarioId = Integer.parseInt(request.getParameter("destinatarioId"));
            Integer enderecoOrigemId = Integer.parseInt(request.getParameter("enderecoOrigemId"));
            Integer enderecoDestinoId = Integer.parseInt(request.getParameter("enderecoDestinoId"));
            LocalDate dataColeta = LocalDate.parse(request.getParameter("dataColeta"));
            LocalDate dataEntregaPrevista = LocalDate.parse(request.getParameter("dataEntregaPrevista"));
            Double valorFrete = new Double(request.getParameter("valorFrete"));
            String observacoes = request.getParameter("observacoes");
            
            // Cria objeto Entrega
            
            Entrega entrega = new Entrega();
            entrega.setCodigo(codigo);
            entrega.setRemetenteId(remetenteId);
            entrega.setDestinatarioId(destinatarioId);
            entrega.setEnderecoOrigemId(enderecoOrigemId);
            entrega.setEnderecoDestinoId(enderecoDestinoId);
            entrega.setDataColeta(dataColeta);
            entrega.setDataEntregaPrevista(dataEntregaPrevista);
            entrega.setValorFrete(valorFrete);
            entrega.setObservacoes(observacoes);
            entrega.setStatus("PENDENTE");
            
            // Salva a entrega
            
            Integer entregaId = entregaDAO.salvar(entrega);
            
            // Captura itens da entrega (produtos)
            
            String[] produtoIds = request.getParameterValues("produtoId");
            String[] quantidades = request.getParameterValues("quantidade");
            
            if (produtoIds != null && quantidades != null) {
                for (int i = 0; i < produtoIds.length; i++) {
                    Integer produtoId = Integer.parseInt(produtoIds[i]);
                    Integer quantidade = Integer.parseInt(quantidades[i]);
                    
                    // Busca o produto para calcular valor total
                    
                    Produto produto = produtoDAO.buscarPorId(produtoId);
                    Double valorTotal = produto.getValorUnitario().multiply(new Double(quantidade));
                    
                    // Cria item da entrega
                    
                    ItemEntrega item = new ItemEntrega();
                    item.setEntregaId(entregaId);
                    item.setProdutoId(produtoId);
                    item.setQuantidade(quantidade);
                    item.setValorTotal(valorTotal);
                    
                    itemEntregaDAO.salvar(item);
                }
            }
            
            // Redireciona para a listagem com mensagem de sucesso
            
            response.sendRedirect(request.getContextPath() + "/entregas/listar?sucesso=true");
            
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("erro", "Erro ao cadastrar entrega: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/erro.jsp")
                   .forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("erro", "Erro ao processar dados: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/erro.jsp")
                   .forward(request, response);
        }
    }
}
