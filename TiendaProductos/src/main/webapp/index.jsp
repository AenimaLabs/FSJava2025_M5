<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tienda Online - Inicio</title>
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
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }

        .hero {
            background: white;
            padding: 60px 40px;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            text-align: center;
            max-width: 600px;
        }

        h1 {
            color: #667eea;
            font-size: 42px;
            margin-bottom: 20px;
        }

        p {
            color: #666;
            font-size: 18px;
            margin-bottom: 40px;
            line-height: 1.6;
        }

        .btn {
            display: inline-block;
            padding: 18px 40px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            text-decoration: none;
            border-radius: 50px;
            font-size: 18px;
            font-weight: 600;
            transition: all 0.3s;
            box-shadow: 0 10px 30px rgba(102, 126, 234, 0.3);
        }

        .btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 40px rgba(102, 126, 234, 0.4);
        }

        .icon {
            font-size: 64px;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="hero">
        <div class="icon">🛍️</div>
        <h1>Tienda Online</h1>
        <p>
            Sistema de gestión de productos.<br>
            Registra, administra y visualiza tu inventario de manera fácil y eficiente.
        </p>
        <a href="registro.jsp" class="btn">
            ✨ Comenzar a Registrar Productos
        </a>
    </div>
</body>
</html>



