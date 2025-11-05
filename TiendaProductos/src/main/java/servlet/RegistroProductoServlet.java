package servlet;

import model.Producto;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;



@WebServlet(name = "RegistroProductoServlet", urlPatterns = {"/registrar"})
public class RegistroProductoServlet extends HttpServlet {

@Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {

    //configurar codificación
    request.setCharacterEncoding("UTF-8");

    //obtener parámetros formulario
    String nombre = request.getParameter("nombre");
    String categoria = request.getParameter("categoria");
    String precioStr = request.getParameter("precio");
    String enOfertaStr = request.getParameter("enOferta");

    //convertir precio
    double precio = 0;
    try {
        precio = Double.parseDouble(precioStr);
    } catch (NumberFormatException e){
        precio = 0;
    }

    //verificar si está en oferta
    boolean enOferta = "on".equals(enOfertaStr);

    //crear producto
    Producto producto = new Producto(nombre, categoria, precio, enOferta);

    //obtener o crear lista de productos en sesion
    HttpSession session = request.getSession();
    List<Producto> listaProductos =(List<Producto>) session.getAttribute("productos");

    if (listaProductos == null) {
        listaProductos = new ArrayList<>();
    }

    listaProductos.add(producto);
    session.setAttribute("productos", listaProductos);

    //pasar el producto actual al request para mostrarlo
    request.setAttribute("productosActual", producto);

    //redirigir a resumen.jsp
    request.getRequestDispatcher("/resumen.jsp").forward(request, response);

}
}
