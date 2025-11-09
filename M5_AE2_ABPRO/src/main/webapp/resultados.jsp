<%@ page isELIgnored="false" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8"/>
  <title>Resultados de la Encuesta</title>
  <style>
    body { font-family: Arial, sans-serif; margin: 2rem; }
    .ok { background:#e9f9ef; border:1px solid #b7ebc6; padding: .8rem; }
    .warn { background:#fff6e6; border:1px solid #ffd591; padding: .8rem; }
  </style>
</head>
<body>
  <h1>Resultados</h1>

  <p><strong>Nombre:</strong> <c:out value="${param.nombre}" /></p>
  <p><strong>Edad:</strong> <c:out value="${param.edad}" /></p>
  <p><strong>¿Recomendarías?</strong> <c:out value="${param.recomendar}" /></p>
  <p><strong>Calificación:</strong> <c:out value="${param.calificacion}" /></p>
  <p><strong>Comentario:</strong> <c:out value="${param.comentario}" /></p>

  <!-- Agradecimiento especial si calificación >= 4 -->
  <c:if test="${param.calificacion ge 4}">
    <div class="ok">¡Gracias por tu buena calificación! 🙌</div>
  </c:if>

  <!-- Mensaje según recomendar -->
  <c:choose>
    <c:when test="${param.recomendar == 'si'}">
      <p>¡Nos alegra que nos recomiendes! 💙</p>
    </c:when>
    <c:when test="${param.recomendar == 'no'}">
      <p>Gracias por tu honestidad. Trabajaremos para mejorar.</p>
    </c:when>
    <c:otherwise>
      <p>No seleccionaste una opción de recomendación.</p>
    </c:otherwise>
  </c:choose>

  <!-- Largo del comentario -->
  <p>Tu comentario tiene <strong>${fn:length(param.comentario)}</strong> caracteres.</p>

  <!-- Advertencia si edad < 18 -->
  <c:if test="${param.edad lt 18}">
    <div class="warn">Aviso: Eres menor de 18 años. Algunos contenidos podrían estar limitados.</div>
  </c:if>

  <p style="margin-top:1.5rem;"><a href="encuesta.jsp">Volver a la encuesta</a></p>
</body>
</html>