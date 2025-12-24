<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nova Entrega - Tartaruga Cometa</title>
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
         	<li><a href="${pageContext.request.contextPath}/produtos/estoque">Gerenciar Estoque</a></li>           
            
        </ul>
    </nav>

    <div class="container">
        <div class="card">
            <h2>Cadastrar Nova Entrega</h2>

            <c:if test="${not empty erro}">
                <div class="alert alert-danger">
                    ${erro}
                </div>
            </c:if>

            <form method="post" action="${pageContext.request.contextPath}/entregas/nova">
                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px;">
                    <div>
                        <h3>Dados do Remetente</h3>
                        
                        <div class="form-group">
                            <label for="remetenteId">Remetente *</label>
                            <select id="remetenteId" name="remetenteId" required onchange="updateEnderecoOrigem(  )">
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
                    <div class="produto-item" style="display: grid; grid-template-columns: 2fr 1fr auto; gap: 15px; margin-bottom: 15px; align-items: flex-start;">
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
                        <div style="align-self: flex-end;">
                            <button type="button" class="btn btn-danger" onclick="removeProduto(this)">Remover</button>
                        </div>
                    </div>
                </div>

                <button type="button" class="btn btn-secondary" onclick="addProduto()">+ Adicionar Produto</button>

                <hr>

                <div style="text-align: right; margin-top: 20px;">
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
            
            if (enderecoId) {
                enderecoSelect.innerHTML = '<option value="' + enderecoId + '" selected>Endereço do Cliente</option>';
            } else {
                enderecoSelect.innerHTML = '<option value="">Selecione o remetente primeiro</option>';
            }
        }

        function updateEnderecoDestino() {
            const select = document.getElementById('destinatarioId');
            const enderecoSelect = document.getElementById('enderecoDestinoId');
            const enderecoId = select.options[select.selectedIndex].getAttribute('data-endereco');
            
            if (enderecoId) {
                enderecoSelect.innerHTML = '<option value="' + enderecoId + '" selected>Endereço do Cliente</option>';
            } else {
                enderecoSelect.innerHTML = '<option value="">Selecione o destinatário primeiro</option>';
            }
        }

        function addProduto() {
            const container = document.getElementById('produtos-container');
            const firstItem = container.querySelector('.produto-item');
            const newItem = firstItem.cloneNode(true);
            container.appendChild(newItem);
        }

        function removeProduto(button) {
            const container = document.getElementById('produtos-container');
            if (container.querySelectorAll('.produto-item').length > 1) {
                button.closest('.produto-item').remove();
            } else {
                alert('É necessário ter pelo menos um produto!');
            }
        }

        // Define data mínima como hoje
        const hoje = new Date().toISOString().split('T')[0];
        document.getElementById('dataColeta').setAttribute('min', hoje);
        document.getElementById('dataEntregaPrevista').setAttribute('min', hoje);
    </script>
</body>
</html>