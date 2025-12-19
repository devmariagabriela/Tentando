
# 🐢 Tartaruga Cometa: Sistema de Controle de Entregas



Este é um sistema simples de gerenciamento de entregas, desenvolvido em Java com JSP/Servlet e JDBC, utilizando o padrão MVC (Model-View-Controller).

## 🚀 Funcionalidades Principais

- **Cadastro de Entregas:** Registro de novas entregas com dados de remetente, destinatário, produtos e datas.
- **Controle de Status:** Acompanhamento do status da entrega (Pendente, Em Trânsito, Realizada, Cancelada).
- **Dashboard:** Visão geral com o total de entregas por status e as últimas movimentações.
- **Gerenciamento de Cadastros:** CRUD (Criação, Leitura, Atualização e Exclusão) de Clientes e Produtos.

## 🛠️ Tecnologias Utilizadas

- **Backend:** Java (Servlets, JDBC)
- **Frontend:** JSP, HTML5, CSS
- **Banco de Dados:** SQL (Configurado para usar um banco de dados relacional, como MySQL ou PostgreSQL)
- **Ferramenta de Build:** Gradle

## 📂 Estrutura do Projeto

O projeto segue a estrutura padrão de um aplicativo web Java:

| Diretório | Descrição |
| :--- | :--- |
| `src/main/java/controller` | Contém os Servlets (Controladores) que gerenciam as requisições. |
| `src/main/java/dao` | Contém as classes DAO (Data Access Object) para interação com o banco de dados. |
| `src/main/java/model` | Contém as classes de Modelo (Entidades) do sistema. |
| `src/main/webapp/WEB-INF/views` | Contém os arquivos JSP (Visões) que geram o HTML. |
| `src/main/webapp/css` | Contém o arquivo `style.css` para estilização. |

## ⚙️ Como Executar o Projeto

1. **Clone o repositório:**
    ```bash
    git clone https://github.com/devmariagabriela/Tentando.git
    ```
2. **Configure o Banco de Dados:**
    * Crie o banco de dados.
    * Execute o script de criação de tabelas (`schema.sql` em `src/main/resources` ).
    * Configure as credenciais de acesso no arquivo `database.properties` (em `src/main/resources`).
3. **Execute o Build:**
    ```bash
    ./gradlew build
    ```
4. **Deploy:**
    * Implante o arquivo `.war` gerado em um servidor de aplicação Java (como Tomcat ou Jetty).
    * Acesse a aplicação no seu navegador.

---
Desenvolvido por **MARIA GABI** 😼👍
