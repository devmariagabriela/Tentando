<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Lançar Entrega</title>
</head>
<body>
    <h1>Lançar Nova Entrega</h1>

    <form action="lancar-entrega" method="post">
        <h2>Dados da Entrega</h2>

        Data Prevista: <input type="date" name="dataPrevista" required><br><br>

        Valor do Frete: <input type="number" step="0.01" name="valorFrete" required><br><br>

        Observações:<br>
        <textarea name="observacoes" rows="4" cols="50"></textarea><br><br>

        <input type="submit" value="Lançar Entrega">
    </form>

    <br>
    <a href="lista-entregas">Ver Entregas</a>
</body>
</html>