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
            padding: 30px 0;
            text-align: center;
            box-shadow: var(--shadow);
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

        nav a {
            color: var(--white);
            text-decoration: none;
            margin: 0 15px;
            font-weight: 600;
            transition: color 0.3s;
        }

        nav a:hover { color: var(--accent-color); }

        .card {
            background: var(--white);
            border-radius: 8px;
            padding: 25px;
            margin-top: 20px;
            box-shadow: var(--shadow);
        }

        h2 { color: var(--primary-color); margin: 0; }

        .btn {
            padding: 8px 16px;
            border-radius: 4px;
            border: none;
            cursor: pointer;
            font-weight: 600;
            transition: all 0.3s;
            text-decoration: none;
            display: inline-block;
        }

        .btn-primary { background-color: var(--info-color); color: white; }
        .btn-primary:hover { background-color: #2980b9; }
        .btn-success { background-color: var(--success-color); color: white; }
        .btn-danger { background-color: var(--danger-color); color: white; }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        table th {
            background-color: #f8f9fa;
            color: var(--primary-color);
            text-align: left;
            padding: 12px;
            border-bottom: 2px solid #dee2e6;
        }

        table td {
            padding: 12px;
            border-bottom: 1px solid #eee;
        }

        .badge {
            padding: 4px 10px;
            border-radius: 20px;
            font-size: 0.8em;
            font-weight: bold;
            color: white;
        }

        .badge-pendente { background-color: var(--warning-color); }
        .badge-transito { background-color: var(--info-color); }
        .badge-realizada { background-color: var(--success-color); }
        .badge-cancelada { background-color: var(--danger-color); }

        .actions-flex form {
            display: flex;
            gap: 5px;
        }

        footer {
            text-align: center;
            padding: 20px 0;
            margin-top: 40px;
            color: #666;
        }
    </style>
</head>
<body>
    <header>
        <h1> Tartaruga Cometa</h1>
        <p>Sistema de Controle de Entregas</p>
    </header>

    <nav>
        <a href="${pageContext.request.contextPath}/">Dashboard</a>
        <a href="${pageContext.request.contextPath}/entregas/listar">Entregas</a>
        <a href="${pageContext.request.contextPath}/clientes">Clientes</a>
        <a href="${pageContext.request.contextPath}/produtos">Produtos</a>
    </nav>

    <div class="container">
        <div class="card">
            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
                <h2>Entregas Cadastradas</h2>
                <a href="${pageContext.request.contextPath}/entregas/nova" class="btn btn-primary">+ NOVA ENTREGA</a>
            </div>

            <table>
                <thead>
                    <tr>
                        <th>Código</th>
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
                                    <div class="actions-flex">
                                        <form method="post" action="${pageContext.request.contextPath}/entregas/atualizar-status">
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
                                    </div>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <footer>
        <p>&copy; 2025 Tartaruga Cometa - Desenvolvido por Maria Gabi 😼👍</p>
    </footer>
</body>
</html>
