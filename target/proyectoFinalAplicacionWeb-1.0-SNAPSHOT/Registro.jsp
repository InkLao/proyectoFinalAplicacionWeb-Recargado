<%-- 
    Document   : Registro
    Created on : 6 may 2025, 3:24:13 p.m.
    Author     : eduar
--%>


<%@page import="daos.IUsuarioDAO"%>
<%@page import="daos.UsuarioDAO"%>
<%@page import="colecciones.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    IUsuarioDAO usuarioDAO = new UsuarioDAO();
    String accion = request.getParameter("accion");
    String mensaje = "";

    if ("registrar".equals(accion)) {
        String nombre = request.getParameter("nombre");
        String usuario = request.getParameter("usuario");
        String contrasena = request.getParameter("contrasena");

        if (!usuarioDAO.existeUsuario(usuario)) {
            Usuario nuevoUsuario = new Usuario(nombre, usuario, contrasena);
            usuarioDAO.agregarUsuario(nuevoUsuario);
            mensaje = "Usuario registrado exitosamente!";
            response.sendRedirect("IniciarSesionJSP.jsp");
        } else {
            mensaje = "El nombre de usuario ya está en uso";
        }
    }
%>

<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Registro de Usuario - FitRoutine</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <style>
            :root {
                --primary-color: #2a9d8f;
                --secondary-color: #264653;
                --accent-color: #e9c46a;
                --light-color: #f8f9fa;
                --dark-color: #343a40;
            }

            body {
                background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                min-height: 100vh;
                display: flex;
                align-items: center;
            }

            .register-card {
                background-color: white;
                border-radius: 15px;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
                overflow: hidden;
                transition: transform 0.3s ease;
            }

            .register-card:hover {
                transform: translateY(-5px);
            }

            .register-header {
                background: linear-gradient(to right, var(--primary-color), var(--secondary-color));
                color: white;
                padding: 2rem;
                text-align: center;
            }

            .register-header h2 {
                font-weight: 700;
                margin-bottom: 0.5rem;
            }

            .register-header i {
                margin-right: 10px;
            }

            .register-body {
                padding: 2rem;
            }

            .fitness-icon {
                background-color: var(--primary-color);
                color: white;
                width: 60px;
                height: 60px;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                margin: 0 auto 1rem;
                font-size: 1.5rem;
            }

            .btn-register {
                background-color: var(--primary-color);
                color: white;
                border: none;
                padding: 10px 20px;
                width: 100%;
                border-radius: 50px;
                font-weight: 600;
                transition: all 0.3s;
                margin-top: 1rem;
            }

            .btn-register:hover {
                background-color: var(--secondary-color);
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            }

            .form-control {
                border-radius: 50px;
                padding: 10px 20px;
                border: 1px solid #ddd;
                transition: all 0.3s;
            }

            .form-control:focus {
                border-color: var(--primary-color);
                box-shadow: 0 0 0 0.25rem rgba(42, 157, 143, 0.25);
            }

            .divider {
                display: flex;
                align-items: center;
                margin: 2rem 0;
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

            .login-link {
                text-align: center;
            }

            .login-link a {
                color: var(--primary-color);
                font-weight: 600;
                text-decoration: none;
            }

            .login-link a:hover {
                text-decoration: underline;
            }

            .benefits-section {
                background-color: #f8f9fa;
                padding: 2rem;
                border-radius: 10px;
                height: 100%;
            }

            .benefits-list {
                list-style-type: none;
                padding-left: 0;
            }

            .benefits-list li {
                padding: 1rem 0;
                border-bottom: 1px solid #eee;
                display: flex;
                align-items: flex-start;
                margin-bottom: 1rem;
            }

            .benefits-list li:last-child {
                border-bottom: none;
            }

            .benefits-list li::before {
                content: "✓";
                color: var(--primary-color);
                margin-right: 12px;
                font-weight: bold;
                margin-top: 3px; /* Alinea mejor el check */
            }

            @media (max-width: 768px) {
                .register-body {
                    padding: 1.5rem;
                }

                .benefits-section {
                    margin-top: 2rem;
                }
            }
        </style>
    </head>
    <body>
        <div class="container py-4">
            <div class="register-card">
                <div class="register-header">
                    <h2><i class="fas fa-dumbbell"></i> Únete a FitRoutine</h2>
                    <p class="mb-0">Comienza tu viaje fitness hoy mismo</p>
                </div>

                <div class="register-body">
                    <div class="row">
                        <div class="col-md-6">
                            <form action="Registro.jsp" method="post">
                                <input type="hidden" name="accion" value="registrar">

                                <div class="text-center mb-4">
                                    <div class="fitness-icon">
                                        <i class="fas fa-user-plus"></i>
                                    </div>
                                    <h3>Crear Cuenta</h3>
                                </div>

                                <div class="mb-3">
                                    <label for="nombre" class="form-label">Nombre Completo</label>
                                    <input type="text" class="form-control" id="nombre" name="nombre" required>
                                </div>

                                <div class="mb-3">
                                    <label for="usuario" class="form-label">Nombre de Usuario</label>
                                    <input type="text" class="form-control" id="usuario" name="usuario" required>
                                </div>

                                <div class="mb-3">
                                    <label for="contrasena" class="form-label">Contraseña</label>
                                    <input type="password" class="form-control" id="contrasena" name="contrasena" required>
                                </div>

                                <button type="submit" class="btn-register">Registrarse</button>

                                <% if (mensaje != null && !mensaje.isEmpty()) {%>
                                <div class="alert alert-info mt-3">
                                    <%= mensaje%>
                                </div>
                                <% }%>
                            </form>

                            <div class="divider">o</div>

                            <div class="login-link">
                                <p>¿Ya tienes una cuenta? <a href="IniciarSesionJSP.jsp">Inicia sesión</a></p>
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="benefits-section">
                                <h4 class="text-center mb-4"><i class="fas fa-star"></i> Beneficios de registrarte</h4>
                                <ul class="benefits-list">
                                    <li>
                                        <div class="benefit-item">
                                           
                                            <div class="benefit-text">
                                                <strong>Rutinas personalizadas</strong> adaptadas a tus objetivos
                                            </div>
                                        </div>
                                    </li>
                                    <li>
                                        <div class="benefit-item">
                                            
                                            <div class="benefit-text">
                                                <strong>Seguimiento de progreso</strong> con estadísticas detalladas
                                            </div>
                                        </div>
                                    </li>
                                    <li>
                                        <div class="benefit-item">
                                            
                                            <div class="benefit-text">
                                                <strong>Ejercicios demostrativos</strong> con videos instructivos
                                            </div>
                                        </div>
                                    </li><li>
                                        <div class="benefit-item">
                                            
                                            <div class="benefit-text">
                                                <strong>Recordatorios</strong> para mantener tu disciplina
                                            </div>
                                        </div>
                                    </li><li>
                                        <div class="benefit-item">
                                            
                                            <div class="benefit-text">
                                                <strong>Comunidad fitness </strong> para compartir tus logros
                                            </div>
                                        </div>
                                    </li>

                                </ul>

                                <div class="text-center mt-4">
                                    <img src="https://images.vexels.com/media/users/3/132662/isolated/preview/9abcfba41c34a0aaa7ef1eeb82d944ad-icono-de-levantamiento-de-pesas.png" class="img-fluid" style="max-height: 150px;" alt="Fitness App">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>