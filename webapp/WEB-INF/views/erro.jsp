<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Erro - Tartaruga Cometa</title>
    <style>
        :root {
            --primary-color: #090979;
            --secondary-color: #090979;
            --danger-color: #e74c3c;
            --info-color: #3498db;
            --light-bg: #f4f7f6;
            --white: #ffffff;
            --text-color: #333;
            --shadow: 0 4px 6px rgba(0,0,0,0.1 );
        }
        body { font-family: 'Segoe UI', sans-serif; background-color: var(--light-bg); color: var(--text-color); margin: 0; padding: 0; }
        .container { max-width: 800px; margin: 0 auto; padding: 40px 20px; }
        header { background-color: var(--primary-color); color: var(--white); padding: 40px 0; text-align: center; }
        .card { background: var(--white); border-radius: 8px; padding: 40px; margin-top: 40px; box-shadow: var(--shadow); border-top: 5px solid var(--danger-color); text-align: center; }
        h2 { color: var(--danger-color); }
        .btn { display: inline-block; padding: 12px 24px; border-radius: 5px; text-decoration: none; font-weight: 600; color: white; margin: 10px; }
        .btn-back { background-color: var(--secondary-color); }
        .btn-home { background-color: var(--info-color); }
    </style>
</head>
<body>
    <header><h1>Tartaruga Cometa</h1></header>
    <div class="container">
        <div class="card">
            <h2>Ocorreu um Erro</h2>
            <p style="font-size: 1.2em; margin: 20px 0;">
                <c:choose>
                    <c:when test="${not empty erro}">${erro}</c:when>
                    <c:otherwise>Desculpe, ocorreu um problema inesperado.</c:otherwise>
                </c:choose>
            </p>
            <div style="margin-top: 30px;">
                <a href="javascript:history.back()" class="btn btn-back">⬅ Voltar</a>
                <a href="${pageContext.request.contextPath}/" class="btn btn-home">Ir para o Dashboard</a>
            </div>
        </div>
    </div>
</body>
</html>
