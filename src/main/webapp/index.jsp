<!DOCTYPE html>
<html>
<head>
    <title>Tartaruga Cometa - Sistema de Entregas</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { 
            font-family: Arial, sans-serif; 
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .container {
            background: white;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            text-align: center;
            width: 90%;
            max-width: 600px;
        }
        h1 { 
            color: #333; 
            margin-bottom: 10px;
            font-size: 2.5em;
        }
        h1 span { color: #667eea; }
        p { color: #666; margin-bottom: 30px; }
        .logo {
            font-size: 60px;
            margin-bottom: 20px;
        }
        .btn {
            display: inline-block;
            background: #667eea;
            color: white;
            padding: 15px 30px;
            margin: 10px;
            border-radius: 50px;
            text-decoration: none;
            font-weight: bold;
            transition: all 0.3s;
            border: none;
            cursor: pointer;
            font-size: 16px;
        }
        .btn:hover {
            background: #764ba2;
            transform: translateY(-3px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.2);
        }
        .btn-secondary {
            background: #4CAF50;
        }
        .btn-secondary:hover {
            background: #45a049;
        }
        .menu {
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            margin-top: 30px;
        }
        .status {
            margin-top: 30px;
            padding: 20px;
            background: #f5f5f5;
            border-radius: 10px;
        }
        .status p { margin: 5px 0; color: #333; }
        .error { color: #ff4444; }
        .success { color: #00C851; }
    </style>
</head>
<body>
    <div class="container">
        <div class="logo"></div>
        <h1>Bem-vindo ao <span>Tartaruga Cometa</span></h1>
        <p>Sistema de Gerenciamento de Entregas</p>
        
        <div class="menu">
            <a href="lancar-entrega" class="btn"> Nova Entrega</a>
            <a href="lista-entregas" class="btn"> Listar Entregas</a>
            <a href="cadastrar-cliente" class="btn btn-secondary">Cadastrar Cliente</a>
            <a href="cadastrar-produto" class="btn btn-secondary"> Cadastrar Produto</a>
        </div>
        
        <div class="status">
            <h3>Status do Sistema</h3>
            <p> Tomcat Funcionando</p>
            <p> Data/Hora do Servidor: <%= new java.util.Date() %></p>
            <p> Context Path: ${pageContext.request.contextPath}</p>
            <p> Servidor: <%= application.getServerInfo() %></p>
        </div>
    </div>
</body>
</html>


