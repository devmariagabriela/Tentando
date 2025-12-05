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
            	
                // Aqui eu to mexendo com os meus clientes, ent, preciso de um forms para por eles, meus novos clientes:
            	
                request.getRequestDispatcher("/WEB-INF/views/clientes/form.jsp")
                       .forward(request, response);
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
            
            Integer enderecoId = enderecoDAO.salvar(endereco); 
            
            // Aqui eu usei o get, pra que o sistema consiga capturar os dados da pessoa cliente:
            
            String tipoDocumento = request.getParameter("tipoDocumento");
            String documento = request.getParameter("documento");
            String nome = request.getParameter("nome");
            String telefone = request.getParameter("telefone");
            String email = request.getParameter("email");
            
            // E é ai que uso o set dnv, pra definir e salvar esses dados:
            
            Cliente cliente = new Cliente();
            cliente.setTipoDocumento(tipoDocumento);
            cliente.setDocumento(documento);
            cliente.setNome(nome);
            cliente.setTelefone(telefone);
            cliente.setEmail(email);
            cliente.setEnderecoId(enderecoId);
            
            clienteDAO.salvar(cliente);
            
            // Quando ja tiver esses dois dados no sistema, tem um comando que vai fazer com que seja direcionado para a listagem:
            
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
