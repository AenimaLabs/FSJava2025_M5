<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String nombreUsuario = (String) session.getAttribute("usuario");

    if (nombreUsuario == null) {
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("ultimoUsuario".equals(cookie.getName())) {
                    nombreUsuario = cookie.getValue();
                    session.setAttribute("usuario", nombreUsuario);
                    break;
                }
            }
        }
    }

    if (nombreUsuario == null) {
        nombreUsuario = (String) request.getAttribute("nombre");
    }

    String mensaje = (nombreUsuario != null)
        ? "¡Bienvenido, " + nombreUsuario + "!"
        : "Bienvenido, invitado.";
%>
<!DOCTYPE html>
<html>
<head>
    <title>Bienvenida</title>
</head>
<body>
    <h1><%= mensaje %></h1>
    <p>Estás en la página principal.</p>
    <a href="registro">Registrar otro usuario</a> |
    <a href="login">Volver a login</a>
</body>
</html>