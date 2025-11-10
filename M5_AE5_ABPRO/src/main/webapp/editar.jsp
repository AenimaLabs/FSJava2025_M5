<%@ page contentType="text/html; charset=UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Editar</title>
</head>
<body>
  <h1>Editar <c:out value="${entity == 'producto' ? 'Producto' : 'Cliente'}"/></h1>

  <c:choose>
    <c:when test="${entity == 'producto'}">
      <form method="post" action="<c:url value='/productos'/>">
        <input type="hidden" name="action" value="actualizar">
        <input type="hidden" name="id" value="${requestScope.producto.id}">
        <label>Nombre: <input type="text" name="nombre" value="${requestScope.producto.nombre}" required></label><br>
        <label>Descripción: <textarea name="descripcion">${requestScope.producto.descripcion}</textarea></label><br>
        <label>Precio: <input type="number" step="0.01" min="0" name="precio" value="${requestScope.producto.precio}" required></label><br>
        <c:if test="${not empty error}">
          <p style="color:red">${error}</p>
        </c:if>
        <button type="submit">Actualizar</button>
        <a href="<c:url value='/dashboard'/>">Cancelar</a>
      </form>
    </c:when>

    <c:otherwise>
      <form method="post" action="<c:url value='/clientes'/>">
        <input type="hidden" name="action" value="actualizar">
        <input type="hidden" name="id" value="${requestScope.cliente.id}">
        <label>Nombre: <input type="text" name="nombre" value="${requestScope.cliente.nombre}" required></label><br>
        <label>Email: <input type="email" name="email" value="${requestScope.cliente.email}" required></label><br>
        <label>Teléfono: <input type="text" name="telefono" value="${requestScope.cliente.telefono}" required></label><br>
        <button type="submit">Actualizar</button>
        <a href="<c:url value='/dashboard'/>">Cancelar</a>
      </form>
    </c:otherwise>
  </c:choose>
</body>
</html>