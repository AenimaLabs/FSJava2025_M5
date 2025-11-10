<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Registro</title>
</head>
<body>
    <h2>Formulario de Registro</h2>
    <%
        String error = (String) request.getAttribute("error");
        String nombrePre = (String) request.getAttribute("nombre");
        String emailPre = (String) request.getAttribute("email");
        if (error != null) {
    %>
        <p style="color: red;"><%= error %></p>
    <%
        }
    %>
    <form action="registro" method="post">
        <label>Nombre: <input type="text" name="nombre" value="<%= nombrePre != null ? nombrePre : "" %>" required></label><br><br>
        <label>Correo: <input type="email" name="email" value="<%= emailPre != null ? emailPre : "" %>" required></label><br><br>
        <label>Contraseña (mín. 6 caracteres): <input type="password" name="password" required></label><br><br>
        <button type="submit">Registrarse</button>
    </form>
    <br>
    <a href="login">¿Ya tienes cuenta? Inicia sesión</a>
</body>
</html>