<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
</head>
<body>
    <h2>Iniciar Sesión</h2>
    <%
        String error = (String) request.getAttribute("error");
        if (error != null) {
    %>
        <p style="color: red;"><%= error %></p>
    <%
        }
    %>
    <form action="login" method="post">
        <label>Nombre: <input type="text" name="nombre" required></label><br><br>
        <label>Contraseña: <input type="password" name="password" required></label><br><br>
        <button type="submit">Iniciar Sesión</button>
    </form>
    <br>
    <a href="registro">¿No tienes cuenta? Regístrate</a>
</body>
</html>