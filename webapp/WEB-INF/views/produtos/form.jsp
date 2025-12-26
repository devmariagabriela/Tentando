<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><c:choose><c:when test="${produto != null}">Editar Produto</c:when><c:otherwise>Novo Produto</c:otherwise></c:choose> - Tartaruga Cometa</title>
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

        h3 {
            color: var(--accent-color);
            margin-bottom: 15px;
            margin-top: 20px;
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

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: var(--text-color);
        }

        .form-group input,
        .form-group select,
        .form-group textarea {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
            transition: border-color 0.3s;
            box-sizing: border-box;
            font-family: inherit;
        }

        .form-group input:focus,
        .form-group select:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: var(--accent-color);
            box-shadow: 0 0 0 3px rgba(39, 174, 96, 0.1);
        }

        .btn {
            display: inline-block;
            padding: 12px 24px;
            border-radius: 5px;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s;
            border: none;
            cursor: pointer;
            font-size: 14px;
            margin-right: 10px;
        }

        .btn-primary {
            background-color: var(--accent-color);
            color: white;
        }

        .btn-primary:hover {
            background-color: #229954;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
        }

        .btn-secondary {
            background-color: var(--secondary-color);
            color: white;
        }

        .btn-secondary:hover {
            background-color: #2c3e50;
        }

        footer {
            text-align: center;
            padding: 30px 0;
            background-color: var(--primary-color);
            color: var(--white);
            margin-top: 50px;
        }

        hr {
            margin: 30px 0;
            border: none;
            border-top: 1px solid #e2e8f0;
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
                        <li><a href="${pageContext.request.contextPath}/clientes">Clientes</a></li> 
            <li><a href="${pageContext.request.contextPath}/entregas/listar">Entregas</a></li>
            <li><a href="${pageContext.request.contextPath}/produtos">Produtos</a></li>
        </ul>
    </nav>

    <div class="container">
        <div class="card">
            <h2><c:choose><c:when test="${produto != null}">Editar Produto: ${produto.nome}</c:when><c:otherwise>Cadastrar Novo Produto</c:otherwise></c:choose></h2>

            <form method="post" action="${pageContext.request.contextPath}/produtos">
                <input type="hidden" name="id" value="${produto.id}">
                
                <div class="form-group">
                    <label for="nome">Nome do Produto *</label>
                    <input type="text" id="nome" name="nome" value="${produto.nome}"   minlength="3"   maxlength="50"  required>
                </div>

                <div class="form-group">
                    <label for="descricao">Descrição</label>
                    <textarea id="descricao" name="descricao" rows="3"   maxlength="300" placeholder="Máximo de 300 caracteres">${produto.descricao != null ? produto.descricao : ''}</textarea>
               
               		<small id="contadorDescricao">0 / 300</small>
                </div>
                
                <script>
					document.addEventListener("DOMContentLoaded", function () {
    				const textarea = document.getElementById("descricao");
    				const contador = document.getElementById("contadorDescricao");
   					const max = textarea.getAttribute("maxlength");

  					function atualizarContador() {
        			const atual = textarea.value.length;
        			contador.textContent = atual + " / " + max;
   				 }

    				textarea.addEventListener("input", atualizarContador);
    				atualizarContador(); 
					});
				</script>




                <div style="display: grid; grid-template-columns: 1fr 1fr 1fr; gap: 20px;">
                    <div class="form-group">
                        <label for="pesoKg">Peso (kg) *</label>
                        <input type="text" id="pesoKg" name="pesoKg"   value="${produto.pesoKg}" required maxlength="15" oninput="formatarPeso(this)">
                    </div>
                      <script>
                      function formatarPeso(campo) {
                    	    let valor = campo.value.replace(/\D/g, "");
                    	    if (valor.length > 12) {
                    	        valor = valor.slice(0, 12);
                          }
                    	    valor = (Number(valor) / 100).toFixed(2);
                    	    campo.value = valor
                            .replace(".", ",")                // decimal
                            .replace(/\B(?=(\d{3})+(?!\d))/g, "."); // milhar
                      }       
                      </script>


                    <div class="form-group">
                        <label for="volumeM3">Volume *</label>
                        <input type="text" id="volumeM3" name="volumeM3" step="0.001" min="0.001" value="${produto.volumeM3}" required  maxlength="15"    oninput="formatarNumero(this)">
                    </div>
                    <script>
                    function limitarVolume(input) {
                        const maxCaracteres = 5;
                        let valor = input.value.toString();
                        if (valor.length > maxCaracteres) {
                            input.value = valor.slice(0, maxCaracteres);
                        }
                    }       
                    </script>
                    <script>
                    function formatarNumero(campo) {
                        let valor = campo.value.replace(/\D/g, "");
                        valor = (Number(valor) / 1000).toFixed(3);
                        campo.value = valor
                        .replace(".", ",")              // decimal
                        .replace(/\B(?=(\d{3})+(?!\d))/g, "."); // milhar
                    }
                    </script>


                    <div class="form-group">
                        <label for="unidadeVolume">Unidade de Volume *</label>
                        <select id="unidadeVolume" name="unidadeVolume" required>
                            <option value="cm3" ${produto.unidadeVolume == 'cm3' ? 'selected' : ''}>cm³ (centímetros cúbicos)</option>
                            <option value="ml" ${produto.unidadeVolume == 'ml' ? 'selected' : ''}>mL (mililitros)</option>
                            <option value="dm3" ${produto.unidadeVolume == 'dm3' ? 'selected' : ''}>dm³ (decímetros cúbicos)</option>
                            <option value="l" ${produto.unidadeVolume == 'l' ? 'selected' : ''}>L (litros)</option>
                            <option value="m3" ${produto.unidadeVolume == 'm3' || produto.unidadeVolume == null ? 'selected' : ''}>m³ (metros cúbicos)</option>
                        </select>
                    </div>
                </div>

                <div class="form-group">
                    <label for="valorUnitario">Valor Unitário (R$) *</label>
                    <input type="text" id="valorUnitario" name="valorUnitario"  value="${produto.valorUnitario}" required     maxlength="15" oninput="formatarValor(this)">
                </div>
                <script>
                function formatarValor(campo) {
                    let valor = campo.value.replace(/\D/g, ""); // remove tudo que não for número
                    if (valor.length > 12) {
                        valor = valor.slice(0, 12);
                    }
                    valor = (Number(valor) / 100).toFixed(2);
                    campo.value = valor
                    .replace(".", ",")                // decimal
                    .replace(/\B(?=(\d{3})+(?!\d))/g, "."); // milhar
                }
                </script>


                <hr>

                <div style="text-align: right;">
                    <a href="${pageContext.request.contextPath}/produtos" class="btn btn-secondary">Cancelar</a>
                    <button type="submit" class="btn btn-primary"><c:choose><c:when test="${produto != null}">Salvar Alterações</c:when><c:otherwise>Cadastrar Produto</c:otherwise></c:choose></button>
                </div>
            </form>
        </div>
    </div>

    <footer>
        <p>&copy; 2025 Tartaruga Cometa - Sistema de Controle de Entregas</p>
    </footer>
</body>
</html>
