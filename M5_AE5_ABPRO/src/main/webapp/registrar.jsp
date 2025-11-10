<%@ page contentType="text/html; charset=UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head><meta charset="UTF-8"><title>Registrar</title></head>
<body>
  <h1>Registrar <c:out value="${entity == 'producto' ? 'Producto' : 'Cliente'}"/></h1>

  <c:choose>
    <c:when test="${entity == 'producto'}">
      <form method="post" action="<c:url value='/productos'/>">
        <input type="hidden" name="action" value="guardar">
        <label>Nombre: <input type="text" name="nombre" required></label><br>
        <label>Descripción: <textarea name="descripcion"></textarea></label><br>
        <label>Precio: <input type="number" step="0.01" min="0" name="precio" required></label><br>
        <button type="submit">Guardar</button>
        <a href="<c:url value='/dashboard'/>">Cancelar</a>
      </form>
    </c:when>

    <c:otherwise>
      <form method="post" action="<c:url value='/clientes'/>">
        <input type="hidden" name="action" value="guardar">
        <label>Nombre: <input type="text" name="nombre" required></label><br>
        <label>Email: <input type="email" name="email" required></label><br>
        <label>Teléfono: <input type="text" name="telefono" required></label><br>
        <button type="submit">Guardar</button>
        <a href="<c:url value='/dashboard'/>">Cancelar</a>
      </form>
    </c:otherwise>
  </c:choose>
</body>
</html>