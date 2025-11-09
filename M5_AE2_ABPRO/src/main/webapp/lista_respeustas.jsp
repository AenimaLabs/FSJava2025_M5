<%@ page isELIgnored="false" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8"/>
  <title>Lista de respuestas</title>
  <style>
    body { font-family: Arial, sans-serif; margin: 2rem; }
    table { border-collapse: collapse; width: 100%; }
    th, td { border: 1px solid #ddd; padding: .6rem; }
    th { background: #f5f5f5; }
    .baja { background: #ffecec; }
    .etiqueta-baja { color:#d32029; font-weight: bold; }
  </style>
</head>
<body>
  <h1>Respuestas simuladas</h1>

  <%
    // Simulación rápida: lista de mapas
    java.util.List<java.util.Map<String,Object>> respuestas = new java.util.ArrayList<>();
    java.util.Map<String,Object> r;

    r = new java.util.HashMap<>(); r.put("nombre","Ana");   r.put("edad",25); r.put("recomendar","si"); r.put("calificacion",5); r.put("comentario","Excelente servicio."); respuestas.add(r);
    r = new java.util.HashMap<>(); r.put("nombre","Luis");  r.put("edad",17); r.put("recomendar","no"); r.put("calificacion",2); r.put("comentario","Podría mejorar.");    respuestas.add(r);
    r = new java.util.HashMap<>(); r.put("nombre","Sofía"); r.put("edad",31); r.put("recomendar","si"); r.put("calificacion",4); r.put("comentario","Muy útil.");         respuestas.add(r);
    r = new java.util.HashMap<>(); r.put("nombre","Diego"); r.put("edad",22); r.put("recomendar","no"); r.put("calificacion",1); r.put("comentario","No cumplió.");       respuestas.add(r);
    r = new java.util.HashMap<>(); r.put("nombre","Mia");   r.put("edad",19); r.put("recomendar","si"); r.put("calificacion",3); r.put("comentario","Bien en general.");  respuestas.add(r);

    request.setAttribute("respuestas", respuestas);
  %>

  <table>
    <thead>
      <tr>
        <th>Nombre</th>
        <th>Edad</th>
        <th>Calificación</th>
        <th>Comentario</th>
        <th>Recomienda</th>
      </tr>
    </thead>
    <tbody>
      <c:forEach var="item" items="${respuestas}">
        <tr class="<c:out value='${item.calificacion lt 3 ? "baja" : ""}'/>">
          <td><c:out value="${item.nombre}" /></td>
          <td><c:out value="${item.edad}" /></td>
          <td>
            <c:out value="${item.calificacion}" />
            <c:if test="${item.calificacion lt 3}">
              <span class="etiqueta-baja"> (Baja)</span>
            </c:if>
          </td>
          <td><c:out value="${item.comentario}" /></td>
          <td><c:out value="${item.recomendar}" /></td>
        </tr>
      </c:forEach>
    </tbody>
  </table>

  <p style="margin-top:1rem;"><a href="encuesta.jsp">Volver a la encuesta</a></p>
</body>
</html>