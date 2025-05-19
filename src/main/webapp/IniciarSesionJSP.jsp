<%-- 
    Document   : IniciarSesioJSP
    Created on : 6 may 2025, 2:59:16 p.m.
    Author     : eduar
--%>

<%@page import="colecciones.Usuario"%>
<%@page import="daos.UsuarioDAO"%>
<%@page import="daos.IUsuarioDAO"%>
<%@page import="daos.IEntrenadorDAO"%>
<%@page import="daos.EntrenadorDAO"%>
<%@page import="colecciones.Entrenador"%>
<%@page import="objetoNegocio.ControlUsuarios"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String accion = request.getParameter("accion");
    
    String nombre = request.getParameter("nombre");
    String password = request.getParameter("password");
    
    String mensaje = request.getParameter("mensaje");
    
    IUsuarioDAO usuarioDAO = new UsuarioDAO();
    IEntrenadorDAO entrenadorDAO = new EntrenadorDAO();
    
    if ("Iniciar".equals(accion)) {
        // Verificar si es admin
        if(nombre.equals("admin") && password.equals("admin")){
            response.sendRedirect("SeccionAdmin.jsp");
            return;
        }
        
        // Verificar si es entrenador
        Entrenador entrenador = entrenadorDAO.buscarEntrenadorPorUsuario(nombre);
        if (entrenador != null) {
            if (entrenador.getContrasena().equals(password)) {
                HttpSession a = request.getSession();
                a.setAttribute("entrenador", entrenador);
                response.sendRedirect("SeccionEntrenador.jsp");
                return;
            } else {
                mensaje = "Credenciales incorrectas";
            }
        }
        // Verificar si es usuario normal
        else if(usuarioDAO.existeUsuario(nombre)){
            Usuario usuario = usuarioDAO.buscarUsuarioPorNombreUsuario(nombre);
            
            if (usuario != null && usuario.getContrasena().equals(password)) {
                request.setAttribute("usuario", usuario); // Enviar el objeto
                
                // Enviamos el objeto a la seccion podiendolo obtener aunque se recargue la pagina
                request.getSession().setAttribute("usuario", usuario);
                
                
                RequestDispatcher dispatcher = request.getRequestDispatcher("InicioUsuario.jsp");
                dispatcher.forward(request, response); // Redirección interna
                
                return;
            } else {
                mensaje = "Credenciales incorrectas";
            }
        } else {
            mensaje = "El usuario no existe";
        }
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Iniciar Sesión - FitRoutine</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #4a90e2;
            --secondary-color: #ff6b6b;
            --dark-color: #2c3e50;
            --light-color: #f7f9fc;
        }
        
        body {
            background: url('https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80') no-repeat center center fixed;
            background-size: cover;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            min-height: 100vh;
            display: flex;
            align-items: center;
        }
        
        .login-box {
            background-color: rgba(255, 255, 255, 0.95);
            border-radius: 15px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
            padding: 2.5rem;
            max-width: 450px;
            width: 100%;
            margin: 0 auto;
            border: 1px solid rgba(255, 255, 255, 0.3);
            backdrop-filter: blur(5px);
        }
        
        .login-header {
            text-align: center;
            margin-bottom: 2rem;
        }
        
        .login-header img {
            width: 80px;
            margin-bottom: 1rem;
        }
        
        .login-header h2 {
            color: var(--dark-color);
            font-weight: 700;
        }
        
        .form-control {
            border-radius: 8px;
            padding: 12px 15px;
            border: 1px solid #ddd;
            margin-bottom: 1rem;
        }
        
        .btn-login {
            background: linear-gradient(to right, var(--primary-color), var(--secondary-color));
            border: none;
            color: white;
            padding: 12px;
            font-weight: 600;
            border-radius: 8px;
            width: 100%;
            transition: all 0.3s;
        }
        
        .btn-login:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
        }
        
        .features-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 1rem;
            text-align: center;
            margin: 2rem 0;
        }
        
        .feature-item {
            padding: 1rem;
            border-radius: 8px;
            background-color: rgba(74, 144, 226, 0.1);
        }
        
        .feature-icon {
            font-size: 1.5rem;
            color: var(--primary-color);
            margin-bottom: 0.5rem;
        }
        
        .register-link {
            text-align: center;
            margin-top: 1.5rem;
        }
        
        .divider {
            display: flex;
            align-items: center;
            margin: 1.5rem 0;
            color: #6c757d;
        }
        
        .divider::before, .divider::after {
            content: "";
            flex: 1;
            border-bottom: 1px solid #dee2e6;
        }
        
        .divider::before {
            margin-right: 1rem;
        }
        
        .divider::after {
            margin-left: 1rem;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="login-box">
            <div class="login-header">
                <img src="https://cdn-icons-png.flaticon.com/512/2936/2936886.png" alt="FitRoutine Logo">
                <h2>Iniciar Sesión</h2>
                <p class="text-muted">Controla tus rutinas de ejercicio y alcanza tus metas</p>
            </div>
            
            <% if (mensaje != null && !mensaje.isEmpty()) { %>
                <div class="alert alert-warning">
                    <%= mensaje %>
                </div>
            <% } %>
            
            <form action="IniciarSesionJSP.jsp" method="post">
                <input type="hidden" name="accion" value="Iniciar">
                
                <div class="mb-3">
                    <label for="nombre" class="form-label">Nombre de usuario</label>
                    <input type="text" class="form-control" id="nombre" name="nombre" required>
                </div>
                
                <div class="mb-3">
                    <label for="password" class="form-label">Contraseña</label>
                    <input type="password" class="form-control" id="password" name="password" required>
                </div>
                
                <button type="submit" class="btn-login">Iniciar Sesión</button>
            </form>
            
            <div class="features-grid">
                <div class="feature-item">
                    <div class="feature-icon">🏋️</div>
                    <div class="feature-text small">Rutinas</div>
                </div>
                <div class="feature-item">
                    <div class="feature-icon">📊</div>
                    <div class="feature-text small">Progreso</div>
                </div>
                <div class="feature-item">
                    <div class="feature-icon">🏆</div>
                    <div class="feature-text small">Logros</div>
                </div>
            </div>
            
            <div class="divider">o</div>
            
            <div class="register-link">
                <p>¿No tienes cuenta? <a href="Registro.jsp" class="text-primary">Regístrate aquí</a></p>
            </div>
        </div>
    </div>
</body>
</html>