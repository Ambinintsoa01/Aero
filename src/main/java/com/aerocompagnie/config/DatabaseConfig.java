package com.aerocompagnie.config;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;
import java.sql.Connection;
import java.sql.SQLException;

public class DatabaseConfig {
    private static HikariDataSource ds;

    static {
        try {
            HikariConfig config = new HikariConfig();
            config.setDriverClassName("org.postgresql.Driver");
            config.setJdbcUrl("jdbc:postgresql://postgres:5432/compagnie_aero");
            config.setUsername("aero_user");
            config.setPassword("aero_password");
            config.addDataSourceProperty("cachePrepStmts", "true");
            config.setMaximumPoolSize(20);
            ds = new HikariDataSource(config);
        } catch (Exception e) {
            throw new RuntimeException("Unable to initialize datasource", e);
        }
    }

    public static Connection getConnection() throws SQLException {
        return ds.getConnection();
    }
}