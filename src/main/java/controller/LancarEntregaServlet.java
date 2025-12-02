package controller;

import dao.*;
import model.Entrega;
import model.Produto;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;

@WebServlet("/lancar-entrega")
public class LancarEntregaServlet extends HttpServlet {

    private ProdutoDAO produtoDAO = new ProdutoDAO();
    private EntregaDAO entregaDAO = new EntregaDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            List<Produto> produtos = produtoDAO.listarTodos();
            request.setAttribute("produtos", produtos);

            request.getRequestDispatcher("/WEB-INF/views/form-entrega.jsp")
                    .forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erro ao carregar produtos");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Criar entregaaaaaaaaaaaaaa
            Entrega entrega = new Entrega();
            entrega.setDataPrevistaEntrega(LocalDate.parse(request.getParameter("dataPrevista")));
            entrega.setValorFrete(Double.parseDouble(request.getParameter("valorFrete")));
            entrega.setObservacoes(request.getParameter("observacoes"));

            // Salvarrrrrrrrrr
            entregaDAO.salvar(entrega);

            // Redirecionarrrrrrrrrrrrrr
            response.sendRedirect("lista-entregas");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erro ao salvar entrega");
        }
    }
}