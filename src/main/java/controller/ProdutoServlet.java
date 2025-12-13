package controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.ProdutoDAO;
import model.Produto;

@WebServlet("/produtos" )
public class ProdutoServlet extends HttpServlet {
    
    private static final long serialVersionUID = 1L;
	private ProdutoDAO produtoDAO = new ProdutoDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String acao = request.getParameter("acao");
        
        try {
            if ("novo".equals(acao)) {
            	
                // Aqui vai mostrar o formulário de novo produto
            	
                request.getRequestDispatcher("/WEB-INF/views/produtos/form.jsp")
                       .forward(request, response);
            } else {
                // E aqui vai listar todos os meus produtos
            	
                List<Produto> produtos = produtoDAO.listarTodos();
                request.setAttribute("produtos", produtos);
                
                // Debug: Verificar se a lista está vazia
                System.out.println("Produtos carregados: " + (produtos != null ? produtos.size() : "null"));
                
                request.getRequestDispatcher("/WEB-INF/views/produtos/lista.jsp")
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
            // Aqui vai ser pra ter os dados de cada produto
        	
            String nome = request.getParameter("nome");
            String descricao = request.getParameter("descricao");
            String pesoKgStr = request.getParameter("pesoKg");
            String volumeM3Str = request.getParameter("volumeM3");
            String valorUnitarioStr = request.getParameter("valorUnitario");
            
            // Validação dos dados
            if (nome == null || nome.trim().isEmpty()) {
                request.setAttribute("erro", "Nome do produto é obrigatório!");
                request.getRequestDispatcher("/WEB-INF/views/produtos/form.jsp")
                       .forward(request, response);
                return;
            }
            
            Double pesoKg = Double.parseDouble(pesoKgStr);
            Double volumeM3 = Double.parseDouble(volumeM3Str);
            Double valorUnitario = Double.parseDouble(valorUnitarioStr);
            
            // Cria e salva o produto
            
            Produto produto = new Produto();
            produto.setNome(nome);
            produto.setDescricao(descricao);
            produto.setPesoKg(pesoKg);
            produto.setVolumeM3(volumeM3);
            produto.setValorUnitario(valorUnitario);
            
            produtoDAO.salvar(produto);
            
            System.out.println("Produto salvo com sucesso: " + nome);
            
            // Esse aqui é o que vai redirecionar para a listagem dos produtos salvos
            
            response.sendRedirect(request.getContextPath() + "/produtos?sucesso=true");
            
        } catch (NumberFormatException e) {
            e.printStackTrace();
            request.setAttribute("erro", "Erro ao processar dados numéricos: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/erro.jsp")
                   .forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("erro", "Erro ao cadastrar produto: " + e.getMessage());
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