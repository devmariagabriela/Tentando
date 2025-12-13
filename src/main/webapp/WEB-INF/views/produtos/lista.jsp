<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Produtos - Tartaruga Cometa</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
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
        <div class="card">
            <h2>Produtos Cadastrados</h2>

            <c:if test="${param.sucesso == 'true'}">
                <div class="alert alert-success">
                    Produto cadastrado com sucesso!
                </div>
            </c:if>

            <div style="margin-bottom: 20px;">
                <a href="${pageContext.request.contextPath}/produtos?acao=novo" class="btn btn-primary">+ Novo Produto</a>
            </div>

            <c:choose>
                <c:when test="${not empty produtos}">
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Nome</th>
                                <th>Descrição</th>
                                <th>Peso (kg )</th>
                                <th>Volume (m³)</th>
                                <th>Valor Unitário</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="produto" items="${produtos}">
                                <tr>
                                    <td>${produto.id}</td>
                                    <td><strong>${produto.nome}</strong></td>
                                    <td>${produto.descricao}</td>
                                    <td><fmt:formatNumber value="${produto.pesoKg}" pattern="#,##0.00"/></td>
                                    <td><fmt:formatNumber value="${produto.volumeM3}" pattern="#,##0.000"/></td>
                                    <td>R$ <fmt:formatNumber value="${produto.valorUnitario}" pattern="#,##0.00"/></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <p>Nenhum produto cadastrado ainda.</p>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <footer>
        <p>&copy; 2025 Tartaruga Cometa - Sistema de Controle de Entregas</p>
    </footer>
</body>
</html>