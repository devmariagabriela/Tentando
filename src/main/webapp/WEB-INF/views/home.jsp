<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tartaruga Cometa - Sistema de Entregas</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style2.css">
</head>
<body>
    <header>
        <div class="container">
            <h1> Tartaruga Cometa</h1>
            <p>Sistema de Controle de Entregas</p>
        </div>
    </header>

    <nav>
        <ul>
            <li><a href="${pageContext.request.contextPath}/">Dashboard</a></li>
            <li><a href="${pageContext.request.contextPath}/entregas/listar">Entregas</a></li>
            <li><a href="${pageContext.request.contextPath}/clientes">Clientes</a></li>
            <li><a href="${pageContext.request.contextPath}/produtos">Produtos</a></li>  
        </ul>
    </nav>

    <div class="container">
        <h2 style="color: #667eea; margin-bottom: 30px;">Dashboard</h2>

        <div class="dashboard-stats">
            <div class="stat-card">
                <p>Total de Entregas</p>
                <h3>${totalEntregas}</h3>
            </div>
            <div class="stat-card">
                <p>Pendentes</p>
                <h3 style="color: #ed8936;">${totalPendentes}</h3>
            </div>
            <div class="stat-card">
                <p>Em Trânsito</p>
                <h3 style="color: #3182ce;">${totalEmTransito}</h3>
            </div>
            <div class="stat-card">
                <p>Realizadas</p>
                <h3 style="color: #48bb78;">${totalRealizadas}</h3>
            </div>
        </div>

        <div class="card">
            <h2>Últimas Entregas</h2>
            <c:choose>
                <c:when test="${not empty ultimasEntregas}">
                    <table>
                        <thead>
                            <tr>
                                <th>Código</th>
                                <th>Remetente</th>
                                <th>Destinatário</th>
                                <th>Data Coleta</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="entrega" items="${ultimasEntregas}">
                                <tr>
                                    <td><strong>${entrega.codigo}</strong></td>
                                    <td>${entrega.remetente.nome}</td>
                                    <td>${entrega.destinatario.nome}</td>
                                    <td>${entrega.dataColeta}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${entrega.status == 'PENDENTE'}">
                                                <span class="badge badge-pendente">Pendente</span>
                                            </c:when>
                                            <c:when test="${entrega.status == 'EM_TRANSITO'}">
                                                <span class="badge badge-em-transito">Em Trânsito</span>
                                            </c:when>
                                            <c:when test="${entrega.status == 'REALIZADA'}">
                                                <span class="badge badge-realizada">Realizada</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge badge-cancelada">Cancelada</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <p>Nenhuma entrega cadastrada ainda.</p>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <footer>
        <p> Tartaruga cometa - Sistemas de entrega</p>
           <p> </p>
    </footer>
</body>
</html>