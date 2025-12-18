<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><c:choose><c:when test="${not empty cliente}">Editar Cliente</c:when><c:otherwise>Novo Cliente</c:otherwise></c:choose> - Tartaruga Cometa</title>
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
            <h2><c:choose><c:when test="${not empty cliente}">Editar Cliente: ${cliente.nome}</c:when><c:otherwise>Cadastrar Novo Cliente</c:otherwise></c:choose></h2>

            <c:if test="${not empty erro}">
                <p style="color: red; font-weight: bold;">Erro: ${erro}</p>
            </c:if>

            <form method="post" action="${pageContext.request.contextPath}/clientes">
            	<c:if test="${not empty cliente}">
            		<input type="hidden" name="clienteId" value="${cliente.id}">
            		<input type="hidden" name="enderecoId" value="${cliente.enderecoId}">
            	</c:if>
                <h3 style="color: #667eea; margin-bottom: 15px;">Dados Pessoais</h3>

                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px;">
                    <div class="form-group">
                        <label for="tipoDocumento">Tipo de Documento *</label>
                        <select id="tipoDocumento" name="tipoDocumento" required>
                            <option value="">Selecione...</option>
                            <option value="F" <c:if test="${cliente.tipoDocumento == 'F'}">selected</c:if>>CPF (Pessoa Física  )</option>
                            <option value="J" <c:if test="${cliente.tipoDocumento == 'J'}">selected</c:if>>CNPJ (Pessoa Jurídica)</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="documento">CPF/CNPJ *</label>
                        <input type="text" id="documento" name="documento" required 
                               placeholder="000.000.000-00 ou 00.000.000/0000-00" value="${cliente.documento}" maxlength="18"oninput="this.value = this.value.replace(/\D/g, '')" /><br><br>
                    </div>
                </div>

                <div class="form-group">
                    <label for="nome">Nome/Razão Social *</label>
                    <input type="text" id="nome" name="nome" maxlength="50" oninput="this.value = this.value.replace(/[0-9]/g, '')"/><br><br>
                </div>

                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px;">
                    <div class="form-group">
                        <label for="telefone">Telefone</label>
                        <input type="tel" id="telefone" name="telefone" placeholder="(00) 00000-0000" value="${cliente.telefone}" maxlength="15"oninput="this.value = this.value.replace(/\D/g, '')" /><br><br>
                    </div>

                    <div class="form-group">
                        <label for="email">E-mail</label>
                        <input type="email" id="email" name="email" value="${cliente.email}" maxlength="40">
                    </div>
                </div>

                <hr style="margin: 30px 0; border: none; border-top: 1px solid #e2e8f0;">

                <h3 style="color: #667eea; margin-bottom: 15px;">Endereço</h3>

                <div style="display: grid; grid-template-columns: 1fr 2fr; gap: 20px;">
                    <div class="form-group">
                        <label for="cep">CEP *</label>
                        <input type="tel" id="cep" name="cep" required placeholder="00000-000" value="${cliente.endereco.cep}" maxlength="9" oninput="this.value = this.value.replace(/\D/g, '')" /><br><br>
                    </div>

                    <div class="form-group">
                        <label for="logradouro">Logradouro *</label>
                        <input type="text" id="logradouro" name="logradouro" required value="${cliente.endereco.logradouro}" maxlength="20">
                    </div>
                </div>

                <div style="display: grid; grid-template-columns: 1fr 2fr; gap: 20px;">
                    <div class="form-group">
                        <label for="numero">Número *</label>
                        <input type="text" id="numero" name="numero" required value="${cliente.endereco.numero}" maxlength="5">
                    </div>

                    <div class="form-group">
                        <label for="complemento">Complemento</label>
                        <input type="text" id="complemento" name="complemento" value="${cliente.endereco.complemento}" maxlength="25">
                    </div>
                </div>

                <div class="form-group">
                    <label for="bairro">Bairro *</label>
                    <input type="text" id="bairro" name="bairro" required value="${cliente.endereco.bairro}" maxlength="10">
                </div>

                <div style="display: grid; grid-template-columns: 2fr 1fr; gap: 20px;">
                    <div class="form-group">
                        <label for="cidade">Cidade *</label>
                        <input type="text" id="cidade" name="cidade" required value="${cliente.endereco.cidade}" maxlength="10" oninput="this.value = this.value.replace(/[0-9]/g, '')"/><br><br>
                    </div>

                    <div class="form-group">
                        <label for="estado">Estado (UF) *</label>
                        <select id="estado" name="estado" required>
                            <option value="">Selecione...</option>
                            <option value="AC" <c:if test="${cliente.endereco.estado == 'AC'}">selected</c:if>>AC</option>
                            <option value="AL" <c:if test="${cliente.endereco.estado == 'AL'}">selected</c:if>>AL</option>
                            <option value="AP" <c:if test="${cliente.endereco.estado == 'AP'}">selected</c:if>>AP</option>
                            <option value="AM" <c:if test="${cliente.endereco.estado == 'AM'}">selected</c:if>>AM</option>
                            <option value="BA" <c:if test="${cliente.endereco.estado == 'BA'}">selected</c:if>>BA</option>
                            <option value="CE" <c:if test="${cliente.endereco.estado == 'CE'}">selected</c:if>>CE</option>
                            <option value="DF" <c:if test="${cliente.endereco.estado == 'DF'}">selected</c:if>>DF</option>
                            <option value="ES" <c:if test="${cliente.endereco.estado == 'ES'}">selected</c:if>>ES</option>
                            <option value="GO" <c:if test="${cliente.endereco.estado == 'GO'}">selected</c:if>>GO</option>
                            <option value="MA" <c:if test="${cliente.endereco.estado == 'MA'}">selected</c:if>>MA</option>
                            <option value="MT" <c:if test="${cliente.endereco.estado == 'MT'}">selected</c:if>>MT</option>
                            <option value="MS" <c:if test="${cliente.endereco.estado == 'MS'}">selected</c:if>>MS</option>
                            <option value="MG" <c:if test="${cliente.endereco.estado == 'MG'}">selected</c:if>>MG</option>
                            <option value="PA" <c:if test="${cliente.endereco.estado == 'PA'}">selected</c:if>>PA</option>
                            <option value="PB" <c:if test="${cliente.endereco.estado == 'PB'}">selected</c:if>>PB</option>
                            <option value="PR" <c:if test="${cliente.endereco.estado == 'PR'}">selected</c:if>>PR</option>
                            <option value="PE" <c:if test="${cliente.endereco.estado == 'PE'}">selected</c:if>>PE</option>
                            <option value="PI" <c:if test="${cliente.endereco.estado == 'PI'}">selected</c:if>>PI</option>
                            <option value="RJ" <c:if test="${cliente.endereco.estado == 'RJ'}">selected</c:if>>RJ</option>
                            <option value="RN" <c:if test="${cliente.endereco.estado == 'RN'}">selected</c:if>>RN</option>
                            <option value="RS" <c:if test="${cliente.endereco.estado == 'RS'}">selected</c:if>>RS</option>
                            <option value="RO" <c:if test="${cliente.endereco.estado == 'RO'}">selected</c:if>>RO</option>
                            <option value="RR" <c:if test="${cliente.endereco.estado == 'RR'}">selected</c:if>>RR</option>
                            <option value="SC" <c:if test="${cliente.endereco.estado == 'SC'}">selected</c:if>>SC</option>
                            <option value="SP" <c:if test="${cliente.endereco.estado == 'SP'}">selected</c:if>>SP</option>
                            <option value="SE" <c:if test="${cliente.endereco.estado == 'SE'}">selected</c:if>>SE</option>
                            <option value="TO" <c:if test="${cliente.endereco.estado == 'TO'}">selected</c:if>>TO</option>
                        </select>
                    </div>
                </div>

                <hr style="margin: 30px 0; border: none; border-top: 1px solid #e2e8f0;">

                <div style="text-align: right;">
                    <a href="${pageContext.request.contextPath}/clientes" class="btn btn-secondary">Cancelar</a>
                    <button type="submit" class="btn btn-primary"><c:choose><c:when test="${not empty cliente}">Salvar Alterações</c:when><c:otherwise>Cadastrar Cliente</c:otherwise></c:choose></button>
                </div>
            </form>
        </div>
    </div>

    <footer>
        <p>&copy; 2025 Tartaruga Cometa - Sistema de Controle de Entregas</p>
    </footer>
</body>
</html>