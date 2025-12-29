<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><c:choose><c:when test="${not empty cliente}">Editar Cliente</c:when><c:otherwise>Cadastrar Cliente</c:otherwise></c:choose> - Tartaruga Cometa</title>
    <style>
        :root {
            --primary-color: #090979;
            --secondary-color: #090979;
            --accent-color: #27ae60;
            --light-bg: #f4f7f6;
            --white: #ffffff;
            --text-color: #333;
            --shadow: 0 4px 6px rgba(0,0,0,0.1 );
        }
        body { font-family: 'Segoe UI', sans-serif; background-color: var(--light-bg); color: var(--text-color); margin: 0; padding: 0; line-height: 1.6; }
        .container { max-width: 800px; margin: 0 auto; padding: 20px; }
        
        header { background-color: var(--primary-color); color: var(--white); padding: 40px 0; text-align: center; box-shadow: var(--shadow); }
        header h1 { margin: 0; font-size: 2.5em; letter-spacing: 2px; }
        header p { margin: 10px 0 0; opacity: 0.8; }

        nav { background-color: var(--secondary-color); padding: 10px 0; position: sticky; top: 0; z-index: 1000; }
        nav ul { list-style: none; padding: 0; margin: 0; display: flex; justify-content: center; gap: 30px; }
        nav ul li a { color: var(--white); text-decoration: none; font-weight: 600; transition: color 0.3s; padding: 5px 10px; border-radius: 4px; }
        nav ul li a:hover { color: var(--accent-color); background-color: rgba(255,255,255,0.1); }

        .card { background: var(--white); border-radius: 8px; padding: 30px; margin-top: 20px; box-shadow: var(--shadow); }
        h2 { color: var(--primary-color); border-bottom: 2px solid var(--accent-color); padding-bottom: 10px; margin-top: 0; }
        
        .form-group { margin-bottom: 20px; }
        .form-row { display: flex; gap: 20px; margin-bottom: 20px; }
        .form-row .form-group { flex: 1; margin-bottom: 0; }
        
        label { display: block; margin-bottom: 8px; font-weight: 600; color: var(--secondary-color); }
        input, select { width: 100%; padding: 12px; border: 2px solid #ddd; border-radius: 5px; font-size: 16px; transition: border-color 0.3s; box-sizing: border-box; outline: none; }
        input:focus, select:focus { border-color: var(--accent-color); }

        .btn { display: inline-block; padding: 12px 24px; border-radius: 5px; text-decoration: none; font-weight: 600; transition: all 0.3s; border: none; cursor: pointer; font-size: 16px; }
        .btn-primary { background-color: var(--accent-color); color: white; }
        .btn-primary:hover { background-color: #219150; transform: translateY(-2px); }
        .btn-secondary { background-color: #95a5a6; color: white; margin-right: 10px; }

        .alert-error { background-color: #f8d7da; color: #721c24; padding: 15px; border-radius: 5px; margin-bottom: 20px; border: 1px solid #f5c6cb; }
        
        footer { text-align: center; padding: 30px 0; background-color: var(--primary-color); color: var(--white); margin-top: 50px; }
    </style>
</head>
<body>
    <header>
        <div class="container">
            <h1>Tartaruga Cometa</h1>
            <p>Sistema de Controle de Entregas</p>
        </div>
    </header>

    <nav>
        <ul>
            <li><a href="${pageContext.request.contextPath}/">Dashboard</a></li>
  			<li><a href="${pageContext.request.contextPath}/clientes">Clientes</a></li> 
  			<li><a href="${pageContext.request.contextPath}/produtos">Produtos</a></li>
            <li><a href="${pageContext.request.contextPath}/entregas/listar">Entregas</a></li>
        </ul>
    </nav>

    <div class="container">
        <div class="card">
            <h2><c:choose><c:when test="${not empty cliente}">Editar Cliente</c:when><c:otherwise>Cadastrar Novo Cliente</c:otherwise></c:choose></h2>
            
            <c:if test="${not empty erro}">
                <div class="alert-error">${erro}</div>
            </c:if>

            <form action="${pageContext.request.contextPath}/clientes" method="post">
                <c:if test="${not empty cliente}">
                    <input type="hidden" name="clienteId" value="${cliente.id}">
                    <input type="hidden" name="enderecoId" value="${cliente.enderecoId}">
                </c:if>

                <div class="form-group">
                    <label for="nome">Nome Completo / Razao Social * </label>
                    <input type="text" id="nome" name="nome" value="${cliente.nome}" required maxlength="50" oninput="letrasNumeros(this)">
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="tipoDocumento">Tipo de Pessoa *</label>
                        <select id="tipoDocumento" name="tipoDocumento" required onchange="limparDocumento()">
                            <option value="CPF" <c:if test="${cliente.tipoDocumento == 'F' || cliente.tipoDocumento == 'CPF'}">selected</c:if>>Pessoa Fisica (CPF)</option>
                            <option value="CNPJ" <c:if test="${cliente.tipoDocumento == 'J' || cliente.tipoDocumento == 'CNPJ'}">selected</c:if>>Pessoa Jurídica (CNPJ)</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="documento">CPF / CNPJ *</label>
                        <input type="text" id="documento" name="documento" value="${cliente.documento}" required oninput="mascaraDocumento(this)">
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="email">E-mail </label>
                        <input type="email" id="email" name="email" value="${cliente.email}" maxlength="40">
                    </div>
                    <div class="form-group">
                        <label for="telefone">Telefone / WhatsApp</label>
                        <input type="text" id="telefone" name="telefone" value="${cliente.telefone}" required maxlength="15"	oninput="mascaraTelefone(this)">
                    </div>
                </div>

                <h3>Endereco</h3>
                <div class="form-row">
                    <div class="form-group" style="flex: 2;">
                        <label for="logradouro">Logradouro * </label>
                        <input type="text" id="logradouro" name="logradouro" value="${cliente.endereco.logradouro}" required maxlength="50" oninput="letrasNumeros(this)">
                    </div>
                    <div class="form-group" style="flex: 1;">
                        <label for="numero">Numero * </label>
                        <input type="text" id="numero" name="numero" value="${cliente.endereco.numero}" required maxlength="6" oninput="letrasNumeros(this)">
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="bairro">Bairro * </label>
                        <input type="text" id="bairro" name="bairro" value="${cliente.endereco.bairro}" required maxlength="20" oninput="letrasNumeros(this)">
                    </div>
                    <div class="form-group">
                        <label for="cep">CEP * </label>
                        <input type="text" id="cep" name="cep" value="${cliente.endereco.cep}" required maxlength="9" oninput="mascaraCEP(this)">
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group" style="flex: 2;">
                        <label for="cidade">Cidade * </label>
                        <input type="text" id="cidade" name="cidade" value="${cliente.endereco.cidade}" required maxlength="15" oninput="apenasLetras(this)">
                    </div>
                    <div class="form-group" style="flex: 1;">
                        <label for="estado">Estado (UF) *</label>
                        <select id="estado" name="estado" required>
                            <option value="">Selecione</option>
                            <option value="AC" ${cliente.endereco.estado == 'AC' ? 'selected' : ''}>AC</option>
                            <option value="AL" ${cliente.endereco.estado == 'AL' ? 'selected' : ''}>AL</option>
                            <option value="AP" ${cliente.endereco.estado == 'AP' ? 'selected' : ''}>AP</option>
                            <option value="AM" ${cliente.endereco.estado == 'AM' ? 'selected' : ''}>AM</option>
                            <option value="BA" ${cliente.endereco.estado == 'BA' ? 'selected' : ''}>BA</option>
                            <option value="CE" ${cliente.endereco.estado == 'CE' ? 'selected' : ''}>CE</option>
                            <option value="DF" ${cliente.endereco.estado == 'DF' ? 'selected' : ''}>DF</option>
                            <option value="ES" ${cliente.endereco.estado == 'ES' ? 'selected' : ''}>ES</option>
                            <option value="GO" ${cliente.endereco.estado == 'GO' ? 'selected' : ''}>GO</option>
                            <option value="MA" ${cliente.endereco.estado == 'MA' ? 'selected' : ''}>MA</option>
                            <option value="MT" ${cliente.endereco.estado == 'MT' ? 'selected' : ''}>MT</option>
                            <option value="MS" ${cliente.endereco.estado == 'MS' ? 'selected' : ''}>MS</option>
                            <option value="MG" ${cliente.endereco.estado == 'MG' ? 'selected' : ''}>MG</option>
                            <option value="PA" ${cliente.endereco.estado == 'PA' ? 'selected' : ''}>PA</option>
                            <option value="PB" ${cliente.endereco.estado == 'PB' ? 'selected' : ''}>PB</option>
                            <option value="PR" ${cliente.endereco.estado == 'PR' ? 'selected' : ''}>PR</option>
                            <option value="PE" ${cliente.endereco.estado == 'PE' ? 'selected' : ''}>PE</option>
                            <option value="PI" ${cliente.endereco.estado == 'PI' ? 'selected' : ''}>PI</option>
                            <option value="RJ" ${cliente.endereco.estado == 'RJ' ? 'selected' : ''}>RJ</option>
                            <option value="RN" ${cliente.endereco.estado == 'RN' ? 'selected' : ''}>RN</option>
                            <option value="RS" ${cliente.endereco.estado == 'RS' ? 'selected' : ''}>RS</option>
                            <option value="RO" ${cliente.endereco.estado == 'RO' ? 'selected' : ''}>RO</option>
                            <option value="RR" ${cliente.endereco.estado == 'RR' ? 'selected' : ''}>RR</option>
                            <option value="SC" ${cliente.endereco.estado == 'SC' ? 'selected' : ''}>SC</option>
                            <option value="SP" ${cliente.endereco.estado == 'SP' ? 'selected' : ''}>SP</option>
                            <option value="SE" ${cliente.endereco.estado == 'SE' ? 'selected' : ''}>SE</option>
                            <option value="TO" ${cliente.endereco.estado == 'TO' ? 'selected' : ''}>TO</option>
                        </select>
                    </div>
                </div>

                <hr>
                <div style="text-align: right;">
                    <a href="${pageContext.request.contextPath}/clientes" class="btn btn-secondary">Cancelar</a>
                    <button type="submit" class="btn btn-primary">Salvar Cliente</button>
                </div>
            </form>
        </div>
    </div>

    <script>
        function apenasLetras(campo) { campo.value = campo.value.replace(/[^a-zA-ZáàâãéèêíïóôõöúçñÁÀÂÃÉÈÊÍÏÓÔÕÖÚÇÑ ]/g, ""); }
        function letrasNumeros(campo) { campo.value = campo.value.replace(/[^a-zA-Z0-9áàâãéèêíïóôõöúçñÁÀÂÃÉÈÊÍÏÓÔÕÖÚÇÑ ]/g, ""); }
        function apenasNumeros(campo) { campo.value = campo.value.replace(/\D/g, ""); }
        function limparDocumento() { document.getElementById('documento').value = ''; }
        function mascaraDocumento(campo) {
            let v = campo.value.replace(/\D/g, '');
            const tipo = document.getElementById('tipoDocumento').value;
            if (tipo === 'CPF') {
                v = v.substring(0, 11);
                v = v.replace(/(\d{3})(\d{3})(\d{3})(\d{2})/, "$1.$2.$3-$4");
            } else {
                v = v.substring(0, 14);
                v = v.replace(/(\d{2})(\d{3})(\d{3})(\d{4})(\d{2})/, "$1.$2.$3/$4-$5");
            }
            campo.value = v;
        }
        function mascaraTelefone(campo) {
            let v = campo.value.replace(/\D/g, '');
            v = v.replace(/^(\d{2})(\d)/g, "($1) $2");
            v = v.replace(/(\d)(\d{4})$/, "$1-$2");
            campo.value = v;
        }
        function mascaraCEP(campo) {
            let v = campo.value.replace(/\D/g, '');
            v = v.substring(0, 8);
            v = v.replace(/^(\d{5})(\d)/, "$1-$2");
            campo.value = v;
        }
    </script>

    <footer>
        <p>&copy; 2025 Tartaruga Cometa - Sistema de Controle de Entregas</p>
    </footer>
</body>
</html>
