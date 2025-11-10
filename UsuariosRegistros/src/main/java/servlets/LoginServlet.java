package servlets;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Datos ficticios para validación simple
    private static final String USUARIO_VALIDO = "Ana";
    private static final String CONTRASEÑA_VALIDA = "123456";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String nombre = request.getParameter("nombre");
        String password = request.getParameter("password");

        if (USUARIO_VALIDO.equals(nombre) && CONTRASEÑA_VALIDA.equals(password)) {
            HttpSession session = request.getSession();
            session.setAttribute("usuario", nombre);

            // Crear cookie de recordatorio (7 días)
            Cookie cookie = new Cookie("ultimoUsuario", nombre);
            cookie.setMaxAge(7 * 24 * 60 * 60); // 7 días
            cookie.setPath("/");
            response.addCookie(cookie);

            // Pasar nombre a JSP
            request.setAttribute("nombre", nombre);
            request.getRequestDispatcher("/bienvenida.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Usuario o contraseña incorrectos.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }
}