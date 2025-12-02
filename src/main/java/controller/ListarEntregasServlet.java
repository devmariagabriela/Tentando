package controller;

import dao.EntregaDAO;
import model.Entrega;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/lista-entregas")
public class ListarEntregasServlet extends HttpServlet {

    private EntregaDAO entregaDAO = new EntregaDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            List<Entrega> entregas = entregaDAO.listarTodas();
            request.setAttribute("entregas", entregas);

            request.getRequestDispatcher("/WEB-INF/views/lista-entregas.jsp")
                    .forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erro ao listar entregas");
        }
    }
}