package com.ejemplo.dao;

import com.ejemplo.model.Producto;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class ProductoDAO {

    private static final String SELECT_ALL =
            "SELECT id, nombre, descripcion, precio FROM producto ORDER BY id DESC";
    private static final String SELECT_ONE =
            "SELECT id, nombre, descripcion, precio FROM producto WHERE id = ?";
    private static final String INSERT =
            "INSERT INTO producto(nombre, descripcion, precio) VALUES(?, ?, ?)";
    private static final String UPDATE =
            "UPDATE producto SET nombre = ?, descripcion = ?, precio = ? WHERE id = ?";
    private static final String DELETE =
            "DELETE FROM producto WHERE id = ?";

    public List<Producto> listar() {
        List<Producto> productos = new ArrayList<>();
        try (Connection conn = ConexionDB.getConexion();
             PreparedStatement ps = conn.prepareStatement(SELECT_ALL);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                productos.add(new Producto(
                        rs.getInt("id"),
                        rs.getString("nombre"),
                        rs.getString("descripcion"),
                        rs.getDouble("precio")
                ));
            }
            System.out.println("[ProductoDAO] listar() -> " + productos.size() + " filas");
        } catch (SQLException e) {
            throw new RuntimeException("Error listando productos", e);
        }
        return productos;
    }

    public Optional<Producto> findById(int id) {
        try (Connection conn = ConexionDB.getConexion();
             PreparedStatement ps = conn.prepareStatement(SELECT_ONE)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return Optional.of(new Producto(
                            rs.getInt("id"),
                            rs.getString("nombre"),
                            rs.getString("descripcion"),
                            rs.getDouble("precio")
                    ));
                }
                return Optional.empty();
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error buscando producto id=" + id, e);
        }
    }

    public int agregar(Producto p) {
        try (Connection conn = ConexionDB.getConexion();
             PreparedStatement ps = conn.prepareStatement(INSERT, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, p.getNombre());
            ps.setString(2, p.getDescripcion());
            ps.setDouble(3, p.getPrecio());
            int rows = ps.executeUpdate();
            if (rows == 0) return 0;
            try (ResultSet keys = ps.getGeneratedKeys()) {
                if (keys.next()) return keys.getInt(1);
            }
            return 0;
        } catch (SQLException e) {
            throw new RuntimeException("Error insertando producto", e);
        }
    }

    public boolean update(Producto p) {
        try (Connection conn = ConexionDB.getConexion();
             PreparedStatement ps = conn.prepareStatement(UPDATE)) {
            ps.setString(1, p.getNombre());
            ps.setString(2, p.getDescripcion());
            ps.setDouble(3, p.getPrecio());
            ps.setInt(4, p.getId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new RuntimeException("Error actualizando producto id=" + p.getId(), e);
        }
    }

    public boolean delete(int id) {
        try (Connection conn = ConexionDB.getConexion();
             PreparedStatement ps = conn.prepareStatement(DELETE)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new RuntimeException("Error eliminando producto id=" + id, e);
        }
    }
}