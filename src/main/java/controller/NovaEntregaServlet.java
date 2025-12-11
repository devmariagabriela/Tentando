package controller;

import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;
import java.util.UUID;

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
    
    private static final long serialVersionUID = 1L;
	private ClienteDAO clienteDAO = new ClienteDAO();
    private ProdutoDAO produtoDAO = new ProdutoDAO();
    private EntregaDAO entregaDAO = new EntregaDAO();
    private EnderecoDAO enderecoDAO = new EnderecoDAO();
    private ItemEntregaDAO itemEntregaDAO = new ItemEntregaDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            // Esse comando aqui ele vai carregar a  listas para os selects do meu formulário:
        	
            List<Cliente> clientes = clienteDAO.listarTodos();
            List<Produto> produtos = produtoDAO.listarTodos();
            
            request.setAttribute("clientes", clientes);
            request.setAttribute("produtos", produtos);
            
            // Ja esse, ele é o que encaminha para o meu formulario, no caso, o que envia:
            
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
            // Cada entrega tem que ter um codigo, e esse codigo é unico, esse comando faz isso:
        	
            String codigo = "ENT-" + UUID.randomUUID().toString().substring(0, 8).toUpperCase();
            
            // Depois tem que ter as informaçoes dessa entrega, coloquei um get aqui para obter os dados dela:
            
            Integer remetenteId = Integer.parseInt(request.getParameter("remetenteId"));
            Integer destinatarioId = Integer.parseInt(request.getParameter("destinatarioId"));
            Integer enderecoOrigemId = Integer.parseInt(request.getParameter("enderecoOrigemId"));
            Integer enderecoDestinoId = Integer.parseInt(request.getParameter("enderecoDestinoId"));
            LocalDate dataColeta = LocalDate.parse(request.getParameter("dataColeta"));
            LocalDate dataEntregaPrevista = LocalDate.parse(request.getParameter("dataEntregaPrevista"));
            Double valorFrete = new Double(request.getParameter("valorFrete"));
            String observacoes = request.getParameter("observacoes");
            
            // Preciso criar objeto Entrega, pra isso eu uso o set:
            
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
            
            // Aqui eu salvo a minha entrega:
            
            Integer entregaId = entregaDAO.salvar(entrega);
            
            //Esse comando ele vai capturar os itens da entrega (no caso os meus produtos)
            
            String[] produtoIds = request.getParameterValues("produtoId");
            String[] quantidades = request.getParameterValues("quantidade");
            
            if (produtoIds != null && quantidades != null) {
                for (int i = 0; i < produtoIds.length; i++) {
                    Integer produtoId = Integer.parseInt(produtoIds[i]);
                    Integer quantidade = Integer.parseInt(quantidades[i]);
                    
                    // Pra que tenha o valor total eu tenho que ter os produtos, esse comando ele busca o produto
                    
                    Produto produto = produtoDAO.buscarPorId(produtoId);
                    Double valorTotal = produto.getValorUnitario() * (new Double(quantidade));
                    
                    //  É ai que eu crio o item da entrega
                    
                    ItemEntrega item = new ItemEntrega();
                    item.setEntregaId(entregaId);
                    item.setProdutoId(produtoId);
                    item.setQuantidade(quantidade);
                    item.setValorTotal(valorTotal);
                    
                    itemEntregaDAO.salvar(item);
                }
            }
            
            // Coloquei esse aqui pra confirmar o cadastro, se ele for bem sucedido:
            
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

	public EnderecoDAO getEnderecoDAO() {
		return enderecoDAO;
	}

	public void setEnderecoDAO(EnderecoDAO enderecoDAO) {
		this.enderecoDAO = enderecoDAO;
	}
}
