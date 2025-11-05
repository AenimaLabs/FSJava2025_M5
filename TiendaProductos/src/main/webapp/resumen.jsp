<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Resumen del Producto</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 40px 20px;
        }

        .container {
            max-width: 900px;
            margin: 0 auto;
        }

        .card {
            background: white;
            padding: 30px;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            margin-bottom: 30px;
        }

        h1 {
            color: #667eea;
            text-align: center;
            margin-bottom: 30px;
            font-size: 32px;
        }

        h2 {
            color: #764ba2;
            margin-bottom: 20px;
            font-size: 24px;
            border-bottom: 3px solid #667eea;
            padding-bottom: 10px;
        }

        .producto-detalle {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 15px;
            margin-bottom: 20px;
        }

        .info-row {
            display: flex;
            justify-content: space-between;
            padding: 12px 0;
            border-bottom: 1px solid #e0e0e0;
        }

        .info-row:last-child {
            border-bottom: none;
        }

        .info-label {
            font-weight: 600;
            color: #555;
        }

        .info-value {
            color: #333;
            font-weight: 500;
        }

        .badge {
            display: inline-block;
            padding: 6px 15px;
            border-radius: 20px;
            font-size: 14px;
            font-weight: 600;
        }

        .badge-oferta {
            background: #ff4757;
            color: white;
        }

        .badge-normal {
            background: #2ed573;
            color: white;
        }

        .badge-categoria {
            background: #667eea;
            color: white;
        }

        .alert {
            padding: 15px 20px;
            border-radius: 10px;
            margin: 20px 0;
            font-weight: 500;
        }

        .alert-success {
            background: #d4edda;
            color: #155724;
            border-left: 4px solid #28a745;
        }

        .alert-warning {
            background: #fff3cd;
            color: #856404;
            border-left: 4px solid #ffc107;
        }

        .alert-danger {
            background: #f8d7da;
            color: #721c24;
            border-left: 4px solid #dc3545;
        }

        .tabla-productos {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        .tabla-productos th {
            background: #667eea;
            color: white;
            padding: 15px;
            text-align: left;
            font-weight: 600;
        }

        .tabla-productos td {
            padding: 12px 15px;
            border-bottom: 1px solid #e0e0e0;
        }

        .tabla-productos tr:hover {
            background: #f8f9fa;
        }

        .botones {
            display: flex;
            gap: 15px;
            margin-top: 30px;
        }

        .btn {
            flex: 1;
            padding: 15px;
            border: none;
            border-radius: 10px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            text-decoration: none;
            text-align: center;
            display: block;
        }

        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .btn-secondary {
            background: #6c757d;
            color: white;
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.2);
        }

        .empty-state {
            text-align: center;
            padding: 40px;
            color: #999;
        }

        .empty-state-icon {
            font-size: 64px;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>📋 Resumen del Producto Registrado</h1>

        <!-- Sección: Producto Actual -->
        <div class="card">
            <h2>✨ Producto Agregado</h2>

            <c:if test="${not empty productoActual}">
                <div class="producto-detalle">
                    <div class="info-row">
                        <span class="info-label">Nombre:</span>
                        <span class="info-value"><c:out value="${productoActual.nombre}"/></span>
                    </div>

                    <div class="info-row">
                        <span class="info-label">Categoría:</span>
                        <span class="info-value">
                            <span class="badge badge-categoria">
                                <c:out value="${productoActual.categoria}"/>
                            </span>
                        </span>
                    </div>

                    <div class="info-row">
                        <span class="info-label">Precio:</span>
                        <span class="info-value">$<c:out value="${productoActual.precio}"/></span>
                    </div>

                    <div class="info-row">
                        <span class="info-label">Estado:</span>
                        <span class="info-value">
                            <c:if test="${productoActual.enOferta}">
                                <span class="badge badge-oferta">🔥 EN OFERTA</span>
                            </c:if>
                            <c:if test="${not productoActual.enOferta}">
                                <span class="badge badge-normal">✅ Precio Normal</span>
                            </c:if>
                        </span>
                    </div>

                    <div class="info-row">
                        <span class="info-label">Longitud del nombre:</span>
                        <span class="info-value">
                            <c:out value="${fn:length(productoActual.nombre)}"/> caracteres
                        </span>
                    </div>
                </div>

                <!-- Alerta especial si está en oferta -->
                <c:if test="${productoActual.enOferta}">
                    <div class="alert alert-success">
                        🎉 ¡Este producto está en OFERTA! Los clientes adorarán este descuento.
                    </div>
                </c:if>

                <!-- Validación de precio negativo -->
                <c:if test="${productoActual.precio < 0}">
                    <div class="alert alert-danger">
                        ⚠️ ERROR: El precio no puede ser negativo. Por favor, corrija el valor.
                    </div>
                </c:if>

                <!-- Mensaje según categoría usando c:choose -->
                <c:choose>
                    <c:when test="${productoActual.categoria == 'Electrónica'}">
                        <div class="alert alert-success">
                            💻 Categoría Electrónica: Productos tecnológicos de última generación.
                            Asegúrate de incluir garantía.
                        </div>
                    </c:when>
                    <c:when test="${productoActual.categoria == 'Ropa'}">
                        <div class="alert alert-success">
                            👕 Categoría Ropa: Moda y estilo para todos.
                            Verifica tallas y materiales disponibles.
                        </div>
                    </c:when>
                    <c:when test="${productoActual.categoria == 'Alimentos'}">
                        <div class="alert alert-warning">
                            🍎 Categoría Alimentos: Productos frescos y nutritivos.
                            Revisa las fechas de caducidad periódicamente.
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="alert alert-success">
                            📦 Categoría General: Producto registrado correctamente.
                        </div>
                    </c:otherwise>
                </c:choose>
            </c:if>
        </div>

        <!-- Sección: Lista de Todos los Productos -->
        <div class="card">
            <h2>🛒 Inventario Completo</h2>

            <c:choose>
                <c:when test="${not empty productos}">
                    <p style="margin-bottom: 15px; color: #555;">
                        Total de productos registrados: <strong>${fn:length(productos)}</strong>
                    </p>

                    <table class="tabla-productos">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Nombre</th>
                                <th>Categoría</th>
                                <th>Precio</th>
                                <th>Estado</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="producto" items="${productos}" varStatus="status">
                                <tr>
                                    <td>${status.count}</td>
                                    <td><c:out value="${producto.nombre}"/></td>
                                    <td><c:out value="${producto.categoria}"/></td>
                                    <td>$<c:out value="${producto.precio}"/></td>
                                    <td>
                                        <c:if test="${producto.enOferta}">
                                            <span class="badge badge-oferta">OFERTA</span>
                                        </c:if>
                                        <c:if test="${not producto.enOferta}">
                                            <span class="badge badge-normal">Normal</span>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        <div class="empty-state-icon">📭</div>
                        <p>No hay productos registrados aún.</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- Botones de acción -->
        <div class="botones">
            <a href="registro.jsp" class="btn btn-primary">➕ Agregar Otro Producto</a>
            <a href="index.jsp" class="btn btn-secondary">🏠 Ir al Inicio</a>
        </div>
    </div>
</body>
</html>