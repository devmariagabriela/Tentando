<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Erro - Tartaruga Cometa</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background: #f5f7fa;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }

        .error-container {
            background: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 2px 20px rgba(0,0,0,0.1);
            text-align: center;
            max-width: 600px;
            width: 90%;
        }

        .error-icon {
            font-size: 4rem;
            margin-bottom: 20px;
        }

        h1 {
            color: #c53030;
            margin-bottom: 10px;
        }

        .error-message {
            color: #4a5568;
            margin-bottom: 30px;
            line-height: 1.6;
        }

        .btn {
            display: inline-block;
            padding: 12px 30px;
            background: #4c51bf;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            font-weight: 600;
            transition: background 0.3s;
        }

        .btn:hover {
            background: #434190;
        }

        .stack-trace {
            background: #f7fafc;
            padding: 20px;
            border-radius: 5px;
            text-align: left;
            margin-top: 20px;
            font-family: monospace;
            font-size: 0.9rem;
            color: #718096;
            overflow-x: auto;
            display: none;
        }

        .toggle-stack {
            background: none;
            border: none;
            color: #4c51bf;
            cursor: pointer;
            margin-top: 15px;
            font-size: 0.9rem;
        }
    </style>
    <script>
        function toggleStackTrace() {
            const trace = document.getElementById('stack-trace');
            const button = document.getElementById('toggle-btn');

            if (trace.style.display === 'none') {
                trace.style.display = 'block';
                button.textContent = 'Ocultar detalhes técnicos';
            } else {
                trace.style.display = 'none';
                button.textContent = 'Mostrar detalhes técnicos';
            }
        }
    </script>
</head>
<body>
    <div class="error-container">
        <div class="error-icon">⚠️</div>
        <h1>Ocorreu um erro</h1>

        <div class="error-message">
            <p><strong>${erro}</strong></p>
            <p>Desculpe pelo inconveniente. Tente novamente ou entre em contato com o suporte.</p>
        </div>

        <div class="actions">
            <a href="${pageContext.request.contextPath}/" class="btn"> Voltar para o Início</a>
            <a href="javascript:history.back()" class="btn" style="background: #718096; margin-left: 10px;">
                 Voltar
            </a>
        </div>

        <button id="toggle-btn" class="toggle-stack" onclick="toggleStackTrace()">
            Mostrar detalhes técnicos
        </button>

        <div id="stack-trace" class="stack-trace">
            <c:if test="${not empty pageContext.exception}">
                ${pageContext.exception.stackTrace}
            </c:if>
        </div>
    </div>
</body>
</html>