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

@WebServlet("/clientes")
public class ClienteServlet extends HttpServlet {
    
    private ClienteDAO clienteDAO = new ClienteDAO();
    private EnderecoDAO enderecoDAO = new EnderecoDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String acao = request.getParameter("acao");
        
        try {
            if ("novo".equals(acao)) {
                // Exibe formulário de novo cliente
                request.getRequestDispatcher("/WEB-INF/views/clientes/form.jsp")
                       .forward(request, response);
            } else {
                // Lista todos os clientes
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
            // Captura dados do endereço
            String cep = request.getParameter("cep");
            String logradouro = request.getParameter("logradouro");
            String numero = request.getParameter("numero");
            String complemento = request.getParameter("complemento");
            String bairro = request.getParameter("bairro");
            String cidade = request.getParameter("cidade");
            String estado = request.getParameter("estado");
            
            // Cria e salva o endereço
            Endereco endereco = new Endereco();
            endereco.setCep(cep);
            endereco.setLogradouro(logradouro);
            endereco.setNumero(numero);
            endereco.setComplemento(complemento);
            endereco.setBairro(bairro);
            endereco.setCidade(cidade);
            endereco.setEstado(estado);
            
            Integer enderecoId = enderecoDAO.salvar(endereco);
            
            // Captura dados do cliente
            String tipoDocumento = request.getParameter("tipoDocumento");
            String documento = request.getParameter("documento");
            String nome = request.getParameter("nome");
            String telefone = request.getParameter("telefone");
            String email = request.getParameter("email");
            
            // Cria e salva o cliente
            Cliente cliente = new Cliente();
            cliente.setTipoDocumento(tipoDocumento);
            cliente.setDocumento(documento);
            cliente.setNome(nome);
            cliente.setTelefone(telefone);
            cliente.setEmail(email);
            cliente.setEnderecoId(enderecoId);
            
            clienteDAO.salvar(cliente);
            
            // Redireciona para a listagem
            response.sendRedirect(request.getContextPath() + "/clientes?sucesso=true");
            
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
