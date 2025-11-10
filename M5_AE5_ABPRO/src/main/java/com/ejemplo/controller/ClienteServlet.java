package com.ejemplo.controller;

import com.ejemplo.dao.ClienteDAO;
import com.ejemplo.model.Cliente;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.Optional;

@WebServlet("/clientes")
public class ClienteServlet extends HttpServlet {

    private final ClienteDAO clienteDAO = new ClienteDAO();
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
                request.setAttribute("entity", "cliente");
                request.getRequestDispatcher(VIEW_BASE + "registrar.jsp").forward(request, response);
                break;
            }
            case "editar": {
                Integer id = parseId(request);
                if (id == null) { response.sendRedirect(request.getContextPath() + "/dashboard"); return; }

                Optional<Cliente> opt = clienteDAO.findById(id);
                if (opt.isEmpty()) { response.sendRedirect(request.getContextPath() + "/dashboard"); return; }

                request.setAttribute("entity", "cliente");
                request.setAttribute("cliente", opt.get());
                request.getRequestDispatcher(VIEW_BASE + "editar.jsp").forward(request, response);
                break;
            }
            case "eliminar": {
                Integer id = parseId(request);
                if (id != null) clienteDAO.delete(id);
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
            String email  = request.getParameter("email");
            String telefono = request.getParameter("telefono");

            clienteDAO.agregar(new Cliente(nombre, email, telefono));
            response.sendRedirect(request.getContextPath() + "/dashboard");
            return;
        }

        if ("actualizar".equals(action)) {
            Integer id = parseId(request);
            if (id == null) { response.sendRedirect(request.getContextPath() + "/dashboard"); return; }

            String nombre = request.getParameter("nombre");
            String email  = request.getParameter("email");
            String telefono = request.getParameter("telefono");

            clienteDAO.update(new Cliente(id, nombre, email, telefono));
            response.sendRedirect(request.getContextPath() + "/dashboard");
            return;
        }

        response.sendRedirect(request.getContextPath() + "/dashboard");
    }
}