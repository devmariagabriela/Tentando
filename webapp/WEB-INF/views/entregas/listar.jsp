<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Listar Entregas - Tartaruga Cometa</title>

</head>
<body>
    <header>
        <h1>🐢 Tartaruga Cometa</h1>
        <p>Sistema de Controle de Entregas</p>
    </header>

    <nav>
        <a href="${pageContext.request.contextPath}/">Dashboard</a>
        <a href="${pageContext.request.contextPath}/entregas/listar">Entregas</a>
        <a href="${pageContext.request.contextPath}/clientes">Clientes</a>
        <a href="${pageContext.request.contextPath}/produtos">Produtos</a>
    </nav>

    <div class="container">
        <div class="card">
            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
                <h2>Entregas Cadastradas</h2>
                <a href="${pageContext.request.contextPath}/entregas/nova" class="btn btn-primary" style="text-decoration: none;">+ NOVA ENTREGA</a>
            </div>

            <table>
                <thead>
                    <tr>
                        <th>Código</th>
                        <th>Destinatário</th>
                        <th>Origem/Destino</th>
                        <th>Valor Total</th>
                        <th>Status</th>
                        <th>Ações</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="entrega" items="${entregas}">
                        <tr>
                            <td><strong>#${entrega.codigo}</strong></td>
                            <td>${entrega.destinatario.nome}</td>
                            <td>${entrega.enderecoOrigem.cidade} → ${entrega.enderecoDestino.cidade}</td>
                            <td>R$ <fmt:formatNumber value="${entrega.valorTotalGeral}" pattern="#,##0.00"/></td>
                            <td>
                                <c:choose>
                                    <c:when test="${entrega.status == 'PENDENTE'}"><span class="badge badge-pendente">Pendente</span></c:when>
                                    <c:when test="${entrega.status == 'EM_TRANSITO'}"><span class="badge badge-transito">Em Trânsito</span></c:when>
                                    <c:when test="${entrega.status == 'REALIZADA'}"><span class="badge badge-realizada">Realizada</span></c:when>
                                    <c:otherwise><span class="badge badge-cancelada">Cancelada</span></c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <c:if test="${entrega.status != 'REALIZADA' and entrega.status != 'CANCELADA'}">
                                    <div class="actions-flex">
                                        <form method="post" action="${pageContext.request.contextPath}/entregas/atualizar-status">
                                            <input type="hidden" name="entregaId" value="${entrega.id}">
                                            
                                            <c:if test="${entrega.status == 'PENDENTE'}">
                                                <button type="submit" name="status" value="EM_TRANSITO" class="btn btn-primary">Iniciar</button>
                                            </c:if>
                                            
                                            <c:if test="${entrega.status == 'EM_TRANSITO'}">
                                                <button type="submit" name="status" value="REALIZADA" class="btn btn-success">Finalizar</button>
                                            </c:if>

                                            <!-- BOTÃO CANCELAR CORRIGIDO -->
                                            <button type="submit" name="status" value="CANCELADA" class="btn btn-danger" 
                                                    onclick="return confirm('Deseja realmente cancelar esta entrega?')">Cancelar</button>
                                        </form>
                                    </div>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <footer>
        <p>&copy; 2025 Tartaruga Cometa - Desenvolvido por Maria Gabi 😼👍</p>
    </footer>
</body>
</html>
