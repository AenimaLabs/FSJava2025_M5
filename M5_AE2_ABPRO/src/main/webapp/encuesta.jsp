<%@ page isELIgnored="false" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8"/>
  <title>Encuesta</title>
  <style>
    body { font-family: Arial, sans-serif; margin: 2rem; }
    form { max-width: 540px; display: grid; gap: .8rem; }
    label { font-weight: 600; }
    .row { display: grid; gap: .3rem; }
    button { padding: .6rem 1rem; }
  </style>
</head>
<body>
  <h1>Encuesta de satisfacción</h1>

  <form action="resultados.jsp" method="post" accept-charset="UTF-8">
    <div class="row">
      <label for="nombre">Nombre</label>
      <input id="nombre" name="nombre" type="text" required />
    </div>

    <div class="row">
      <label for="edad">Edad</label>
      <input id="edad" name="edad" type="number" min="0" required />
    </div>

    <div class="row">
      <span>¿Recomendarías este sitio?</span>
      <label><input type="radio" name="recomendar" value="si" required/> Sí</label>
      <label><input type="radio" name="recomendar" value="no" /> No</label>
    </div>

    <div class="row">
      <label for="calificacion">Calificación (1 a 5)</label>
      <select id="calificacion" name="calificacion" required>
        <option value="">-- Selecciona --</option>
        <c:forEach var="n" begin="1" end="5">
          <option value="${n}">${n}</option>
        </c:forEach>
      </select>
    </div>

    <div class="row">
      <label for="comentario">Comentario adicional</label>
      <textarea id="comentario" name="comentario" rows="4" maxlength="500"></textarea>
    </div>

    <button type="submit">Enviar</button>
  </form>

  <p style="margin-top:2rem">
    ¿Quieres ver una lista simulada? <a href="lista_respuestas.jsp">Lista de respuestas</a>
    <!-- o vía servlet: <a href="lista">Lista de respuestas</a> -->
  </p>
</body>
</html>