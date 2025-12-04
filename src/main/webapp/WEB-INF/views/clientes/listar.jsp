<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Clientes - Tartaruga Cometa</title>
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
            <li><a href="${pageContext.request.contextPath}/entregas/nova">Nova Entrega</a></li>
            <li><a href="${pageContext.request.contextPath}/clientes">Clientes</a></li>
            <li><a href="${pageContext.request.contextPath}/produtos">Produtos</a></li>
        </ul>
    </nav>

    <div class="container">
        <div class="card">
            <h2>Clientes Cadastrados</h2>

            <c:if test="${param.sucesso == 'true'}">
                <div class="alert alert-success">
                    Cliente cadastrado com sucesso!
                </div>
            </c:if>

            <div style="margin-bottom: 20px;">
                <a href="${pageContext.request.contextPath}/clientes?acao=novo" class="btn btn-primary">+ Novo Cliente</a>
            </div>

            <c:choose>
                <c:when test="${not empty clientes}">
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Nome</th>
                                <th>Tipo</th>
                                <th>Documento</th>
                                <th>Telefone</th>
                                <th>Email</th>
                                <th>Cidade/UF</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="cliente" items="${clientes}">
                                <tr>
                                    <td>${cliente.id}</td>
                                    <td><strong>${cliente.nome}</strong></td>
                                    <td>${cliente.tipoDocumento}</td>
                                    <td>${cliente.documento}</td>
                                    <td>${cliente.telefone}</td>
                                    <td>${cliente.email}</td>
                                    <td>${cliente.endereco.cidade}/${cliente.endereco.estado}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <p>Nenhum cliente cadastrado ainda.</p>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <footer>
        <p>&copy; 2024 Tartaruga Cometa - Sistema de Controle de Entregas</p>
    </footer>
</body>
</html>
