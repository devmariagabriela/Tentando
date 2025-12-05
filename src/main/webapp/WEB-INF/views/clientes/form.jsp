<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Novo Cliente - Tartaruga Cometa</title>
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
            <h2>Cadastrar Novo Cliente</h2>

            <form method="post" action="${pageContext.request.contextPath}/clientes">
                <h3 style="color: #667eea; margin-bottom: 15px;">Dados Pessoais</h3>

                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px;">
                    <div class="form-group">
                        <label for="tipoDocumento">Tipo de Documento *</label>
                        <select id="tipoDocumento" name="tipoDocumento" required>
                            <option value="">Selecione...</option>
                            <option value="CPF">CPF (Pessoa Física)</option>
                            <option value="CNPJ">CNPJ (Pessoa Jurídica)</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="documento">CPF/CNPJ *</label>
                        <input type="text" id="documento" name="documento" required 
                               placeholder="000.000.000-00 ou 00.000.000/0000-00">
                    </div>
                </div>

                <div class="form-group">
                    <label for="nome">Nome/Razão Social *</label>
                    <input type="text" id="nome" name="nome" required>
                </div>

                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px;">
                    <div class="form-group">
                        <label for="telefone">Telefone</label>
                        <input type="text" id="telefone" name="telefone" placeholder="(00) 00000-0000">
                    </div>

                    <div class="form-group">
                        <label for="email">E-mail</label>
                        <input type="email" id="email" name="email">
                    </div>
                </div>

                <hr style="margin: 30px 0; border: none; border-top: 1px solid #e2e8f0;">

                <h3 style="color: #667eea; margin-bottom: 15px;">Endereço</h3>

                <div style="display: grid; grid-template-columns: 1fr 2fr; gap: 20px;">
                    <div class="form-group">
                        <label for="cep">CEP *</label>
                        <input type="text" id="cep" name="cep" required placeholder="00000-000">
                    </div>

                    <div class="form-group">
                        <label for="logradouro">Logradouro *</label>
                        <input type="text" id="logradouro" name="logradouro" required>
                    </div>
                </div>

                <div style="display: grid; grid-template-columns: 1fr 2fr; gap: 20px;">
                    <div class="form-group">
                        <label for="numero">Número *</label>
                        <input type="text" id="numero" name="numero" required>
                    </div>

                    <div class="form-group">
                        <label for="complemento">Complemento</label>
                        <input type="text" id="complemento" name="complemento">
                    </div>
                </div>

                <div class="form-group">
                    <label for="bairro">Bairro *</label>
                    <input type="text" id="bairro" name="bairro" required>
                </div>

                <div style="display: grid; grid-template-columns: 2fr 1fr; gap: 20px;">
                    <div class="form-group">
                        <label for="cidade">Cidade *</label>
                        <input type="text" id="cidade" name="cidade" required>
                    </div>

                    <div class="form-group">
                        <label for="estado">Estado (UF) *</label>
                        <select id="estado" name="estado" required>
                            <option value="">Selecione...</option>
                            <option value="AC">AC</option>
                            <option value="AL">AL</option>
                            <option value="AP">AP</option>
                            <option value="AM">AM</option>
                            <option value="BA">BA</option>
                            <option value="CE">CE</option>
                            <option value="DF">DF</option>
                            <option value="ES">ES</option>
                            <option value="GO">GO</option>
                            <option value="MA">MA</option>
                            <option value="MT">MT</option>
                            <option value="MS">MS</option>
                            <option value="MG">MG</option>
                            <option value="PA">PA</option>
                            <option value="PB">PB</option>
                            <option value="PR">PR</option>
                            <option value="PE">PE</option>
                            <option value="PI">PI</option>
                            <option value="RJ">RJ</option>
                            <option value="RN">RN</option>
                            <option value="RS">RS</option>
                            <option value="RO">RO</option>
                            <option value="RR">RR</option>
                            <option value="SC">SC</option>
                            <option value="SP">SP</option>
                            <option value="SE">SE</option>
                            <option value="TO">TO</option>
                        </select>
                    </div>
                </div>

                <hr style="margin: 30px 0; border: none; border-top: 1px solid #e2e8f0;">

                <div style="text-align: right;">
                    <a href="${pageContext.request.contextPath}/clientes" class="btn btn-secondary">Cancelar</a>
                    <button type="submit" class="btn btn-primary">Cadastrar Cliente</button>
                </div>
            </form>
        </div>
    </div>

    <footer>
        <p>&copy; 2025 Tartaruga Cometa - Sistema de Controle de Entregas</p>
    </footer>
</body>
</html>
