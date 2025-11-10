<%@ page contentType="text/html; charset=UTF-8" isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Error</title>
</head>
<body>
  <h1>Ocurrió un error</h1>
  <p>${requestScope['jakarta.servlet.error.message']}</p>
  <c:if test="${not empty exception}">
    <pre><%= exception %></pre>
  </c:if>
  <p><a href="<c:url value='/dashboard'/>">Volver al dashboard</a></p>
</body>
</html>