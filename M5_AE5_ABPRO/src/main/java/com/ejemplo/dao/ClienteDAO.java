package com.ejemplo.dao;

import com.ejemplo.model.Cliente;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class ClienteDAO {

    private static final String SELECT_ALL =
            "SELECT id, nombre, correo, telefono FROM cliente ORDER BY id DESC";
    private static final String SELECT_ONE =
            "SELECT id, nombre, correo, telefono FROM cliente WHERE id = ?";
    private static final String INSERT =
            "INSERT INTO cliente(nombre, correo, telefono) VALUES(?, ?, ?)";
    private static final String UPDATE =
            "UPDATE cliente SET nombre = ?, correo = ?, telefono = ? WHERE id = ?";
    private static final String DELETE =
            "DELETE FROM cliente WHERE id = ?";

    public List<Cliente> listar() {
        List<Cliente> clientes = new ArrayList<>();
        try (Connection conn = ConexionDB.getConexion();
             PreparedStatement ps = conn.prepareStatement(SELECT_ALL);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                clientes.add(new Cliente(
                        rs.getInt("id"),
                        rs.getString("nombre"),
                        rs.getString("correo"),   // mapea a email del modelo
                        rs.getString("telefono")
                ));
            }
            System.out.println("[ClienteDAO] listar() -> " + clientes.size() + " filas");
        } catch (SQLException e) {
            throw new RuntimeException("Error listando clientes", e);
        }
        return clientes;
    }

    public Optional<Cliente> findById(int id) {
        try (Connection conn = ConexionDB.getConexion();
             PreparedStatement ps = conn.prepareStatement(SELECT_ONE)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return Optional.of(new Cliente(
                            rs.getInt("id"),
                            rs.getString("nombre"),
                            rs.getString("correo"),
                            rs.getString("telefono")
                    ));
                }
                return Optional.empty();
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error buscando cliente id=" + id, e);
        }
    }

    public int agregar(Cliente c) {
        try (Connection conn = ConexionDB.getConexion();
             PreparedStatement ps = conn.prepareStatement(INSERT, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, c.getNombre());
            ps.setString(2, c.getEmail());   // en BD se llama 'correo'
            ps.setString(3, c.getTelefono());
            int rows = ps.executeUpdate();
            if (rows == 0) return 0;
            try (ResultSet keys = ps.getGeneratedKeys()) {
                if (keys.next()) return keys.getInt(1);
            }
            return 0;
        } catch (SQLException e) {
            throw new RuntimeException("Error insertando cliente", e);
        }
    }

    public boolean update(Cliente c) {
        try (Connection conn = ConexionDB.getConexion();
             PreparedStatement ps = conn.prepareStatement(UPDATE)) {
            ps.setString(1, c.getNombre());
            ps.setString(2, c.getEmail());   // map -> correo
            ps.setString(3, c.getTelefono());
            ps.setInt(4, c.getId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new RuntimeException("Error actualizando cliente id=" + c.getId(), e);
        }
    }

    public boolean delete(int id) {
        try (Connection conn = ConexionDB.getConexion();
             PreparedStatement ps = conn.prepareStatement(DELETE)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new RuntimeException("Error eliminando cliente id=" + id, e);
        }
    }
}