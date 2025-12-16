package controller;

import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;
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


@WebServlet("/entregas/nova"  )
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
        
        Integer entregaId = null;
        boolean entregaSalva = false;
        
        try {
            // Cada entrega tem que ter um codigo, e esse codigo é unico, esse comando faz isso:
        	
            String codigo = "ENT-" + UUID.randomUUID().toString().substring(0, 8).toUpperCase();
            
            
            // Função auxiliar para parsear Integer com segurança
            Integer remetenteId = parseInteger(request.getParameter("remetenteId"), "Remetente");
            Integer destinatarioId = parseInteger(request.getParameter("destinatarioId"), "Destinatário");
            Integer enderecoOrigemId = parseInteger(request.getParameter("enderecoOrigemId"), "Endereço de Origem");
            Integer enderecoDestinoId = parseInteger(request.getParameter("enderecoDestinoId"), "Endereço de Destino");
            
            // Validação de Data
            String dataColetaStr = request.getParameter("dataColeta");
            LocalDate dataColeta = null;
            if (dataColetaStr != null && !dataColetaStr.isEmpty()) {
                dataColeta = LocalDate.parse(dataColetaStr);
            } else {
                throw new IllegalArgumentException("Data de Coleta é obrigatória.");
            }
            
            String dataEntregaPrevistaStr = request.getParameter("dataEntregaPrevista");
            LocalDate dataEntregaPrevista = null;
            if (dataEntregaPrevistaStr != null && !dataEntregaPrevistaStr.isEmpty()) {
                dataEntregaPrevista = LocalDate.parse(dataEntregaPrevistaStr);
            } else {
                throw new IllegalArgumentException("Data de Entrega Prevista é obrigatória.");
            }
            
            // Validação de Double
            
            Double valorFrete = parseDouble(request.getParameter("valorFrete"), "Valor do Frete");
            
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
            
            System.out.println("Salvando entrega no banco de dados...");
            entregaId = entregaDAO.salvar(entrega);
            entregaSalva = true;
            System.out.println("Entrega salva com sucesso! ID: " + entregaId);
            
            //Esse comando ele vai capturar os itens da entrega (no caso os meus produtos)
            
            String[] produtoIds = request.getParameterValues("produtoId");
            String[] quantidades = request.getParameterValues("quantidade");
            
            if (produtoIds != null && quantidades != null) {
                System.out.println("Salvando " + produtoIds.length + " itens da entrega...");
                for (int i = 0; i < produtoIds.length; i++) {
                    
                    // Tratamento de parâmetros para itens
                    Integer produtoId = parseInteger(produtoIds[i], "Produto ID");
                    Integer quantidade = parseInteger(quantidades[i], "Quantidade");
                    
                    // Pra que tenha o valor total eu tenho que ter os produtos, esse comando ele busca o produto
                    
                    Produto produto = produtoDAO.buscarPorId(produtoId);
                    if (produto == null) {
                        throw new IllegalArgumentException("Produto com ID " + produtoId + " não encontrado.");
                    }
                    
                    
                    //  É ai que eu crio o item da entrega
                    
                    ItemEntrega item = new ItemEntrega();
                    item.setEntregaId(entregaId);
                    item.setProdutoId(produtoId);
                    item.setQuantidade(quantidade);
                    
                    itemEntregaDAO.salvar(item);
                    System.out.println("Item " + (i+1) + " salvo com sucesso!");
                }
            }
            
            // Coloquei esse aqui pra confirmar o cadastro, se ele for bem sucedido
            
            System.out.println("Cadastro completo! Redirecionando para lista...");
            response.sendRedirect(request.getContextPath() + "/entregas/listar?sucesso=true");
            
        } catch (IllegalArgumentException | DateTimeParseException e) {
        	
            // Captura erro de validação e de formato de data
        	
            System.err.println("Erro de validação: " + e.getMessage());
            e.printStackTrace();
            
            request.setAttribute("erro", e.getMessage());
            
            // Carrega listas novamente para o formulário
            
            try {
                request.setAttribute("clientes", clienteDAO.listarTodos());
                request.setAttribute("produtos", produtoDAO.listarTodos());
            } catch (SQLException sqle) {
                System.err.println("Erro ao recarregar listas: " + sqle.getMessage());
            }
            
            // Volta para o formulário
            
            request.getRequestDispatcher("/WEB-INF/views/entregas/form.jsp")
                   .forward(request, response);
                   
        } catch (SQLException e) {
        	
            // Erro de banco de dados
        	
            System.err.println("Erro SQL: " + e.getMessage());
            e.printStackTrace();
            
            String mensagemErro = "Erro ao cadastrar entrega no banco de dados: " + e.getMessage();
            
            if (entregaSalva) {
                mensagemErro = "A entrega foi salva, mas houve erro ao salvar os itens: " + e.getMessage();
            }
            
            request.setAttribute("erro", mensagemErro);
            request.getRequestDispatcher("/WEB-INF/views/erro.jsp")
                   .forward(request, response);
                   
        } catch (Exception e) {
        	
            // Qualquer outro erro
        	
            System.err.println("Erro inesperado: " + e.getMessage());
            e.printStackTrace();
            
            String mensagemErro = "Erro inesperado ao processar dados: " + e.getMessage();
            
            if (entregaSalva) {
                mensagemErro = "A entrega foi salva (ID: " + entregaId + "), mas houve um erro posterior. " +
                              "Verifique a lista de entregas. Erro: " + e.getMessage();
            }
            
            request.setAttribute("erro", mensagemErro);
            request.getRequestDispatcher("/WEB-INF/views/erro.jsp")
                   .forward(request, response);
        }
    }

    
    private Integer parseInteger(String value, String fieldName) {
        if (value == null || value.trim().isEmpty()) {
            throw new IllegalArgumentException(fieldName + " é obrigatório.");
        }
        try {
            return Integer.parseInt(value.trim());
        } catch (NumberFormatException e) {
            throw new IllegalArgumentException("O valor para " + fieldName + " deve ser um número inteiro válido.");
        }
    }
    
    private Double parseDouble(String value, String fieldName) {
        if (value == null || value.trim().isEmpty()) {
            throw new IllegalArgumentException(fieldName + " é obrigatório.");
        }
        try {
            return Double.parseDouble(value.trim().replace(',', '.'));
        } catch (NumberFormatException e) {
            throw new IllegalArgumentException("O valor para " + fieldName + " deve ser um número decimal válido.");
        }
    }

	public EnderecoDAO getEnderecoDAO() {
		return enderecoDAO;
	}

	public void setEnderecoDAO(EnderecoDAO enderecoDAO) {
		this.enderecoDAO = enderecoDAO;
	}
}