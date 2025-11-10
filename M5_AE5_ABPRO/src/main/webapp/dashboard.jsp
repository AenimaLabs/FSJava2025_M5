<%@ page contentType="text/html; charset=UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Dashboard</title>
</head>
<body>
  <h1>Dashboard</h1>

  <nav>
    <a href="<c:url value='/productos?action=nuevo'/>">+ Nuevo Producto</a> |
    <a href="<c:url value='/clientes?action=nuevo'/>">+ Nuevo Cliente</a> |
    <a href="<c:url value='/logout'/>">Salir</a>
  </nav>

  <h2>Productos</h2>
  <c:choose>
    <c:when test="${not empty requestScope.productos}">
      <table border="1" cellpadding="5">
        <thead><tr><th>ID</th><th>Nombre</th><th>Descripción</th><th>Precio</th><th>Acciones</th></tr></thead>
        <tbody>
          <c:forEach var="p" items="${requestScope.productos}">
            <tr>
              <td>${p.id}</td>
              <td>${p.nombre}</td>
              <td>${p.descripcion}</td>
              <td>${p.precio}</td>
              <td>
                <a href="<c:url value='/productos?action=editar'><c:param name='id' value='${p.id}'/></c:url>">Editar</a>
                |
                <a href="<c:url value='/productos?action=eliminar'><c:param name='id' value='${p.id}'/></c:url>"
                   onclick="return confirm('¿Eliminar producto ${p.nombre}?')">Eliminar</a>
              </td>
            </tr>
          </c:forEach>
        </tbody>
      </table>
    </c:when>
    <c:otherwise><p>No hay productos cargados.</p></c:otherwise>
  </c:choose>

  <h2>Clientes</h2>
  <c:choose>
    <c:when test="${not empty requestScope.clientes}">
      <table border="1" cellpadding="5">
        <thead><tr><th>ID</th><th>Nombre</th><th>Email</th><th>Teléfono</th><th>Acciones</th></tr></thead>
        <tbody>
          <c:forEach var="cst" items="${requestScope.clientes}">
            <tr>
              <td>${cst.id}</td>
              <td>${cst.nombre}</td>
              <td>${cst.email}</td>
              <td>${cst.telefono}</td>
              <td>
                <a href="<c:url value='/clientes?action=editar'><c:param name='id' value='${cst.id}'/></c:url>">Editar</a>
                |
                <a href="<c:url value='/clientes?action=eliminar'><c:param name='id' value='${cst.id}'/></c:url>"
                   onclick="return confirm('¿Eliminar cliente ${cst.nombre}?')">Eliminar</a>
              </td>
            </tr>
          </c:forEach>
        </tbody>
      </table>
    </c:when>
    <c:otherwise><p>No hay clientes cargados.</p></c:otherwise>
  </c:choose>
</body>
</html>