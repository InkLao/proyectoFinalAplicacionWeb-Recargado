<%-- 
    Document   : SeccionAdmin
    Created on : 6 may 2025, 2:59:46 p.m.
    Author     : eduar
--%>

<%@page import="java.util.List"%>
<%@page import="daos.IUsuarioDAO"%>
<%@page import="daos.UsuarioDAO"%>
<%@page import="colecciones.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    IUsuarioDAO usuarioDao = new UsuarioDAO();
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Gestión de Usuarios</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    
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
</style>

<div class="container py-4">
    <div class="admin-header text-center">
        <h1><i class="fas fa-cogs"></i> Panel de Administración</h1>
        <p class="mb-0">Gestiona los usuarios de FitRoutine</p>
    </div>
    
    <div class="row">
        <div class="col-md-4">
            <div class="user-count">
                <h3><%= usuarioDao.obtenerTodosLosUsuario().size() %></h3>
                <p class="mb-0">Usuarios registrados</p>
            </div>
        </div>
    </div>
    
    <!-- Tabla (se mantiene igual, solo cambia el estilo) -->
    
    <div class="mt-4 text-center">
        
        <a href="AgregarEjercicio.jsp" class="btn btn-success">
            <i class="fas fa-plus"></i> Agregar ejercicio
        </a>
        
        <a href="#" class="btn btn-primary">
            <i class="fas fa-plus"></i> Crear nueva rutina
        </a>
        <a href="#" class="btn btn-secondary ml-2">
            <i class="fas fa-chart-line"></i> Ver estadísticas
        </a>
    </div>
</div>
    
<div class="container py-4">
    <h1 class="mb-4 text-center">Gestión de Usuarios</h1>


    <!-- Tabla -->
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
                    <%
                      List<Usuario> lista = usuarioDao.obtenerTodosLosUsuario();
                      for (Usuario usuario : lista){
                   %>
                   <tr>
                       <td><%= usuario.getId() %></td>
                       <td><%= usuario.getNombre() %></td>
                       <td><%= usuario.getUsuario()%></td>
                       <td><%= usuario.getContrasena() %></td>
                       <td>
                           <form action="SeccionAdmin.jsp" method="post">
                               <input type="hidden" name="accion" value="eliminar">
                               <input type="hidden" name="id" value="<%= usuario.getId() %>">
                               <button type="submit" class="btn btn-danger">Eliminar</button>
                           </form>
                           
                       </td>
                   </tr>
                   
                   <% }     %>
                   <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
                </tbody>
            </table>
        </div>
    </div>
</div>
</body>
</html>
