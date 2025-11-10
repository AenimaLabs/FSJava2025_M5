package com.ejemplo.controller;

import com.ejemplo.dao.ProductoDAO;
import com.ejemplo.model.Producto;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.Optional;

@WebServlet("/productos")
public class ProductoServlet extends HttpServlet {

    private final ProductoDAO productoDAO = new ProductoDAO();
    private static final String VIEW_BASE = "/";

    private Integer parseId(HttpServletRequest request) {
        try { return Integer.valueOf(request.getParameter("id")); }
        catch (Exception e) { return null; }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) {
            response.sendRedirect(request.getContextPath() + "/dashboard");
            return;
        }

        switch (action) {
            case "nuevo": {
                request.setAttribute("entity", "producto");
                request.getRequestDispatcher(VIEW_BASE + "registrar.jsp").forward(request, response);
                break;
            }
            case "editar": {
                Integer id = parseId(request);
                if (id == null) { response.sendRedirect(request.getContextPath() + "/dashboard"); return; }

                Optional<Producto> opt = productoDAO.findById(id);
                if (opt.isEmpty()) { response.sendRedirect(request.getContextPath() + "/dashboard"); return; }

                request.setAttribute("entity", "producto");
                request.setAttribute("producto", opt.get());
                request.getRequestDispatcher(VIEW_BASE + "editar.jsp").forward(request, response);
                break;
            }
            case "eliminar": {
                Integer id = parseId(request);
                if (id != null) productoDAO.delete(id);
                response.sendRedirect(request.getContextPath() + "/dashboard");
                break;
            }
            default: {
                response.sendRedirect(request.getContextPath() + "/dashboard");
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");

        if ("guardar".equals(action)) {
            String nombre = request.getParameter("nombre");
            String descripcion = request.getParameter("descripcion");
            String precioStr = request.getParameter("precio");
            try {
                double precio = Double.parseDouble(precioStr);
                productoDAO.agregar(new Producto(nombre, descripcion, precio));
                response.sendRedirect(request.getContextPath() + "/dashboard");
            } catch (NumberFormatException e) {
                request.setAttribute("entity", "producto");
                request.setAttribute("error", "Precio inválido");
                request.getRequestDispatcher(VIEW_BASE + "registrar.jsp").forward(request, response);
            }
            return;
        }

        if ("actualizar".equals(action)) {
            Integer id = parseId(request);
            if (id == null) { response.sendRedirect(request.getContextPath() + "/dashboard"); return; }

            String nombre = request.getParameter("nombre");
            String descripcion = request.getParameter("descripcion");
            String precioStr = request.getParameter("precio");

            try {
                double precio = Double.parseDouble(precioStr);
                productoDAO.update(new Producto(id, nombre, descripcion, precio));
                response.sendRedirect(request.getContextPath() + "/dashboard");
            } catch (NumberFormatException e) {
                request.setAttribute("entity", "producto");
                request.setAttribute("error", "Precio inválido");
                request.setAttribute("producto", new Producto(id, nombre, descripcion, 0));
                request.getRequestDispatcher(VIEW_BASE + "editar.jsp").forward(request, response);
            }
            return;
        }

        response.sendRedirect(request.getContextPath() + "/dashboard");
    }
}