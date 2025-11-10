package com.ejemplo.controller;

import com.ejemplo.dao.ClienteDAO;
import com.ejemplo.dao.ProductoDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import com.ejemplo.model.Producto;
import com.ejemplo.model.Cliente;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {

    private final ProductoDAO productoDAO = new ProductoDAO();
    private final ClienteDAO clienteDAO = new ClienteDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("[DashboardServlet] GET /dashboard");

        List<Producto> prods = productoDAO.listar();
        List<Cliente>  clis  = clienteDAO.listar();

        System.out.println("[DashboardServlet] productos=" + prods.size()
                + ", clientes=" + clis.size());

        request.setAttribute("productos", prods);
        request.setAttribute("clientes",  clis);

        request.getRequestDispatcher("/dashboard.jsp").forward(request, response);
    }
}