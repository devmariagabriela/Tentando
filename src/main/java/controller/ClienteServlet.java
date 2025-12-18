package controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.ClienteDAO;
import dao.EnderecoDAO;
import model.Cliente;
import model.Endereco;

@WebServlet("/clientes"  )
public class ClienteServlet extends HttpServlet {
    
    private static final long serialVersionUID = 1L;
	private ClienteDAO clienteDAO = new ClienteDAO();
    private EnderecoDAO enderecoDAO = new EnderecoDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String acao = request.getParameter("acao");
        
        try {
            if ("novo".equals(acao)) {
            	
                // Aqui eu to mexendo com os meus clientes, ent, preciso de um forms para por eles, meus novos clientes:
            	
                request.getRequestDispatcher("/WEB-INF/views/clientes/form.jsp")
                       .forward(request, response);
            } else if ("editar".equals(acao)) {
            	
            	// Lógica para buscar o cliente a ser editado e carregar o formulário
            	
            	String idParam = request.getParameter("id");
            	if (idParam != null && !idParam.isEmpty()) {
            		Integer id = Integer.parseInt(idParam);
            		Cliente cliente = clienteDAO.buscarPorId(id);
            		if (cliente != null) {
            			request.setAttribute("cliente", cliente);
            			request.getRequestDispatcher("/WEB-INF/views/clientes/form.jsp")
            			       .forward(request, response);
            			return;
            		}
            	}
            	// Se o ID for inválido ou o cliente não for encontrado, redireciona para a lista
            
            	response.sendRedirect(request.getContextPath() + "/clientes?erro=cliente_nao_encontrado");
            	return;
            } else {
            	
                // Agora eu resolvi por uma list, pq  quando tiver os clientes, eu quero uma lista com todos eles:
            	
                List<Cliente> clientes = clienteDAO.listarTodos();
                request.setAttribute("clientes", clientes);
                request.getRequestDispatcher("/WEB-INF/views/clientes/listar.jsp")
                       .forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("erro", "Erro ao processar requisição: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/erro.jsp")
                   .forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        
        try {
            // Cada cliente tem o seu endereço, ai vou capturar os dados do endereço deles:
        	
            String cep = request.getParameter("cep");
            String logradouro = request.getParameter("logradouro");
            String numero = request.getParameter("numero");
            String complemento = request.getParameter("complemento");
            String bairro = request.getParameter("bairro");
            String cidade = request.getParameter("cidade");
            String estado = request.getParameter("estado");
            
            // Depois que eu tiver esses dados, o sistema vai ter que criar e salvar esses endereços, ai coloquei um set pra definir eles:
            
            Endereco endereco = new Endereco();
            endereco.setCep(cep);
            endereco.setLogradouro(logradouro);
            endereco.setNumero(numero);
            endereco.setComplemento(complemento);
            endereco.setBairro(bairro);
            endereco.setCidade(cidade);
            endereco.setEstado(estado);
            
            // Aqui eu usei o get, pra que o sistema consiga capturar os dados da pessoa cliente:
            
            String tipoDocumento = request.getParameter("tipoDocumento");
            String documento = request.getParameter("documento");
            String nome = request.getParameter("nome");
            String telefone = request.getParameter("telefone");
            String email = request.getParameter("email");

            // --- INICIO DA VALIDAÇÃO DE TAMANHO E TIPO ---
            String erroValidacao = null;

            // 1. Validação de Nome (Máx 20, Apenas Letras e Espaços)
            if (nome != null) {
                if (nome.length() > 20) {
                    erroValidacao = "O campo Nome não pode ter mais de 20 caracteres.";
                } else if (!nome.matches("[a-zA-ZáàâãéèêíïóôõöúçñÁÀÂÃÉÈÊÍÏÓÔÕÖÚÇÑ ]+")) {
                    erroValidacao = "O campo Nome deve conter apenas letras e espaços.";
                }
            }
            
            // 2. Validação de Email (Máx 20)
            if (erroValidacao == null && email != null && email.length() > 20) {
                erroValidacao = "O campo E-mail não pode ter mais de 20 caracteres.";
            }

            // 3. Validação de Documento (CPF/CNPJ) (Máx 14/18, Apenas Números e Máscara)
            if (erroValidacao == null && tipoDocumento != null && documento != null) {
                if ("CPF".equalsIgnoreCase(tipoDocumento) && documento.length() > 14) {
                    erroValidacao = "O campo CPF não pode ter mais de 14 caracteres (incluindo pontos e traço).";
                } else if ("CNPJ".equalsIgnoreCase(tipoDocumento) && documento.length() > 18) {
                    erroValidacao = "O campo CNPJ não pode ter mais de 18 caracteres (incluindo pontos, barra e traço).";
                }
                
                // Validação de tipo (Apenas números e caracteres de máscara)
                if (erroValidacao == null && !documento.matches("[0-9./-]+")) {
                    erroValidacao = "O campo Documento (CPF/CNPJ) deve conter apenas números e a máscara correta.";
                }
            }
            
            // 4. Validação de Telefone (Máx 15, Apenas Números e Máscara)
            if (erroValidacao == null && telefone != null && !telefone.isEmpty()) {
                if (telefone.length() > 15) {
                    erroValidacao = "O campo Telefone não pode ter mais de 15 caracteres.";
                }
                // Validação de tipo (Apenas números e caracteres de máscara)
                if (erroValidacao == null && !telefone.matches("[0-9()\\- ]+")) {
                    erroValidacao = "O campo Telefone deve conter apenas números e a máscara correta.";
                }
            }
            
            // 5. Validação de CEP (Máx 9, Apenas Números e Traço)
            if (erroValidacao == null && cep != null && !cep.isEmpty()) {
                if (cep.length() > 9) {
                    erroValidacao = "O campo CEP não pode ter mais de 9 caracteres (incluindo o traço).";
                }
                // Validação de tipo (Apenas números e traço)
                if (erroValidacao == null && !cep.matches("[0-9-]+")) {
                    erroValidacao = "O campo CEP deve conter apenas números e o traço.";
                }
            }
            
            // 6. Validação de Número (Endereço) (Máx 5, Alfanumérico)
            if (erroValidacao == null && numero != null && numero.length() > 5) {
                erroValidacao = "O campo Número do Endereço não pode ter mais de 5 caracteres.";
            }
            
            // 7. Validação de Logradouro (Máx 20, Alfanumérico)
            if (erroValidacao == null && logradouro != null && logradouro.length() > 20) {
                erroValidacao = "O campo Logradouro não pode ter mais de 20 caracteres.";
            }
            
            // 8. Validação de Complemento (Máx 20, Alfanumérico)
            if (erroValidacao == null && complemento != null && complemento.length() > 20) {
                erroValidacao = "O campo Complemento não pode ter mais de 20 caracteres.";
            }
            
            // 9. Validação de Bairro (Máx 10, Alfanumérico)
            if (erroValidacao == null && bairro != null && bairro.length() > 10) {
                erroValidacao = "O campo Bairro não pode ter mais de 10 caracteres.";
            }
            
            // 10. Validação de Cidade (Máx 10, Alfanumérico)
            if (erroValidacao == null && cidade != null && cidade.length() > 10) {
                erroValidacao = "O campo Cidade não pode ter mais de 10 caracteres.";
            }

            if (erroValidacao != null) {
                // Se houver erro, define o atributo de erro e retorna para o formulário
                request.setAttribute("erro", erroValidacao);
                
                // Recria os objetos com os dados preenchidos para que o formulário possa ser recarregado
                // Endereco já foi criado e preenchido (L93-L101)
                
                Cliente cliente = new Cliente();
                cliente.setTipoDocumento(tipoDocumento);
                cliente.setDocumento(documento);
                cliente.setNome(nome);
                cliente.setTelefone(telefone);
                cliente.setEmail(email);
                cliente.setEndereco(endereco); // Adiciona o objeto Endereco ao Cliente
                
                // Se for edição, tenta recuperar os IDs para manter o estado
                String clienteIdParam = request.getParameter("clienteId");
                String enderecoIdParam = request.getParameter("enderecoId");
                if (clienteIdParam != null && !clienteIdParam.isEmpty()) {
                    try {
                        cliente.setId(Integer.parseInt(clienteIdParam));
                    } catch (NumberFormatException ignored) {}
                }
                if (enderecoIdParam != null && !enderecoIdParam.isEmpty()) {
                    try {
                        cliente.setEnderecoId(Integer.parseInt(enderecoIdParam));
                        endereco.setId(Integer.parseInt(enderecoIdParam));
                    } catch (NumberFormatException ignored) {}
                }
                
                request.setAttribute("cliente", cliente);
                request.setAttribute("endereco", endereco);
                
                request.getRequestDispatcher("/WEB-INF/views/clientes/form.jsp")
                       .forward(request, response);
                return;
            }
            // --- FIM DA VALIDAÇÃO DE TAMANHO E TIPO ---
            
            // Verifica se é uma edição (UPDATE) ou um novo cadastro (INSERT)
            String clienteIdParam = request.getParameter("clienteId");
            String enderecoIdParam = request.getParameter("enderecoId");
            
            Cliente cliente = new Cliente();
            
            if (clienteIdParam != null && !clienteIdParam.isEmpty() && enderecoIdParam != null && !enderecoIdParam.isEmpty()) {
            
            	// É uma edição (UPDATE)
            	Integer clienteId = Integer.parseInt(clienteIdParam);
            	Integer enderecoIdExistente = Integer.parseInt(enderecoIdParam);
            	
            	cliente.setId(clienteId);
            	cliente.setEnderecoId(enderecoIdExistente); // Mantém o ID do endereço existente
            	
            	// Atualiza o endereço
            	endereco.setId(enderecoIdExistente);
            	enderecoDAO.atualizar(endereco);
            	
            	// Atualiza o cliente
            	cliente.setTipoDocumento(tipoDocumento);
            	cliente.setDocumento(documento);
            	cliente.setNome(nome);
            	cliente.setTelefone(telefone);
            	cliente.setEmail(email);
            	
            	clienteDAO.atualizar(cliente);
            	
            	// Quando ja tiver esses dois dados no sistema, tem um comando que vai fazer com que seja direcionado para a listagem:
            	response.sendRedirect(request.getContextPath() + "/clientes?sucesso=editado");
            	
            } else {
            	
            	
            	// E é ai que uso o set dnv, pra definir e salvar esses dados:
            	
            	Integer enderecoIdNovo = enderecoDAO.salvar(endereco); 
            	
            	cliente.setTipoDocumento(tipoDocumento);
            	cliente.setDocumento(documento);
            	cliente.setNome(nome);
            	cliente.setTelefone(telefone);
            	cliente.setEmail(email);
            	cliente.setEnderecoId(enderecoIdNovo);
            	
            	clienteDAO.salvar(cliente);
            	
            	// Quando ja tiver esses dois dados no sistema, tem um comando que vai fazer com que seja direcionado para a listagem:
            	
            	response.sendRedirect(request.getContextPath() + "/clientes?sucesso=true");
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("erro", "Erro ao cadastrar cliente: " + e.getMessage());
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