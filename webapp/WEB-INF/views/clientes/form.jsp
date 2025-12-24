<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><c:choose><c:when test="${not empty cliente}">Editar Cliente</c:when><c:otherwise>Cadastrar Cliente</c:otherwise></c:choose> - Tartaruga Cometa</title>
    <style>
        /* PADRÃO VISUAL TARTARUGA COMETA */
        :root {
            --primary-color: #2c3e50;
            --secondary-color: #34495e;
            --accent-color: #27ae60;
            --warning-color: #f39c12;
            --info-color: #3498db;
            --success-color: #2ecc71;
            --danger-color: #e74c3c;
            --light-bg: #f4f7f6;
            --white: #ffffff;
            --text-color: #333;
            --shadow: 0 4px 6px rgba(0,0,0,0.1 );
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: var(--light-bg);
            color: var(--text-color);
            margin: 0;
            padding: 0;
            line-height: 1.6;
        }

        .container {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
        }

        header {
            background-color: var(--primary-color);
            color: var(--white);
            padding: 40px 0;
            text-align: center;
            box-shadow: var(--shadow);
        }

        header h1 { margin: 0; font-size: 2.5em; letter-spacing: 2px; }
        header p { margin: 10px 0 0; opacity: 0.8; }

        nav {
            background-color: var(--secondary-color);
            padding: 10px 0;
            position: sticky;
            top: 0;
            z-index: 1000;
        }

        nav ul {
            list-style: none;
            padding: 0;
            margin: 0;
            display: flex;
            justify-content: center;
            gap: 30px;
        }

        nav ul li a {
            color: var(--white);
            text-decoration: none;
            font-weight: 600;
            transition: color 0.3s;
            padding: 5px 10px;
            border-radius: 4px;
        }

        nav ul li a:hover {
            color: var(--accent-color);
            background-color: rgba(255,255,255,0.1);
        }

        .card {
            background: var(--white);
            border-radius: 8px;
            padding: 30px;
            margin-top: 20px;
            box-shadow: var(--shadow);
        }

        h2 {
            color: var(--primary-color);
            border-bottom: 2px solid var(--accent-color);
            padding-bottom: 10px;
            margin-top: 0;
        }

        .form-group { margin-bottom: 20px; }
        .form-row { display: flex; gap: 20px; margin-bottom: 20px; }
        .form-row .form-group { flex: 1; margin-bottom: 0; }

        label { display: block; margin-bottom: 8px; font-weight: 600; color: var(--secondary-color); }

        input[type="text"], input[type="email"], input[type="tel"], select {
            width: 100%;
            padding: 12px;
            border: 2px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
            transition: border-color 0.3s;
            box-sizing: border-box;
            outline: none;
        }

        input:focus, select:focus { border-color: var(--accent-color); }

        .btn {
            display: inline-block;
            padding: 12px 24px;
            border-radius: 5px;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s;
            border: none;
            cursor: pointer;
            font-size: 16px;
        }

        .btn-primary { background-color: var(--accent-color); color: white; }
        .btn-primary:hover { background-color: #219150; transform: translateY(-2px); }
        .btn-secondary { background-color: #95a5a6; color: white; margin-right: 10px; }

        footer {
            text-align: center;
            padding: 30px 0;
            background-color: var(--primary-color);
            color: var(--white);
            margin-top: 50px;
        }
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
            <li><a href="${pageContext.request.contextPath}/entregas/listar">Entregas</a></li>
            <li><a href="${pageContext.request.contextPath}/clientes">Clientes</a></li>
            <li><a href="${pageContext.request.contextPath}/produtos">Produtos</a></li>
        </ul>
    </nav>

    <div class="container">
        <div class="card">
            <h2><c:choose><c:when test="${not empty cliente}">Editar Cliente</c:when><c:otherwise>Cadastrar Novo Cliente</c:otherwise></c:choose></h2>
            
            <form action="${pageContext.request.contextPath}/clientes/${not empty cliente ? 'editar' : 'cadastrar'}" method="post">
                <c:if test="${not empty cliente}">
                    <input type="hidden" name="id" value="${cliente.id}">
                </c:if>

                <div class="form-group">
                    <label for="nome">Nome Completo / Razão Social *</label>
                    <input type="text" id="nome" name="nome" value="${cliente.nome}" required placeholder="Ex: João Silva ou Tech Solutions LTDA">
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="tipo">Tipo de Pessoa *</label>
                        <select id="tipo" name="tipo" required onchange="limparDocumento()">
                            <option value="F" <c:if test="${cliente.tipo == 'F'}">selected</c:if>>Pessoa Física (CPF)</option>
                            <option value="J" <c:if test="${cliente.tipo == 'J'}">selected</c:if>>Pessoa Jurídica (CNPJ)</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="documento">CPF / CNPJ *</label>
                        <input type="text" id="documento" name="documento" value="${cliente.documento}" required 
                               oninput="mascaraDocumento(this)" placeholder="000.000.000-00">
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="email">E-mail *</label>
                        <input type="email" id="email" name="email" value="${cliente.email}" required placeholder="exemplo@email.com">
                    </div>
                    <div class="form-group">
                        <label for="telefone">Telefone / WhatsApp *</label>
                        <input type="tel" id="telefone" name="telefone" value="${cliente.telefone}" required 
                               oninput="mascaraTelefone(this)" placeholder="(00) 00000-0000">
                    </div>
                </div>

                <h3>Endereço</h3>
                <div class="form-row">
                    <div class="form-group" style="flex: 2;">
                        <label for="logradouro">Logradouro *</label>
                        <input type="text" id="logradouro" name="logradouro" value="${cliente.endereco.logradouro}" required>
                    </div>
                    <div class="form-group" style="flex: 1;">
                        <label for="numero">Número *</label>
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
                        <input type="text" id="cep" name="cep" value="${cliente.endereco.cep}" required 
                               oninput="mascaraCEP(this)" placeholder="00000-000">
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group" style="flex: 2;">
                        <label for="cidade">Cidade *</label>
                        <input type="text" id="cidade" name="cidade" value="${cliente.endereco.cidade}" required>
                    </div>
                    <div class="form-group" style="flex: 1;">
                        <label for="estado">Estado (UF) *</label>
                        <select id="estado" name="estado" required>
                            <option value="">Selecione</option>
                            <c:forEach var="uf" items="${['AC','AL','AP','AM','BA','CE','DF','ES','GO','MA','MT','MS','MG','PA','PB','PR','PE','PI','RJ','RN','RS','RO','RR','SC','SP','SE','TO']}">
                                <option value="${uf}" <c:if test="${cliente.endereco.estado == uf}">selected</c:if>>${uf}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>

                <hr>
                <div style="text-align: right;">
                    <a href="${pageContext.request.contextPath}/clientes" class="btn btn-secondary">Cancelar</a>
                    <button type="submit" class="btn btn-primary">
                        <c:choose>
                            <c:when test="${not empty cliente}">Salvar Alterações</c:when>
                            <c:otherwise>Cadastrar Cliente</c:otherwise>
                        </c:choose>
                    </button>
                </div>
            </form>
        </div>
    </div>
    
    <<script>
    function limparDocumento() {
        const docInput = document.getElementById('documento');
        const tipo = document.getElementById('tipo').value;
        docInput.value = '';
        docInput.placeholder = tipo === 'F' ? '000.000.000-00' : '00.000.000/0000-00';
        docInput.maxLength = tipo === 'F' ? 14 : 18;
        docInput.focus();
    }

    function mascaraDocumento(campo) {
        const tipo = document.getElementById('tipo').value;
        let v = campo.value.replace(/\D/g, ''); // Remove tudo que não é dígito
        
        if (tipo === 'F') {
            // CPF: 000.000.000-00
            campo.maxLength = 14;
            v = v.substring(0, 11);
            if (v.length > 9) v = v.replace(/(\d{3})(\d{3})(\d{3})(\d{2})/, "$1.$2.$3-$4");
            else if (v.length > 6) v = v.replace(/(\d{3})(\d{3})(\d{1,3})/, "$1.$2.$3");
            else if (v.length > 3) v = v.replace(/(\d{3})(\d{1,3})/, "$1.$2");
        } else {
            // CNPJ: 00.000.000/0000-00
            campo.maxLength = 18;
            v = v.substring(0, 14);
            if (v.length > 12) v = v.replace(/(\d{2})(\d{3})(\d{3})(\d{4})(\d{2})/, "$1.$2.$3/$4-$5");
            else if (v.length > 8) v = v.replace(/(\d{2})(\d{3})(\d{3})(\d{1,4})/, "$1.$2.$3/$4");
            else if (v.length > 5) v = v.replace(/(\d{2})(\d{3})(\d{1,3})/, "$1.$2.$3");
            else if (v.length > 2) v = v.replace(/(\d{2})(\d{1,3})/, "$1.$2");
        }
        campo.value = v;
    }

    function mascaraTelefone(campo) {
        let v = campo.value.replace(/\D/g, '');
        v = v.substring(0, 11);
        if (v.length > 10) v = v.replace(/^(\d{2})(\d{5})(\d{4})/, "($1) $2-$3");
        else if (v.length > 6) v = v.replace(/^(\d{2})(\d{4})(\d{0,4})/, "($1) $2-$3");
        else if (v.length > 2) v = v.replace(/^(\d{2})(\d{0,5})/, "($1) $2");
        campo.value = v;
        campo.maxLength = 15;
    }

    function mascaraCEP(campo) {
        let v = campo.value.replace(/\D/g, '');
        v = v.substring(0, 8);
        if (v.length > 5) v = v.replace(/(\d{5})(\d{1,3})/, "$1-$2");
        campo.value = v;
        campo.maxLength = 9;
    }

    document.addEventListener('DOMContentLoaded', function() {
        const docInput = document.getElementById('documento');
        if (docInput && docInput.value) mascaraDocumento(docInput);
        const telInput = document.getElementById('telefone');
        if (telInput && telInput.value) mascaraTelefone(telInput);
        const cepInput = document.getElementById('cep');
        if (cepInput && cepInput.value) mascaraCEP(cepInput);
    });
</script>


    <footer>
        <p>&copy; 2025 Tartaruga Cometa - Sistema de Controle de Entregas</p>
    </footer>
</body>
</html>
