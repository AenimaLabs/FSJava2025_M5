package com.ejemplo.dao;

import org.apache.commons.dbcp2.BasicDataSource;

import javax.sql.DataSource;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Properties;

public class ConexionDB {

    private static final BasicDataSource ds = new BasicDataSource();

    static {
        Properties props = new Properties();

        try (InputStream in = Thread.currentThread()
                .getContextClassLoader()
                .getResourceAsStream("db/db.properties")) {

            if (in == null) {
                throw new IllegalStateException("No se encontró el archivo db/db.properties en el classpath");
            }
            props.load(in);

        } catch (IOException e) {
            throw new RuntimeException("No se pudo leer db.properties", e);
        }

        String url    = props.getProperty("db.url");
        String user   = props.getProperty("db.user");
        String pass   = props.getProperty("db.pass");
        String driver = props.getProperty("db.driver", "com.mysql.cj.jdbc.Driver");

        if (url == null || user == null || pass == null) {
            throw new IllegalStateException("Faltan propiedades: verifica db.url, db.user y db.pass en db.properties");
        }

        StringBuilder sb = new StringBuilder(url);
        String sep = url.contains("?") ? "&" : "?";
        if (!url.contains("serverTimezone")) sb.append(sep).append("serverTimezone=America/Santiago").append(sep = "&");
        if (!url.contains("useUnicode"))     sb.append(sep).append("useUnicode=true&characterEncoding=UTF-8").append(sep = "&");
        if (!url.contains("useSSL"))         sb.append(sep).append("useSSL=false").append(sep = "&");
        if (!url.contains("allowPublicKeyRetrieval")) sb.append(sep).append("allowPublicKeyRetrieval=true");
        String finalUrl = sb.toString();

        ds.setDriverClassName(driver);
        ds.setUrl(finalUrl);
        ds.setUsername(user);
        ds.setPassword(pass);

        ds.setInitialSize(3);
        ds.setMaxTotal(15);
        ds.setMaxIdle(10);
        ds.setMinIdle(2);
    }

    private ConexionDB() { }

    public static Connection getConexion() throws SQLException {
        return ds.getConnection();
    }

    public static DataSource getDataSource() {
        return ds;
    }
}