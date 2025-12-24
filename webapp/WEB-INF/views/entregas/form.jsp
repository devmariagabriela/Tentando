<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nova Entrega - Tartaruga Cometa</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/modern-style.css">
</head>
<body>
    <header>
        <div class="container">
            <h1> Tartaruga Cometa</h1>
            <p>Cadastrar Nova Entrega</p>
        </div>
    </header>

    <div class="container">
        <div class="card">
            <form method="post" action="${pageContext.request.contextPath}/entregas/nova">
                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 2rem; margin-bottom: 2rem;">
                    <div>
                        <h3 style="margin-bottom: 1rem; color: var(--primary );">Remetente</h3>
                        <label>Cliente</label>
                        <select name="remetenteId" required>
                            <option value="">Selecione...</option>
                            <c:forEach var="cliente" items="${clientes}">
                                <option value="${cliente.id}">${cliente.nome}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div>
                        <h3 style="margin-bottom: 1rem; color: var(--primary);">Destinatário</h3>
                        <label>Cliente</label>
                        <select name="destinatarioId" required>
                            <option value="">Selecione...</option>
                            <c:forEach var="cliente" items="${clientes}">
                                <option value="${cliente.id}">${cliente.nome}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>

                <div style="display: grid; grid-template-columns: 1fr 1fr 1fr; gap: 1.5rem; margin-bottom: 2rem;">
                    <div>
                        <label>Data Coleta</label>
                        <input type="date" name="dataColeta" required>
                    </div>
                    <div>
                        <label>Previsão Entrega</label>
                        <input type="date" name="dataEntregaPrevista" required>
                    </div>
                    <div>
                        <label>Valor Frete (R$)</label>
                        <input type="number" name="valorFrete" step="0.01" required>
                    </div>
                </div>

                <div style="text-align: right; border-top: 1px solid var(--border); padding-top: 2rem;">
                    <a href="${pageContext.request.contextPath}/entregas/listar" class="btn" style="background: #e2e8f0; color: #475569; margin-right: 1rem;">Cancelar</a>
                    <button type="submit" class="btn btn-primary">CADASTRAR ENTREGA</button>
                </div>
            </form>
        </div>
    </div>
</body>
</html>