<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Novo Produto - Tartaruga Cometa</title>
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
            <h2>Cadastrar Novo Produto</h2>

            <form method="post" action="${pageContext.request.contextPath}/produtos">
                <div class="form-group">
                    <label for="nome">Nome do Produto *</label>
                    <input type="text" id="nome" name="nome" required>
                </div>

                <div class="form-group">
                    <label for="descricao">Descrição</label>
                    <textarea id="descricao" name="descricao" rows="3"></textarea>
                </div>

                <div style="display: grid; grid-template-columns: 1fr 1fr 1fr; gap: 20px;">
                    <div class="form-group">
                        <label for="pesoKg">Peso (kg) *</label>
                        <input type="number" id="pesoKg" name="pesoKg" step="0.01" min="0.01" required>
                    </div>

                    <div class="form-group">
                        <label for="volumeM3">Volume (m³) *</label>
                        <input type="number" id="volumeM3" name="volumeM3" step="0.001" min="0.001" required>
                    </div>

                    <div class="form-group">
                        <label for="valorUnitario">Valor Unitário (R$) *</label>
                        <input type="number" id="valorUnitario" name="valorUnitario" step="0.01" min="0" required>
                    </div>
                </div>

                <hr style="margin: 30px 0; border: none; border-top: 1px solid #e2e8f0;">

                <div style="text-align: right;">
                    <a href="${pageContext.request.contextPath}/produtos" class="btn btn-secondary">Cancelar</a>
                    <button type="submit" class="btn btn-primary">Cadastrar Produto</button>
                </div>
            </form>
        </div>
    </div>

    <footer>
        <p>&copy; 2025 Tartaruga Cometa - Sistema de Controle de Entregas</p>
    </footer>
</body>
</html>
