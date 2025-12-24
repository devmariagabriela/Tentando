<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><c:choose><c:when test="${not empty cliente}">Editar Cliente</c:when><c:otherwise>Novo Cliente</c:otherwise></c:choose> - Tartaruga Cometa</title>
    <style>
        :root {
            --primary-color: #2c3e50;
            --secondary-color: #34495e;
            --accent-color: #27ae60;
            --light-bg: #f4f7f6;
            --white: #ffffff;
            --border-color: #dce4ec;
            --text-color: #2c3e50;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: var(--light-bg );
            color: var(--text-color);
            margin: 0;
            padding: 0;
            line-height: 1.6;
        }

        .container {
            max-width: 900px;
            margin: 0 auto;
            padding: 20px;
        }

        header {
            background-color: var(--primary-color);
            color: var(--white);
            padding: 30px 0;
            text-align: center;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        header h1 { margin: 0; font-size: 2em; }
        header p { margin: 5px 0 0; opacity: 0.8; }

        nav {
            background-color: var(--secondary-color);
            padding: 10px 0;
            text-align: center;
            position: sticky;
            top: 0;
            z-index: 1000;
        }

        nav ul { list-style: none; padding: 0; margin: 0; display: flex; justify-content: center; gap: 20px; }
        nav a { color: white; text-decoration: none; font-weight: 600; transition: color 0.3s; }
        nav a:hover { color: var(--accent-color); }

        .card {
            background: var(--white);
            border-radius: 8px;
            padding: 30px;
            margin-top: 20px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }

        h2 { color: var(--primary-color); margin-top: 0; border-bottom: 2px solid var(--accent-color); padding-bottom: 10px; }
        h3 { color: #667eea; margin: 25px 0 15px; font-size: 1.2em; }

        .form-group { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; font-weight: 600; color: #555; }

        input[type="text"], input[type="tel"], input[type="email"], select {
            width: 100%;
            padding: 10px;
            border: 1px solid var(--border-color);
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 14px;
            transition: border-color 0.3s;
        }

        input:focus, select:focus { border-color: var(--accent-color); outline: none; }

        .btn {
            padding: 10px 25px;
            border-radius: 4px;
            border: none;
            cursor: pointer;
            font-weight: bold;
            transition: 0.3s;
            text-decoration: none;
            display: inline-block;
        }

        .btn-primary { background-color: var(--accent-color); color: white; }
        .btn-primary:hover { background-color: #219150; }
        .btn-secondary { background-color: #95a5a6; color: white; margin-right: 10px; }
        .btn-secondary:hover { background-color: #7f8c8d; }

        hr { border: 0; border-top: 1px solid #edf2f7; margin: 30px 0; }

        footer { text-align: center; padding: 30px 0; color: #7f8c8d; font-size: 0.9em; }
    </style>
</head>
<body>
    <header>
        <div class="container">
            <h1>  Tartaruga Cometa</h1>
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
                <div style="background: #fff5f5; color: #c53030; padding: 10px; border-radius: 4px; border-left: 4px solid #c53030; margin-bottom: 20px;">
                    Erro: ${erro}
                </div>
            </c:if>

            <form method="post" action="${pageContext.request.contextPath}/clientes">
            	<c:if test="${not empty cliente}">
            		<input type="hidden" name="clienteId" value="${cliente.id}">
            		<input type="hidden" name="enderecoId" value="${cliente.enderecoId}">
            	</c:if>
                
                <h3>Dados Pessoais</h3>

                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px;">
                    <div class="form-group">
                        <label for="tipoDocumento">Tipo de Documento *</label>
                        <select id="tipoDocumento" name="tipoDocumento" required>
                            <option value="">Selecione...</option>
                            <option value="F" <c:if test="${cliente.tipoDocumento == 'F'}">selected</c:if>>CPF (Pessoa Física)</option>
                            <option value="J" <c:if test="${cliente.tipoDocumento == 'J'}">selected</c:if>>CNPJ (Pessoa Jurídica)</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="documento">CPF/CNPJ *</label>
                        <input type="text" id="documento" name="documento" required 
                               placeholder="000.000.000-00 ou 0.000.000/0000-00" value="${cliente.documento}" 
                               onkeyup="mascaraDocumento(this)" oninput="this.value = this.value.replace(/[^0-9\.\-\/]/g, '')" />  
                    </div>
                </div>

                <div class="form-group">
                    <label for="nome">Nome/Razão Social *</label>
                    <input type="text" id="nome" name="nome" maxlength="50" oninput="this.value = this.value.replace(/[0-9]/g, '')" value="${cliente.nome}"/>  
                </div>

                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px;">
                    <div class="form-group">
                        <label for="telefone">Telefone</label>
                        <input type="tel" id="telefone" name="telefone" placeholder="(00) 00000-0000" value="${cliente.telefone}" 
                               onkeyup="mascaraTelefone(this)" oninput="this.value = this.value.replace(/[^0-9\(\)\-\s]/g, '')" />  
                    </div>

                    <div class="form-group">
                        <label for="email">E-mail</label>
                        <input type="email" id="email" name="email" value="${cliente.email}" maxlength="40">
                    </div>
                </div>

                <hr>
                <h3>Endereço</h3>

                <div style="display: grid; grid-template-columns: 1fr 2fr; gap: 20px;">
                    <div class="form-group">
                        <label for="cep">CEP *</label>
                        <input type="tel" id="cep" name="cep" required placeholder="00000-000" value="${cliente.endereco.cep}" 
                               onkeyup="mascaraCEP(this)" oninput="this.value = this.value.replace(/[^0-9\-]/g, '')" />  
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
                        <input type="text" id="cidade" name="cidade" required value="${cliente.endereco.cidade}" maxlength="10" oninput="this.value = this.value.replace(/[0-9]/g, '')"/>  
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

                <hr>

                <div style="text-align: right;">
                    <a href="${pageContext.request.contextPath}/clientes" class="btn btn-secondary">Cancelar</a>
                    <button type="submit" class="btn btn-primary"><c:choose><c:when test="${not empty cliente}">Salvar Alterações</c:when><c:otherwise>Cadastrar Cliente</c:otherwise></c:choose></button>
                </div>
            </form>
        </div>
    </div>
    
    <script>
        function mascaraDocumento(campo) {
            let valor = campo.value.replace(/\D/g, '');
            if (valor.length <= 11) {
                valor = valor.replace(/(\d{3})(\d)/, '$1.$2');
                valor = valor.replace(/(\d{3})(\d)/, '$1.$2');
                valor = valor.replace(/(\d{3})(\d{1,2})$/, '$1-$2');
                campo.maxLength = 14;
            } else {
                valor = valor.replace(/^(\d{2})(\d)/, '$1.$2');
                valor = valor.replace(/^(\d{2})\.(\d{3})(\d)/, '$1.$2');
                valor = valor.replace(/\.(\d{3})(\d)/, '.$1/$2');
                valor = valor.replace(/(\d{4})(\d)/, '$1-$2');
                campo.maxLength = 18;
            }
            campo.value = valor;
        }

        function mascaraTelefone(campo) {
            let valor = campo.value.replace(/\D/g, '');
            if (valor.length > 11) valor = valor.substring(0, 11);
            valor = valor.replace(/^(\d{2})(\d)/g, '($1) $2');
            if (valor.length <= 14) {
                valor = valor.replace(/(\d{4})(\d)/, '$1-$2');
                campo.maxLength = 14;
            } else {
                valor = valor.replace(/(\d{5})(\d)/, '$1-$2');
                campo.maxLength = 15;
            }
            campo.value = valor;
        }

        function mascaraCEP(campo) {
            let valor = campo.value.replace(/\D/g, '');
            valor = valor.replace(/^(\d{5})(\d)/, '$1-$2');
            campo.maxLength = 9;
            campo.value = valor;
        }

        document.addEventListener('DOMContentLoaded', function() {
            const documento = document.getElementById('documento');
            if (documento && documento.value) mascaraDocumento(documento);
            const telefone = document.getElementById('telefone');
            if (telefone && telefone.value) mascaraTelefone(telefone);
            const cep = document.getElementById('cep');
            if (cep && cep.value) mascaraCEP(cep);
        });
    </script>

    <footer>
        <p>&copy; 2025 Tartaruga Cometa - Sistema de Controle de Entregas</p>
    </footer>
</body>
</html>
