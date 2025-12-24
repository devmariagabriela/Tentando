<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Listar Entregas - Tartaruga Cometa</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/modern-style.css">
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
            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 2rem;">
                <h2>Entregas Cadastradas</h2>
                <a href="${pageContext.request.contextPath}/entregas/nova" class="btn btn-primary">CADASTRAR NOVA</a>
            </div>

            <c:if test="${param.sucesso == 'true'}">
                <div class="alert alert-success">Entrega cadastrada com sucesso!</div>
            </c:if>

            <div style="margin-bottom: 2rem; background: #f8fafc; padding: 1rem; border-radius: 8px;">
                <form action="${pageContext.request.contextPath}/entregas/listar" method="get">
                    <label><strong>FILTRAR POR STATUS:</strong></label>
                    <select name="status" onchange="this.form.submit( )" style="max-width: 200px; margin-top: 0.5rem;">
                        <option value="" ${empty param.status ? 'selected' : ''}>TODOS</option>
                        <option value="PENDENTE" ${param.status == 'PENDENTE' ? 'selected' : ''}>PENDENTES</option>
                        <option value="EM_TRANSITO" ${param.status == 'EM_TRANSITO' ? 'selected' : ''}>EM TRÂNSITO</option>
                        <option value="REALIZADA" ${param.status == 'REALIZADA' ? 'selected' : ''}>REALIZADAS</option>
                        <option value="CANCELADA" ${param.status == 'CANCELADA' ? 'selected' : ''}>CANCELADAS</option>
                    </select>
                </form>
            </div>

            <div class="table-container">
                <table>
                    <thead>
                        <tr>
                            <th>Código</th>
                            <th>Remetente</th>
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
                                <td><strong>${entrega.codigo}</strong></td>
                                <td>${entrega.remetente.nome}</td>
                                <td>${entrega.destinatario.nome}</td>
                                <td>${entrega.enderecoOrigem.cidade} → ${entrega.enderecoDestino.cidade}</td>
                                <td><strong>R$ <fmt:formatNumber value="${entrega.valorTotalGeral}" pattern="#,##0.00"/></strong></td>
                                <td>
                                    <c:choose>
                                        <c:when test="${entrega.status == 'PENDENTE'}"><span class="badge badge-pendente">Pendente</span></c:when>
                                        <c:when test="${entrega.status == 'EM_TRANSITO'}"><span class="badge badge-em-transito">Em Trânsito</span></c:when>
                                        <c:when test="${entrega.status == 'REALIZADA'}"><span class="badge badge-realizada">Realizada</span></c:when>
                                        <c:otherwise><span class="badge badge-cancelada">Cancelada</span></c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:if test="${entrega.status != 'REALIZADA' and entrega.status != 'CANCELADA'}">
                                        <form method="post" action="${pageContext.request.contextPath}/entregas/atualizar-status" style="display: inline;">
                                            <input type="hidden" name="entregaId" value="${entrega.id}">
                                            <c:if test="${entrega.status == 'PENDENTE'}">
                                                <button type="submit" name="status" value="EM_TRANSITO" class="btn btn-primary" style="padding: 4px 8px; font-size: 11px;">Iniciar</button>
                                            </c:if>
                                            <c:if test="${entrega.status == 'EM_TRANSITO'}">
                                                <button type="submit" name="status" value="REALIZADA" class="btn btn-success" style="padding: 4px 8px; font-size: 11px;">Finalizar</button>
                                            </c:if>
                                        </form>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html>