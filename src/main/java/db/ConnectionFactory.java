package db;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class ConnectionFactory {
    
    private static String url;
    private static String username;
    private static String password;
    private static String driver;
    
    static {
        loadDatabaseProperties();
    }
    
   
    private static void loadDatabaseProperties() {
        Properties props = new Properties();
        try (InputStream input = ConnectionFactory.class.getClassLoader()
                .getResourceAsStream("database.properties")) {
            
            if (input == null) {
                System.err.println("Arquivo database.properties não encontrado!");
                
                // Valores padrão caso o arquivo não exista
                
                url = "jdbc:postgresql://localhost:5432/tartaruga_cometa";
                username = "postgres";
                password = "postgres";
                driver = "org.postgresql.Driver";
                return;
            }
            
            props.load(input);
            url = props.getProperty("db.url");
            username = props.getProperty("db.username");
            password = props.getProperty("db.password");
            driver = props.getProperty("db.driver");
            
            // Registra o driver JDBC
            Class.forName(driver);
            
        } catch (IOException e) {
            System.err.println("Erro ao carregar database.properties: " + e.getMessage());
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            System.err.println("Driver PostgreSQL não encontrado: " + e.getMessage());
            e.printStackTrace();
        }
    }
    
 
    public static Connection getConnection() throws SQLException {
        try {
            return DriverManager.getConnection(url, username, password);
        } catch (SQLException e) {
            System.err.println("Erro ao obter conexão com o banco de dados:");
            System.err.println("URL: " + url);
            System.err.println("Usuário: " + username);
            throw e;
        }
    }
    
    public static void closeConnection(Connection connection) {
        if (connection != null) {
            try {
                connection.close();
            } catch (SQLException e) {
                System.err.println("Erro ao fechar conexão: " + e.getMessage());
            }
        }
    }
    
    public static boolean testConnection() {
        try (Connection conn = getConnection()) {
            return conn != null && !conn.isClosed();
        } catch (SQLException e) {
            System.err.println("Falha no teste de conexão: " + e.getMessage());
            return false;
        }
    }
}