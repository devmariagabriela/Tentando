<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gerenciar Estoque - Tartaruga Cometa</title>
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
            <h2>Gerenciamento Manual de Estoque</h2>

            <c:if test="${not empty param.sucesso}">
                <div class="alert alert-success">
                    ${param.sucesso}
                </div>
            </c:if>
            
            <c:if test="${not empty erro}">
                <div class="alert alert-danger">
                    ${erro}
                </div>
            </c:if>

            <form method="post" action="${pageContext.request.contextPath}/produtos/estoque" class="form-estoque">
                <fieldset>
                    <legend>Atualizar Estoque</legend>
                    
                    <label for="produtoId">Produto:</label>
                    <select id="produtoId" name="produtoId" required>
                        <option value="">Selecione um Produto</option>
                        <c:forEach var="produto" items="${produtos}">
                            <option value="${produto.id}">
                                ${produto.nome} (Estoque Atual: ${produto.quantidadeEstoque} )
                            </option>
                        </c:forEach>
                    </select>
                    
                    <label for="quantidade">Quantidade:</label>
                    <input type="number" id="quantidade" name="quantidade" min="1" required>
                    
                    <label for="tipoOperacao">Tipo de Operação:</label>
                    <select id="tipoOperacao" name="tipoOperacao" required>
                        <option value="ENTRADA">Entrada (Adicionar)</option>
                        <option value="SAIDA">Saída (Remover)</option>
                    </select>
                    
                    <button type="submit" class="btn btn-primary">Atualizar Estoque</button>
                </fieldset>
            </form>
            
            <hr>
            
            <h3>Estoque Atual dos Produtos</h3>
            <c:choose>
                <c:when test="${not empty produtos}">
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Nome</th>
                                <th>Estoque Atual</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="produto" items="${produtos}">
                                <tr>
                                    <td>${produto.id}</td>
                                    <td>${produto.nome}</td>
                                    <td><strong>${produto.quantidadeEstoque}</strong></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <p>Nenhum produto cadastrado.</p>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <footer>
        <p>&copy; 2025 Tartaruga Cometa - Sistema de Controle de Entregas</p>
    </footer>
</body>
</html>