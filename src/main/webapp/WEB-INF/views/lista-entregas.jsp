<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List, model.Entrega" %>
<!DOCTYPE html>
<html>
<head>
    <title>Lista de Entregas</title>
</head>
<body>
    <h1>Entregas Cadastradas</h1>

    <a href="lancar-entrega">Nova Entrega</a>

    <table border="1" cellpadding="8">
        <tr>
            <th>Código</th>
            <th>Data Criação</th>
            <th>Data Prevista</th>
            <th>Status</th>
            <th>Valor Frete</th>
        </tr>

        <%
            List<Entrega> entregas = (List<Entrega>) request.getAttribute("entregas");
            if (entregas != null && !entregas.isEmpty()) {
                for (Entrega e : entregas) {
        %>
        <tr>
            <td><%= e.getCodigoRastreio() %></td>
            <td><%= e.getDataCriacao() %></td>
            <td><%= e.getDataPrevistaEntrega() %></td>
            <td><%= e.getStatus() %></td>
            <td>R$ <%= String.format("%.2f", e.getValorFrete()) %></td>
        </tr>
        <%
                }
            } else {
        %>
        <tr>
            <td colspan="5">Nenhuma entrega cadastrada.</td>
        </tr>
        <% } %>
    </table>
</body>
</html>