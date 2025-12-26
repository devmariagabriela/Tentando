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

@WebServlet("/clientes" )
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
                request.getRequestDispatcher("/WEB-INF/views/clientes/form.jsp").forward(request, response);
            } else if ("editar".equals(acao)) {
                String idParam = request.getParameter("id");
                if (idParam != null && !idParam.isEmpty()) {
                    Integer id = Integer.parseInt(idParam);
                    Cliente cliente = clienteDAO.buscarPorId(id);
                    if (cliente != null) {
                        request.setAttribute("cliente", cliente);
                        request.getRequestDispatcher("/WEB-INF/views/clientes/form.jsp").forward(request, response);
                        return;
                    }
                }
                response.sendRedirect(request.getContextPath() + "/clientes?erro=cliente_nao_encontrado");
            } else {
                List<Cliente> clientes = clienteDAO.listarTodos();
                request.setAttribute("clientes", clientes);
                request.getRequestDispatcher("/WEB-INF/views/clientes/listar.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("erro", "Erro ao processar requisição: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/erro.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        
        try {
            // Captura dados do endereço
            String cep = request.getParameter("cep");
            String logradouro = request.getParameter("logradouro");
            String numero = request.getParameter("numero");
            String bairro = request.getParameter("bairro");
            String cidade = request.getParameter("cidade");
            String estado = request.getParameter("estado");
            
            Endereco endereco = new Endereco();
            endereco.setCep(cep);
            endereco.setLogradouro(logradouro);
            endereco.setNumero(numero);
            endereco.setBairro(bairro);
            endereco.setCidade(cidade);
            endereco.setEstado(estado);
            
            // Captura dados do cliente
            String nome = request.getParameter("nome");
            String tipoDocForm = request.getParameter("tipoDocumento");
            String documentoRaw = request.getParameter("documento");
            String email = request.getParameter("email");
            String telefone = request.getParameter("telefone");

            // Converte para o formato do banco
            String tipoParaBanco = "CNPJ".equalsIgnoreCase(tipoDocForm) ? "J" : "F";
            String documentoLimpo = (documentoRaw != null) ? documentoRaw.replaceAll("\\D", "") : "";

            if (nome == null || nome.trim().isEmpty() || documentoLimpo.isEmpty()) {
                request.setAttribute("erro", "Nome e Documento são obrigatórios!");
                request.getRequestDispatcher("/WEB-INF/views/clientes/form.jsp").forward(request, response);
                return;
            }

            Cliente cliente = new Cliente();
            cliente.setNome(nome);
            cliente.setTipoDocumento(tipoParaBanco);
            cliente.setDocumento(documentoLimpo);
            cliente.setEmail(email);
            cliente.setTelefone(telefone);

            String clienteIdParam = request.getParameter("clienteId");
            String enderecoIdParam = request.getParameter("enderecoId");

            if (clienteIdParam != null && !clienteIdParam.isEmpty()) {
                // Edição
                Integer clienteId = Integer.parseInt(clienteIdParam);
                Integer enderecoId = Integer.parseInt(enderecoIdParam);
                endereco.setId(enderecoId);
                enderecoDAO.atualizar(endereco);
                cliente.setId(clienteId);
                cliente.setEnderecoId(enderecoId);
                clienteDAO.atualizar(cliente);
                response.sendRedirect(request.getContextPath() + "/clientes?sucesso=editado");
            } else {
                // Novo Cadastro
                Integer enderecoIdNovo = enderecoDAO.salvar(endereco); 
                cliente.setEnderecoId(enderecoIdNovo);
                clienteDAO.salvar(cliente);
                response.sendRedirect(request.getContextPath() + "/clientes?sucesso=true");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("erro", "Erro ao processar dados: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/erro.jsp").forward(request, response);
        }
    }
}
