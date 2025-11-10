package servlets;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.regex.Pattern;

@WebServlet("/registro")
public class RegistroServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String EMAIL_REGEX = "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$";
    private static final Pattern EMAIL_PATTERN = Pattern.compile(EMAIL_REGEX);

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/registro.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String nombre = request.getParameter("nombre");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        StringBuilder errores = new StringBuilder();
        boolean valido = true;

        if (nombre == null || nombre.trim().isEmpty()) {
            errores.append("Nombre es obligatorio. ");
            valido = false;
        }
        if (email == null || !EMAIL_PATTERN.matcher(email).matches()) {
            errores.append("Correo electrónico inválido. ");
            valido = false;
        }
        if (password == null || password.length() < 6) {
            errores.append("Contraseña debe tener al menos 6 caracteres. ");
            valido = false;
        }

        if (!valido) {
            request.setAttribute("error", errores.toString());
            request.setAttribute("nombre", nombre);
            request.setAttribute("email", email);
            request.getRequestDispatcher("/registro.jsp").forward(request, response);
            return;
        }

        // Registro exitoso: guardar en sesión
        HttpSession session = request.getSession();
        session.setAttribute("usuario", nombre);

        // Cookie para recordar usuario
        Cookie cookie = new Cookie("ultimoUsuario", nombre);
        cookie.setMaxAge(7 * 24 * 60 * 60);
        cookie.setPath("/");
        response.addCookie(cookie);

        // Pasar nombre a JSP
        request.setAttribute("nombre", nombre);
        request.getRequestDispatcher("/bienvenida.jsp").forward(request, response);
    }
}