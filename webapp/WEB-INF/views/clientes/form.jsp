<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cadastro de Cliente - Tartaruga Cometa</title>
    <style>
        :root {
            --primary-color: #2c3e50;
            --secondary-color: #34495e;
            --accent-color: #27ae60;
            --light-bg: #f4f7f6;
            --white: #ffffff;
            --text-color: #333;
            --shadow: 0 4px 6px rgba(0,0,0,0.1 );
        }
        body { font-family: 'Segoe UI', sans-serif; background-color: var(--light-bg); color: var(--text-color); margin: 0; }
        .container { max-width: 800px; margin: 0 auto; padding: 20px; }
        header { background-color: var(--primary-color); color: white; padding: 20px; text-align: center; }
        nav { background-color: var(--secondary-color); padding: 10px; text-align: center; }
        nav a { color: white; text-decoration: none; margin: 0 15px; font-weight: bold; }
        .card { background: white; border-radius: 8px; padding: 30px; margin-top: 20px; box-shadow: var(--shadow); }
        h2 { color: var(--primary-color); border-bottom: 2px solid var(--accent-color); padding-bottom: 10px; }
        .form-group { margin-bottom: 15px; }
        .form-row { display: flex; gap: 20px; }
        .form-row .form-group { flex: 1; }
        label { display: block; margin-bottom: 5px; font-weight: bold; }
        input, select { width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box; }
        .btn { padding: 12px 25px; border-radius: 4px; border: none; cursor: pointer; font-weight: bold; text-decoration: none; display: inline-block; }
        .btn-primary { background-color: var(--accent-color); color: white; }
        .btn-secondary { background-color: #95a5a6; color: white; }
        .alert-error { background-color: #f8d7da; color: #721c24; padding: 10px; border-radius: 4px; margin-bottom: 20px; }
    </style>
</head>
<body>
    <header>
        <h1>Tartaruga Cometa</h1>
    </header>

    <nav>
        <a href="${pageContext.request.contextPath}/">Dashboard</a>
        <a href="${pageContext.request.contextPath}/clientes">Clientes</a>
    </nav>

    <div class="container">
        <div class="card">
            <h2><c:choose><c:when test="${not empty cliente}">Editar Cliente</c:when><c:otherwise>Novo Cliente</c:otherwise></c:choose></h2>
            
            <c:if test="${not empty erro}">
                <div class="alert-error">${erro}</div>
            </c:if>

            <!-- AQUI ESTÁ A CORREÇÃO DA URL -->
            <form action="${pageContext.request.contextPath}/clientes" method="post">
                <c:if test="${not empty cliente}">
                    <input type="hidden" name="clienteId" value="${cliente.id}">
                    <input type="hidden" name="enderecoId" value="${cliente.enderecoId}">
                </c:if>

                <div class="form-group">
                    <label for="nome">Nome Completo *</label>
                    <input type="text" id="nome" name="nome" value="${cliente.nome}" required>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="tipoDocumento">Tipo de Pessoa *</label>
                        <select id="tipoDocumento" name="tipoDocumento" required onchange="limparDocumento()">
                            <option value="CPF" <c:if test="${cliente.tipoDocumento == 'F' || cliente.tipoDocumento == 'CPF'}">selected</c:if>>Pessoa Física (CPF)</option>
                            <option value="CNPJ" <c:if test="${cliente.tipoDocumento == 'J' || cliente.tipoDocumento == 'CNPJ'}">selected</c:if>>Pessoa Jurídica (CNPJ)</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="documento">Documento (CPF/CNPJ) *</label>
                        <input type="text" id="documento" name="documento" value="${cliente.documento}" required oninput="mascaraDocumento(this)">
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="email">E-mail</label>
                        <input type="email" id="email" name="email" value="${cliente.email}">
                    </div>
                    <div class="form-group">
                        <label for="telefone">Telefone</label>
                        <input type="text" id="telefone" name="telefone" value="${cliente.telefone}" oninput="mascaraTelefone(this)">
                    </div>
                </div>

                <h3>Endereço</h3>
                <div class="form-row">
                    <div class="form-group" style="flex: 3;">
                        <label for="logradouro">Logradouro *</label>
                        <input type="text" id="logradouro" name="logradouro" value="${cliente.endereco.logradouro}" required>
                    </div>
                    <div class="form-group">
                        <label for="numero">Nº *</label>
                        <input type="text" id="numero" name="numero" value="${cliente.endereco.numero}" required>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="bairro">Bairro *</label>
                        <input type="text" id="bairro" name="bairro" value="${cliente.endereco.bairro}" required>
                    </div>
                    <div class="form-group">
                        <label for="cep">CEP *</label>
                        <input type="text" id="cep" name="cep" value="${cliente.endereco.cep}" required oninput="mascaraCEP(this)">
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="cidade">Cidade *</label>
                        <input type="text" id="cidade" name="cidade" value="${cliente.endereco.cidade}" required>
                    </div>
                    <div class="form-group">
                        <label for="estado">UF *</label>
                        <input type="text" id="estado" name="estado" value="${cliente.endereco.estado}" maxlength="2" required>
                    </div>
                </div>

                <div style="text-align: right; margin-top: 20px;">
                    <a href="${pageContext.request.contextPath}/clientes" class="btn btn-secondary">Cancelar</a>
                    <button type="submit" class="btn btn-primary">Salvar Cliente</button>
                </div>
            </form>
        </div>
    </div>

    <script>
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
            v = v.replace(/^(\d{5})(\d)/, "$1-$2");
            campo.value = v;
        }
    </script>
</body>
</html>
