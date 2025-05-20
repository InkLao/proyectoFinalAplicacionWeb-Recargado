<%-- 
    Document   : SeccionAdmin
    Created on : 6 may 2025, 2:59:46 p.m.
    Author     : eduar
--%>

<%@page import="daos.IEntrenadorDAO"%>
<%@page import="daos.EntrenadorDAO"%>
<%@page import="java.util.List"%>
<%@page import="daos.IUsuarioDAO"%>
<%@page import="daos.UsuarioDAO"%>
<%@page import="colecciones.Usuario"%>
<%@page import="colecciones.Entrenador"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    IUsuarioDAO usuarioDao = new UsuarioDAO();
    IEntrenadorDAO entrenadorDao = new EntrenadorDAO();
    
    String accion = request.getParameter("accion");
    String mensaje = request.getParameter("mensaje");
    
    // Manejar acciones para entrenadores
    if ("agregarEntrenador".equals(accion)) {
        String nombre = request.getParameter("nombre");
        String usuario = request.getParameter("usuario");
        String contrasena = request.getParameter("contrasena");
        
        if (!entrenadorDao.existeEntrenador(usuario)) {
            Entrenador nuevoEntrenador = new Entrenador(nombre, usuario, contrasena);
            entrenadorDao.agregarEntrenador(nuevoEntrenador);
            mensaje = "Entrenador agregado exitosamente";
        } else {
            mensaje = "El nombre de usuario ya está en uso";
        }
    } else if ("eliminarEntrenador".equals(accion)) {
        String id = request.getParameter("id");
        if (id != null && !id.isEmpty()) {
            entrenadorDao.eliminarEntrenador(new org.bson.types.ObjectId(id));
            mensaje = "Entrenador eliminado exitosamente";
        }
    }
%>

<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <title>Gestión de Usuarios y Entrenadores - FitRoutine</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <style>
            .admin-header {
                background: linear-gradient(to right, #2c3e50, #4a90e2);
                color: white;
                padding: 20px 0;
                margin-bottom: 30px;
                border-radius: 10px;
            }

            .table-responsive {
                border-radius: 10px;
                overflow: hidden;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            }

            .table thead {
                background: linear-gradient(to right, #4a90e2, #6a5acd);
                color: white;
            }

            .table th {
                border: none !important;
            }

            .btn-danger {
                border-radius: 20px;
                padding: 5px 15px;
                font-weight: 600;
                transition: all 0.3s;
            }

            .btn-danger:hover {
                transform: translateY(-2px);
            }

            .user-count {
                background-color: #f8f9fa;
                border-radius: 10px;
                padding: 15px;
                margin-bottom: 20px;
                text-align: center;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            }

            .user-count h3 {
                color: #4a90e2;
                font-weight: 700;
            }
            
            .tab-content {
                padding: 20px;
                border: 1px solid #dee2e6;
                border-top: none;
                border-radius: 0 0 10px 10px;
            }
            
            .nav-tabs .nav-link.active {
                font-weight: bold;
                border-bottom: 3px solid #4a90e2;
            }
        </style>
    </head>
    <body class="bg-light">
        <div class="container py-4">
            <div class="admin-header text-center">
                <h1><i class="fas fa-cogs"></i> Panel de Administración</h1>
                <p class="mb-0">Gestiona usuarios y entrenadores de FitRoutine</p>
                <div class="mt-2">
                    <a href="LogoutServlet" class="btn btn-danger btn-sm">
                        <i class="fas fa-sign-out-alt"></i> Cerrar sesión
                    </a>
                </div>
            </div>

            <% if (mensaje != null) { %>
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <%= mensaje %>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            <% } %>

            <div class="row mb-4">
                <div class="col-md-4">
                    <div class="user-count">
                        <h3><%= usuarioDao.obtenerTodosLosUsuario().size() %></h3>
                        <p class="mb-0">Usuarios registrados</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="user-count">
                        <h3><%= entrenadorDao.obtenerTodosLosEntrenadores().size() %></h3>
                        <p class="mb-0">Entrenadores registrados</p>
                    </div>
                </div>
            </div>

            <ul class="nav nav-tabs" id="adminTabs" role="tablist">
                <li class="nav-item" role="presentation">
                    <button class="nav-link active" id="usuarios-tab" data-bs-toggle="tab" 
                            data-bs-target="#usuarios" type="button" role="tab" 
                            aria-controls="usuarios" aria-selected="true">
                        <i class="fas fa-users"></i> Usuarios
                    </button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link" id="entrenadores-tab" data-bs-toggle="tab" 
                            data-bs-target="#entrenadores" type="button" role="tab" 
                            aria-controls="entrenadores" aria-selected="false">
                        <i class="fas fa-user-tie"></i> Entrenadores
                    </button>
                </li>

            </ul>

            <div class="tab-content" id="adminTabsContent">
                <div class="tab-pane fade show active" id="usuarios" role="tabpanel" aria-labelledby="usuarios-tab">
                    <div class="card">
                        <div class="card-header">Lista de Usuarios</div>
                        <div class="card-body p-0">
                            <table class="table table-striped table-bordered m-0">
                                <thead class="table-dark">
                                    <tr>
                                        <th>ID</th>
                                        <th>Nombre</th>
                                        <th>Usuario</th>
                                        <th>Contraseña</th>
                                        <th>Acciones</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% for (Usuario usuario : usuarioDao.obtenerTodosLosUsuario()) { %>
                                    <tr>
                                        <td><%= usuario.getId() %></td>
                                        <td><%= usuario.getNombre() %></td>
                                        <td><%= usuario.getUsuario() %></td>
                                        <td><%= usuario.getContrasena() %></td>
                                        <td>
                                            <form action="SeccionAdmin.jsp" method="post">
                                                <input type="hidden" name="accion" value="eliminar">
                                                <input type="hidden" name="id" value="<%= usuario.getId() %>">
                                                <button type="submit" class="btn btn-danger">Eliminar</button>
                                            </form>
                                        </td>
                                    </tr>
                                    <% } %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

                <div class="tab-pane fade" id="entrenadores" role="tabpanel" aria-labelledby="entrenadores-tab">
                    <div class="card mb-4">
                        <div class="card-header">Agregar Nuevo Entrenador</div>
                        <div class="card-body">
                            <form action="SeccionAdmin.jsp" method="post">
                                <input type="hidden" name="accion" value="agregarEntrenador">
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
                                <button type="submit" class="btn btn-primary">Agregar Entrenador</button>
                            </form>
                        </div>
                    </div>

                    <div class="card">
                        <div class="card-header">Lista de Entrenadores</div>
                        <div class="card-body p-0">
                            <table class="table table-striped table-bordered m-0">
                                <thead class="table-dark">
                                    <tr>
                                        <th>ID</th>
                                        <th>Nombre</th>
                                        <th>Usuario</th>
                                        <th>Contraseña</th>
                                        <th>Acciones</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% for (Entrenador entrenador : entrenadorDao.obtenerTodosLosEntrenadores()) { %>
                                    <tr>
                                        <td><%= entrenador.getId() %></td>
                                        <td><%= entrenador.getNombre() %></td>
                                        <td><%= entrenador.getUsuario() %></td>
                                        <td><%= entrenador.getContrasena() %></td>
                                        <td>
                                            <form action="SeccionAdmin.jsp" method="post">
                                                <input type="hidden" name="accion" value="eliminarEntrenador">
                                                <input type="hidden" name="id" value="<%= entrenador.getId() %>">
                                                <button type="submit" class="btn btn-danger">Eliminar</button>
                                            </form>
                                        </td>
                                    </tr>
                                    <% } %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>


            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>