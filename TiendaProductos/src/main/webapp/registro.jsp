<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registro de Productos - Tienda Online</title>
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

        .container {
            background: white;
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            max-width: 500px;
            width: 100%;
        }

        h1 {
            color: #667eea;
            text-align: center;
            margin-bottom: 30px;
            font-size: 28px;
        }

        .form-group {
            margin-bottom: 25px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            color: #333;
            font-weight: 600;
            font-size: 14px;
        }

        input[type="text"],
        input[type="number"],
        select {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            font-size: 15px;
            transition: all 0.3s;
        }

        input[type="text"]:focus,
        input[type="number"]:focus,
        select:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        .checkbox-group {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        input[type="checkbox"] {
            width: 20px;
            height: 20px;
            cursor: pointer;
        }

        .checkbox-group label {
            margin: 0;
            cursor: pointer;
        }

        button {
            width: 100%;
            padding: 15px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: transform 0.2s, box-shadow 0.2s;
        }

        button:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(102, 126, 234, 0.3);
        }

        button:active {
            transform: translateY(0);
        }

        .icon {
            margin-right: 8px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🛍️ Registro de Productos</h1>

        <form action="registrar" method="post">
            <div class="form-group">
                <label for="nombre">📦 Nombre del Producto</label>
                <input type="text" id="nombre" name="nombre"
                       placeholder="Ej: Laptop HP" required>
            </div>

            <div class="form-group">
                <label for="categoria">📁 Categoría</label>
                <select id="categoria" name="categoria" required>
                    <option value="">-- Selecciona una categoría --</option>
                    <option value="Electrónica">Electrónica</option>
                    <option value="Ropa">Ropa</option>
                    <option value="Alimentos">Alimentos</option>
                </select>
            </div>

            <div class="form-group">
                <label for="precio">💰 Precio</label>
                <input type="number" id="precio" name="precio"
                       step="0.01" min="0" placeholder="0.00" required>
            </div>

            <div class="form-group">
                <div class="checkbox-group">
                    <input type="checkbox" id="enOferta" name="enOferta">
                    <label for="enOferta">🔥 ¿Está en oferta?</label>
                </div>
            </div>

            <button type="submit">
                <span class="icon">✅</span>
                Registrar Producto
            </button>
        </form>
    </div>
</body>
</html>