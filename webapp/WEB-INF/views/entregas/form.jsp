<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nova Entrega - Tartaruga Cometa</title>
    <style>
        :root {
            --primary-color: #2c3e50;
            --secondary-color: #34495e;
            --accent-color: #27ae60;
            --light-bg: #f4f7f6;
            --white: #ffffff;
            --border-color: #dce4ec;
        }

        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: var(--light-bg );
            margin: 0;
            padding: 0;
        }

        .container { max-width: 1000px; margin: 0 auto; padding: 20px; }

        header {
            background-color: var(--primary-color);
            color: white;
            padding: 20px 0;
            text-align: center;
        }

        nav {
            background-color: var(--secondary-color);
            padding: 10px 0;
            text-align: center;
        }

        nav ul { list-style: none; padding: 0; margin: 0; display: flex; justify-content: center; gap: 20px; }

        nav a { color: white; text-decoration: none; font-weight: bold; }

        .card {
            background: white;
            border-radius: 8px;
            padding: 30px;
            margin-top: 20px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }

        h2, h3 { color: var(--primary-color); border-bottom: 2px solid var(--accent-color); padding-bottom: 8px; }

        .form-group { margin-bottom: 15px; }

        label { display: block; margin-bottom: 5px; font-weight: 600; color: #555; }

        select, input, textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid var(--border-color);
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 14px;
        }

        .btn {
            padding: 10px 20px;
            border-radius: 4px;
            border: none;
            cursor: pointer;
            font-weight: bold;
            transition: 0.3s;
            text-decoration: none;
            display: inline-block;
        }

        .btn-primary { background-color: var(--accent-color); color: white; }
        .btn-secondary { background-color: #95a5a6; color: white; }
        .btn-danger { background-color: #e74c3c; color: white; }

        hr { border: 0; border-top: 1px solid #eee; margin: 25px 0; }

        .produto-item {
            background: #f9f9f9;
            padding: 15px;
            border-radius: 6px;
            border-left: 4px solid var(--accent-color);
        }

        footer { text-align: center; padding: 20px; color: #7f8c8d; }
    </style>
</head>
<body>
    <header>
        <h1> Tartaruga Cometa</h1>
        <p>Sistema de Controle de Entregas</p>
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
            <h2>Cadastrar Nova Entrega</h2>

            <c:if test="${not empty erro}">
                <div style="background: #f8d7da; color: #721c24; padding: 10px; border-radius: 4px; margin-bottom: 20px;">
                    ${erro}
                </div>
            </c:if>

            <form method="post" action="${pageContext.request.contextPath}/entregas/nova">
                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 30px;">
                    <div>
                        <h3>Dados do Remetente</h3>
                        <div class="form-group">
                            <label for="remetenteId">Remetente *</label>
                            <select id="remetenteId" name="remetenteId" required onchange="updateEnderecoOrigem()">
                                <option value="">Selecione...</option>
                                <c:forEach var="cliente" items="${clientes}">
                                    <option value="${cliente.id}" data-endereco="${cliente.enderecoId}">
                                        ${cliente.nome} - ${cliente.documento}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="enderecoOrigemId">Endereço de Origem *</label>
                            <select id="enderecoOrigemId" name="enderecoOrigemId" required>
                                <option value="">Selecione o remetente primeiro</option>
                            </select>
                        </div>
                    </div>

                    <div>
                        <h3>Dados do Destinatário</h3>
                        <div class="form-group">
                            <label for="destinatarioId">Destinatário *</label>
                            <select id="destinatarioId" name="destinatarioId" required onchange="updateEnderecoDestino()">
                                <option value="">Selecione...</option>
                                <c:forEach var="cliente" items="${clientes}">
                                    <option value="${cliente.id}" data-endereco="${cliente.enderecoId}">
                                        ${cliente.nome} - ${cliente.documento}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="enderecoDestinoId">Endereço de Destino *</label>
                            <select id="enderecoDestinoId" name="enderecoDestinoId" required>
                                <option value="">Selecione o destinatário primeiro</option>
                            </select>
                        </div>
                    </div>
                </div>

                <hr>
                <h3>Dados da Entrega</h3>
                <div style="display: grid; grid-template-columns: 1fr 1fr 1fr; gap: 20px;">
                    <div class="form-group">
                        <label for="dataColeta">Data de Coleta *</label>
                        <input type="date" id="dataColeta" name="dataColeta" required>
                    </div>
                    <div class="form-group">
                        <label for="dataEntregaPrevista">Previsão de Entrega *</label>
                        <input type="date" id="dataEntregaPrevista" name="dataEntregaPrevista" required>
                    </div>
                    <div class="form-group">
                        <label for="valorFrete">Valor do Frete (R$) *</label>
                        <input type="number" id="valorFrete" name="valorFrete" step="0.01" min="0" required>
                    </div>
                </div>

                <div class="form-group">
                    <label for="observacoes">Observações</label>
                    <textarea id="observacoes" name="observacoes" rows="3"></textarea>
                </div>

                <hr>
                <h3>Produtos</h3>
                <div id="produtos-container">
                    <div class="produto-item" style="display: grid; grid-template-columns: 2fr 1fr auto; gap: 15px; margin-bottom: 15px; align-items: flex-end;">
                        <div class="form-group">
                            <label>Produto *</label>
                            <select name="produtoId" required>
                                <option value="">Selecione...</option>
                                <c:forEach var="produto" items="${produtos}">
                                    <option value="${produto.id}">
                                        ${produto.nome} - R$ ${produto.valorUnitario}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>Quantidade *</label>
                            <input type="number" name="quantidade" min="1" value="1" required>
                        </div>
                        <div style="padding-bottom: 5px;">
                            <button type="button" class="btn btn-danger" onclick="removeProduto(this)">Remover</button>
                        </div>
                    </div>
                </div>
                <button type="button" class="btn btn-secondary" onclick="addProduto()">+ Adicionar Produto</button>

                <hr>
                <div style="text-align: right;">
                    <a href="${pageContext.request.contextPath}/entregas/listar" class="btn btn-secondary">Cancelar</a>
                    <button type="submit" class="btn btn-primary">Cadastrar Entrega</button>
                </div>
            </form>
        </div>
    </div>

    <footer>
        <p>&copy; 2025 Tartaruga Cometa - Sistema de Controle de Entregas</p>
    </footer>

    <script>
        function updateEnderecoOrigem() {
            const select = document.getElementById('remetenteId');
            const enderecoSelect = document.getElementById('enderecoOrigemId');
            const enderecoId = select.options[select.selectedIndex].getAttribute('data-endereco');
            enderecoSelect.innerHTML = enderecoId ? '<option value="' + enderecoId + '" selected>Endereço do Cliente</option>' : '<option value="">Selecione o remetente primeiro</option>';
        }

        function updateEnderecoDestino() {
            const select = document.getElementById('destinatarioId');
            const enderecoSelect = document.getElementById('enderecoDestinoId');
            const enderecoId = select.options[select.selectedIndex].getAttribute('data-endereco');
            enderecoSelect.innerHTML = enderecoId ? '<option value="' + enderecoId + '" selected>Endereço do Cliente</option>' : '<option value="">Selecione o destinatário primeiro</option>';
        }

        function addProduto() {
            const container = document.getElementById('produtos-container');
            const newItem = container.querySelector('.produto-item').cloneNode(true);
            newItem.querySelectorAll('input').forEach(i => i.value = "1");
            newItem.querySelectorAll('select').forEach(s => s.selectedIndex = 0);
            container.appendChild(newItem);
        }

        function removeProduto(button) {
            const container = document.getElementById('produtos-container');
            if (container.querySelectorAll('.produto-item').length > 1) button.closest('.produto-item').remove();
            else alert('É necessário ter pelo menos um produto!');
        }

        const hoje = new Date().toISOString().split('T')[0];
        document.getElementById('dataColeta').setAttribute('min', hoje);
        document.getElementById('dataEntregaPrevista').setAttribute('min', hoje);
    </script>
</body>
</html>
