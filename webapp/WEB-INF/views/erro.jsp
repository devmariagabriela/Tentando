<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Tartaruga Cometa</title>
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

        .dashboard-stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
            margin-top: 20px;
        }

        .stat-card {
            background: var(--white);
            padding: 25px;
            border-radius: 8px;
            text-align: center;
            box-shadow: var(--shadow);
            border-top: 5px solid var(--accent-color);
            transition: transform 0.3s;
        }

        .stat-card:hover {
            transform: translateY(-5px);
        }

        .stat-card p {
            font-size: 0.9em;
            color: #666;
            text-transform: uppercase;
            margin-bottom: 5px;
            font-weight: 600;
        }

        .stat-card h3 {
            font-size: 2.5em;
            margin: 0;
            color: var(--primary-color);
        }

        .card {
            background: var(--white);
            border-radius: 8px;
            padding: 25px;
            margin-bottom: 20px;
            box-shadow: var(--shadow);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
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

        .badge {
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 0.85em;
            font-weight: bold;
            color: white;
            display: inline-block;
        }

        .badge-pendente { background-color: var(--warning-color); }
        .badge-em-transito { background-color: var(--info-color); }
        .badge-realizada { background-color: var(--success-color); }
        .badge-cancelada { background-color: var(--danger-color); }

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
        <h2 style="margin-top: 20px;">Dashboard</h2>

        <div class="dashboard-stats">
            <div class="stat-card">
                <p>Total de Entregas</p>
                <h3>${totalEntregas}</h3>
            </div>
            <div class="stat-card" style="border-top-color: var(--warning-color);">
                <p>Pendentes</p>
                <h3 style="color: var(--warning-color);">${totalPendentes}</h3>
            </div>
            <div class="stat-card" style="border-top-color: var(--info-color);">
                <p>Em Trânsito</p>
                <h3 style="color: var(--info-color);">${totalEmTransito}</h3>
            </div>
            <div class="stat-card" style="border-top-color: var(--success-color);">
                <p>Realizadas</p>
                <h3 style="color: var(--success-color);">${totalRealizadas}</h3>
            </div>
        </div>

        <div class="card">
            <h2>Últimas Entregas</h2>
            <c:choose>
                <c:when test="${not empty ultimasEntregas}">
                    <table>
                        <thead>
                            <tr>
                                <th>Código</th>
                                <th>Remetente</th>
                                <th>Destinatário</th>
                                <th>Data Coleta</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="entrega" items="${ultimasEntregas}">
                                <tr>
                                    <td><strong>#${entrega.codigo}</strong></td>
                                    <td>${entrega.remetente.nome}</td>
                                    <td>${entrega.destinatario.nome}</td>
                                    <td>${entrega.dataColeta}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${entrega.status == 'PENDENTE'}">
                                                <span class="badge badge-pendente">Pendente</span>
                                            </c:when>
                                            <c:when test="${entrega.status == 'EM_TRANSITO'}">
                                                <span class="badge badge-em-transito">Em Trânsito</span>
                                            </c:when>
                                            <c:when test="${entrega.status == 'REALIZADA'}">
                                                <span class="badge badge-realizada">Realizada</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge badge-cancelada">Cancelada</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <p>Nenhuma entrega cadastrada ainda.</p>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <footer>
        <p>&copy; 2025 Tartaruga Cometa - Sistema de Controle de Entregas</p>
    </footer>
</body>
</html>
