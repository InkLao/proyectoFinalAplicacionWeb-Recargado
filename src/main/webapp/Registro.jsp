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
        } else {
            mensaje = "El nombre de usuario ya está en uso";
        }
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Registro de Usuario - FitRoutine</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        /* Tus estilos CSS aquí (se mantienen igual) */
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
                            
                            <% if (mensaje != null && !mensaje.isEmpty()) { %>
                                <div class="alert alert-info mt-3">
                                    <%= mensaje %>
                                </div>
                            <% } %>
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
                                <li><strong>Rutinas personalizadas</strong> adaptadas a tus objetivos</li>
                                <li><strong>Seguimiento de progreso</strong> con estadísticas detalladas</li>
                                <li><strong>Ejercicios demostrativos</strong> con videos instructivos</li>
                                <li><strong>Recordatorios</strong> para mantener tu disciplina</li>
                                <li><strong>Comunidad fitness</strong> para compartir tus logros</li>
                            </ul>
                            
                            <div class="text-center mt-4">
                                <img src="https://cdn-icons-png.flaticon.com/512/186/186095.png" class="img-fluid" style="max-height: 150px;" alt="Fitness App">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>