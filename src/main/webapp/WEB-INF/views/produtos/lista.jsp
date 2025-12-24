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
            <li><a href="${pageContext.request.contextPath}/produtos/estoque">Estoque</a></li>           

                     
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
            
            <c:if test="${param.removido == 'true'}">
                <div class="alert alert-success">
                    Produto removido com sucesso!
                </div>
            </c:if>

            <div style="margin-bottom: 20px;">
                <a href="${pageContext.request.contextPath}/produtos?acao=novo" class="btn btn-primary">CADASTRAR</a>
                <a href="${pageContext.request.contextPath}/produtos/estoque" class="btn btn-secondary">GERENCIAR ESTOQUE</a>
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
                                <th>Volume</th> <!-- ALTERADO: removido unidade fixa -->
                                <th>Valor Unitário</th>
                                <th>Estoque</th>
                                <th>Ações</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="produto" items="${produtos}">
                                <tr>
                                    <td>${produto.id}</td>
                                    <td><strong>${produto.nome}</strong></td>
                                    <td>${produto.descricao}</td>
                                    <td><fmt:formatNumber value="${produto.pesoKg}" pattern="#,##0.00"/></td>
                                    <!-- ALTERADO: Exibir volume com unidade -->
                                    <td>
                                        <fmt:formatNumber value="${produto.volumeM3}" pattern="#,##0.000"/> 
                                        <c:choose>
                                            <c:when test="${produto.unidadeVolume == 'cm3'}">cm³</c:when>
                                            <c:when test="${produto.unidadeVolume == 'ml'}">mL</c:when>
                                            <c:when test="${produto.unidadeVolume == 'dm3'}">dm³</c:when>
                                            <c:when test="${produto.unidadeVolume == 'l'}">L</c:when>
                                            <c:when test="${produto.unidadeVolume == 'm3'}">m³</c:when>
                                            <c:otherwise>m³</c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>R$ <fmt:formatNumber value="${produto.valorUnitario}" pattern="#,##0.00"/></td>
                                    <td>${produto.quantidadeEstoque}</td>
                                    <td>
                                        <!-- Botão Editar (agora usando <form> e <button>) -->
                                        <form method="get" action="${pageContext.request.contextPath}/produtos" style="display: inline;">
                                            <input type="hidden" name="acao" value="editar">
                                            <input type="hidden" name="id" value="${produto.id}">
                                            <button type="submit" class="btn btn-secondary" style="padding: 5px 10px; font-size: 12px; margin-right: 5px;">
                                                Editar
                                            </button>
                                        </form>
                                        
                                        <!-- Botão Excluir (inalterado)-->
                                     
                                        <form method="post" action="${pageContext.request.contextPath}/produtos/remover" style="display: inline;" onsubmit="return confirm('Tem certeza que deseja excluir o produto ${produto.nome}?');">
                                            <input type="hidden" name="produtoId" value="${produto.id}">
                                            <button type="submit" class="btn btn-danger" style="padding: 5px 10px; font-size: 12px;">
                                                Excluir
                                            </button>
                                        </form>
                                    </td>
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