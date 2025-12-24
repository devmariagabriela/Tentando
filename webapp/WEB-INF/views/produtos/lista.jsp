<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Produtos - Tartaruga Cometa</title>
    <style>
        /* Estilização Adicionada */
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
            max-width: 1200px;
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

        header h1 {
            margin: 0;
            font-size: 2.5em;
            letter-spacing: 2px;
        }

        header p {
            margin: 10px 0 0;
            opacity: 0.8;
        }

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

        h2 {
            color: var(--primary-color);
            border-bottom: 2px solid var(--accent-color);
            padding-bottom: 10px;
            margin-top: 0;
        }

        .card {
            background: var(--white);
            border-radius: 8px;
            padding: 25px;
            margin-bottom: 20px;
            box-shadow: var(--shadow);
            transition: transform 0.3s;
        }

        .card:hover {
            transform: translateY(-5px);
        }

        /* Estilo da Barra de Pesquisa */
        .search-container {
            margin-bottom: 20px;
            display: flex;
            gap: 10px;
        }

        .search-input {
            flex: 1;
            padding: 12px 15px;
            border: 2px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
            transition: border-color 0.3s;
            outline: none;
        }

        .search-input:focus {
            border-color: var(--accent-color);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }

        table th {
            background-color: var(--primary-color);
            color: var(--white);
            text-align: left;
            padding: 12px;
        }

        table td {
            padding: 12px;
            border-bottom: 1px solid #eee;
        }

        table tr:hover {
            background-color: #f9f9f9;
        }

        .btn {
            display: inline-block;
            padding: 8px 16px;
            border-radius: 5px;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s;
            border: none;
            cursor: pointer;
            font-size: 13px;
        }

        .btn-primary { background-color: var(--info-color); color: white; }
        .btn-success { background-color: var(--accent-color); color: white; }
        .btn-warning { background-color: var(--warning-color); color: white; }
        .btn-danger { background-color: var(--danger-color); color: white; }

        footer {
            text-align: center;
            padding: 30px 0;
            background-color: var(--primary-color);
            color: var(--white);
            margin-top: 50px;
        }

        .no-results {
            display: none;
            text-align: center;
            padding: 20px;
            color: #666;
            font-style: italic;
        }
    </style>
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
            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
                <h2>Produtos Cadastrados</h2>
                <div style="display: flex; gap: 10px;">
                    <a href="${pageContext.request.contextPath}/produtos?acao=novo" class="btn btn-success">➕ CADASTRAR</a>
                    <a href="${pageContext.request.contextPath}/produtos/estoque" class="btn btn-warning">📦 GERENCIAR ESTOQUE</a>
                </div>
            </div>

            <!-- Barra de Pesquisa -->
            <div class="search-container">
                <input type="text" id="searchInput" class="search-input" placeholder="Pesquisar por nome, descrição, ID ou valor..." onkeyup="filterTable()">
            </div>

            <c:choose>
                <c:when test="${not empty produtos}">
                    <table id="dataTable">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Nome</th>
                                <th>Descrição</th>
                                <th>Peso (kg)</th>
                                <th>Volume</th>
                                <th>Valor Unitário</th>
                                <th>Estoque</th>
                                <th>Ações</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="produto" items="${produtos}">
                                <tr>
                                    <td>${produto.id}</td>
                                    <td><strong>${produto.nome}</strong></td>
                                    <td>${produto.descricao}</td>
                                    <td><fmt:formatNumber value="${produto.pesoKg}" pattern="#,##0.00"/></td>
                                    <td><fmt:formatNumber value="${produto.volumeM3}" pattern="#,##0.000"/> ${produto.unidadeVolume}</td>
                                    <td>R$ <fmt:formatNumber value="${produto.valorUnitario}" pattern="#,##0.00"/></td>
                                    <td><span style="font-weight: bold; color: ${produto.quantidadeEstoque < 10 ? 'var(--danger-color)' : 'inherit'}">${produto.quantidadeEstoque}</span></td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/produtos?acao=editar&id=${produto.id}" class="btn btn-primary">Editar</a>
                                        
                                        <form method="post" action="${pageContext.request.contextPath}/produtos/remover" style="display: inline;" onsubmit="return confirm('Deseja excluir o produto ${produto.nome}?');">
                                            <input type="hidden" name="id" value="${produto.id}">
                                            <button type="submit" class="btn btn-danger">Excluir</button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                    <div id="noResults" class="no-results">Nenhum produto encontrado para a sua pesquisa.</div>
                </c:when>
                <c:otherwise>
                    <p>Nenhum produto cadastrado ainda.</p>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <footer>
        <p>&copy; 2025 Tartaruga Cometa - Sistema de Controle de Entregas</p>
    </footer>

    <script>
        function filterTable() {
            const input = document.getElementById("searchInput");
            const filter = input.value.toLowerCase();
            const table = document.getElementById("dataTable");
            const tr = table.getElementsByTagName("tr");
            const noResults = document.getElementById("noResults");
            let visibleRows = 0;

            if (!table) return;

            for (let i = 1; i < tr.length; i++) {
                let found = false;
                const td = tr[i].getElementsByTagName("td");
                for (let j = 0; j < td.length - 1; j++) {
                    if (td[j]) {
                        const textValue = td[j].textContent || td[j].innerText;
                        if (textValue.toLowerCase().indexOf(filter) > -1) {
                            found = true;
                            break;
                        }
                    }
                }
                if (found) {
                    tr[i].style.display = "";
                    visibleRows++;
                } else {
                    tr[i].style.display = "none";
                }
            }
            if (noResults) noResults.style.display = visibleRows === 0 ? "block" : "none";
        }
    </script>
</body>
</html>
