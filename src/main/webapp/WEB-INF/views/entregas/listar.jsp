<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Listar Entregas - Tartaruga Cometa</title>
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
            <h2>Entregas Cadastradas</h2>

            <c:if test="${param.sucesso == 'true'}">
                <div class="alert alert-success">
                    Entrega cadastrada com sucesso!
                </div>
            </c:if>

            <c:if test="${param.atualizado == 'true'}">
                <div class="alert alert-success">
                    Status atualizado com sucesso!
                </div>
            </c:if>

            <div style="margin-bottom: 20px;">
                <a href="${pageContext.request.contextPath}/entregas/nova" class="btn btn-primary">+ Nova Entrega</a>
                
                <div style="margin-top: 15px;">
                    <strong>Filtrar por status:</strong>
                    <a href="${pageContext.request.contextPath}/entregas/listar" class="btn btn-secondary" style="margin-left: 10px;">Todos</a>
                    <a href="${pageContext.request.contextPath}/entregas/listar?status=PENDENTE" class="btn btn-warning">Pendentes</a>
                    <a href="${pageContext.request.contextPath}/entregas/listar?status=EM_TRANSITO" class="btn btn-primary">Em Trânsito</a>
                    <a href="${pageContext.request.contextPath}/entregas/listar?status=REALIZADA" class="btn btn-success">Realizadas</a>
                </div>
            </div>

            <c:choose>
                <c:when test="${not empty entregas}">
                    <table>
                        <thead>
                            <tr>
                                <th>Código</th>
                                <th>Remetente</th>
                                <th>Destinatário</th>
                                <th>Origem</th>
                                <th>Destino</th>
                                <th>Data Coleta</th>
                                <th>Previsão</th>
                                <th>Valor Frete</th>
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
                                    <td>${entrega.enderecoOrigem.cidade}/${entrega.enderecoOrigem.estado}</td>
                                    <td>${entrega.enderecoDestino.cidade}/${entrega.enderecoDestino.estado}</td>
                                    <td>${entrega.dataColeta}</td>
                                    <td>${entrega.dataEntregaPrevista}</td>
                                    <td>R$ <fmt:formatNumber value="${entrega.valorFrete}" pattern="#,##0.00"/></td>
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
                                    <td>
                                        <c:if test="${entrega.status != 'REALIZADA'}">
                                            <form method="post" action="${pageContext.request.contextPath}/entregas/atualizar-status" style="display: inline;">
                                                <input type="hidden" name="entregaId" value="${entrega.id}">
                                                <c:if test="${entrega.status == 'PENDENTE'}">
                                                    <button type="submit" name="status" value="EM_TRANSITO" class="btn btn-primary" style="padding: 5px 10px; font-size: 12px;">
                                                        Iniciar Transporte
                                                    </button>
                                                </c:if>
                                                <c:if test="${entrega.status == 'EM_TRANSITO'}">
                                                    <button type="submit" name="status" value="REALIZADA" class="btn btn-success" style="padding: 5px 10px; font-size: 12px;">
                                                        Finalizar
                                                    </button>
                                                </c:if>
                                            </form>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <p>Nenhuma entrega encontrada.</p>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <footer>
        <p>&copy; 2025 Tartaruga Cometa - Sistema de Controle de Entregas</p>
    </footer>
</body>
</html>