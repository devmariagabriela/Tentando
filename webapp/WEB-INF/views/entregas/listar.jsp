<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Listar Entregas - Tartaruga Cometa</title>
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

        /* Estilo do Dropdown de Filtro */
        .controls-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 15px;
            margin-bottom: 20px;
            flex-wrap: wrap;
        }

        .dropdown {
            position: relative;
            display: inline-block;
        }

        .dropdown-btn {
            background-color: var(--white);
            color: var(--text-color);
            padding: 10px 20px;
            font-size: 14px;
            font-weight: 600;
            border: 2px solid #ddd;
            border-radius: 5px;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 10px;
            transition: all 0.3s;
            outline: none;
        }

        .dropdown-btn:hover, .dropdown-btn.active {
            border-color: var(--accent-color);
            background-color: #f9f9f9;
        }

        .dropdown-content {
            display: none;
            position: absolute;
            background-color: var(--white);
            min-width: 220px;
            box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
            z-index: 1001;
            border-radius: 5px;
            margin-top: 5px;
            overflow: hidden;
            border: 1px solid #eee;
        }

        .dropdown-content.show {
            display: block;
            animation: fadeIn 0.2s;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .dropdown-content a {
            color: var(--text-color);
            padding: 12px 16px;
            text-decoration: none;
            display: block;
            font-size: 14px;
            transition: background-color 0.2s;
            border-bottom: 1px solid #f9f9f9;
        }

        .dropdown-content a:last-child {
            border-bottom: none;
        }

        .dropdown-content a:hover {
            background-color: #f1f1f1;
            color: var(--accent-color);
        }

        .active-filter-label {
            font-size: 12px;
            color: var(--accent-color);
            font-weight: bold;
            background: #eafaf1;
            padding: 2px 8px;
            border-radius: 10px;
        }

        /* Estilo da Barra de Pesquisa */
        .search-container {
            flex: 1;
            min-width: 300px;
        }

        .search-input {
            width: 100%;
            padding: 10px 15px;
            border: 2px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
            transition: border-color 0.3s;
            outline: none;
            box-sizing: border-box;
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

        .badge {
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 0.85em;
            font-weight: bold;
            color: white;
            display: inline-block;
        }

        .badge-pendente { background-color: var(--warning-color); }
        .badge-transito { background-color: var(--info-color); }
        .badge-realizada { background-color: var(--success-color); }
        .badge-cancelada { background-color: var(--danger-color); }

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
        .btn-success { background-color: var(--success-color); color: white; }
        .btn-danger { background-color: var(--danger-color); color: white; }
        .btn-new { background-color: var(--accent-color); color: white; padding: 10px 20px; font-size: 14px; }

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
            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
                <h2>Entregas Cadastradas</h2>
                <a href="${pageContext.request.contextPath}/entregas/nova" class="btn btn-new">➕ NOVA ENTREGA</a>
            </div>

            <!-- Controles: Dropdown de Filtro e Barra de Pesquisa -->
            <div class="controls-row">
                <div class="dropdown">
                    <button class="dropdown-btn" id="dropdownBtn" onclick="toggleDropdown()">
                        🔍 Filtrar por Status 
                        <c:if test="${not empty statusFiltro}">
                            <span class="active-filter-label">${statusFiltro}</span>
                        </c:if>
                        <span style="font-size: 10px; margin-left: 5px;">▼</span>
                    </button>
                    <div class="dropdown-content" id="dropdownContent">
                        <a href="${pageContext.request.contextPath}/entregas/listar">Todas as Entregas</a>
                        <a href="${pageContext.request.contextPath}/entregas/listar?status=PENDENTE">Pendentes</a>
                        <a href="${pageContext.request.contextPath}/entregas/listar?status=EM_TRANSITO">Em Trânsito</a>
                        <a href="${pageContext.request.contextPath}/entregas/listar?status=REALIZADA">Realizadas</a>
                        <a href="${pageContext.request.contextPath}/entregas/listar?status=CANCELADA">Canceladas</a>
                    </div>
                </div>

                <div class="search-container">
                    <input type="text" id="searchInput" class="search-input" placeholder="Pesquisar por código, remetente, destinatário ou cidade..." onkeyup="filterTable()">
                </div>
            </div>

            <table id="dataTable">
                <thead>
                    <tr>
                        <th>Código</th>
                        <th>Remetente</th>
                        <th>Destinatário</th>
                        <th>Origem/Destino</th>
                        <th>Valor Total</th>
                        <th>Status</th>
                        <th>Ações</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="entrega" items="${entregas}">
                        <tr>
                            <td><strong>#${entrega.codigo}</strong></td>
                            <td>${entrega.remetente.nome}</td>
                            <td>${entrega.destinatario.nome}</td>
                            <td>${entrega.enderecoOrigem.cidade} → ${entrega.enderecoDestino.cidade}</td>
                            <td>R$ <fmt:formatNumber value="${entrega.valorTotalGeral}" pattern="#,##0.00"/></td>
                            <td>
                                <c:choose>
                                    <c:when test="${entrega.status == 'PENDENTE'}"><span class="badge badge-pendente">Pendente</span></c:when>
                                    <c:when test="${entrega.status == 'EM_TRANSITO'}"><span class="badge badge-transito">Em Trânsito</span></c:when>
                                    <c:when test="${entrega.status == 'REALIZADA'}"><span class="badge badge-realizada">Realizada</span></c:when>
                                    <c:otherwise><span class="badge badge-cancelada">Cancelada</span></c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <c:if test="${entrega.status != 'REALIZADA' and entrega.status != 'CANCELADA'}">
                                    <form method="post" action="${pageContext.request.contextPath}/entregas/atualizar-status" style="display: flex; gap: 5px;">
                                        <input type="hidden" name="entregaId" value="${entrega.id}">
                                        
                                        <c:if test="${entrega.status == 'PENDENTE'}">
                                            <button type="submit" name="status" value="EM_TRANSITO" class="btn btn-primary">Iniciar</button>
                                        </c:if>
                                        
                                        <c:if test="${entrega.status == 'EM_TRANSITO'}">
                                            <button type="submit" name="status" value="REALIZADA" class="btn btn-success">Finalizar</button>
                                        </c:if>

                                        <button type="submit" name="status" value="CANCELADA" class="btn btn-danger" 
                                                onclick="return confirm('Deseja realmente cancelar esta entrega?')">Cancelar</button>
                                    </form>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <div id="noResults" class="no-results">Nenhuma entrega encontrada para a sua pesquisa nesta categoria.</div>
        </div>
    </div>

    <footer>
        <p>&copy; 2025 Tartaruga Cometa - Sistema de Controle de Entregas</p>
    </footer>

    <script>
        function toggleDropdown() {
            document.getElementById("dropdownContent").classList.toggle("show");
            document.getElementById("dropdownBtn").classList.toggle("active");
        }

        window.onclick = function(event) {
            if (!event.target.matches('.dropdown-btn') && !event.target.closest('.dropdown-btn')) {
                var dropdowns = document.getElementsByClassName("dropdown-content");
                for (var i = 0; i < dropdowns.length; i++) {
                    var openDropdown = dropdowns[i];
                    if (openDropdown.classList.contains('show')) {
                        openDropdown.classList.remove('show');
                        document.getElementById("dropdownBtn").classList.remove('active');
                    }
                }
            }
        }

        function filterTable() {
            const input = document.getElementById("searchInput");
            const filter = input.value.toLowerCase();
            const table = document.getElementById("dataTable");
            const tr = table.getElementsByTagName("tr");
            const noResults = document.getElementById("noResults");
            let visibleRows = 0;

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
