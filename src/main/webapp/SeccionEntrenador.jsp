<%-- 
    Document   : SeccionEntrenador
    Created on : 19 may 2025, 2:13:46 a.m.
    Author     : eduar
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="colecciones.Rutina"%>
<%@page import="colecciones.GrupoMuscular"%>
<%@page import="daos.IRutinaDAO"%>
<%@page import="daos.RutinaDAO"%>
<%@page import="daos.IEjercicioDAO"%>
<%@page import="daos.EjercicioDAO"%>
<%@page import="colecciones.Ejercicio"%>
<%@page import="colecciones.Entrenador"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    
    HttpSession sesion = request.getSession(false);
    Entrenador entrenador = null;
    if (sesion != null) {
        entrenador = (Entrenador) sesion.getAttribute("entrenador");
    }

    String accion = request.getParameter("accion");

    if ("cerrarSesion".equalsIgnoreCase(accion)) {
        // Si el usuario está logueado, invalida la sesión
        if (entrenador != null) {
            sesion.invalidate(); // cerrar sesión correctamente
        }
        response.sendRedirect("IniciarSesionJSP.jsp");
        return;
    }
    
   

    IEjercicioDAO ejercicioDAO = new EjercicioDAO();
    IRutinaDAO rutinaDAO = new RutinaDAO();
    
    String mensaje = request.getParameter("mensaje");
    String error = request.getParameter("error");
%>

<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <title>Panel de Entrenador - FitRoutine</title>
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
                padding: 2rem;
            }

            .dashboard-container {
                background-color: rgba(255, 255, 255, 0.95);
                border-radius: 15px;
                box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
                padding: 2rem;
                max-width: 1200px;
                margin: 0 auto;
            }

            .exercise-card, .routine-card {
                background-color: rgba(74, 144, 226, 0.1);
                border-radius: 10px;
                padding: 1rem;
                margin-bottom: 1rem;
                transition: all 0.3s;
                border: none;
                box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            }

            .exercise-card:hover, .routine-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 15px 30px rgba(0,0,0,0.1);
            }

            .exercise-card .card-img-top {
                height: 150px;
                object-fit: cover;
                border-radius: 8px 8px 0 0;
            }

            .nav-tabs .nav-link.active {
                font-weight: bold;
                border-bottom: 3px solid var(--primary-color);
            }

            .tab-content {
                padding: 20px;
                border: 1px solid #dee2e6;
                border-top: none;
                border-radius: 0 0 10px 10px;
                background-color: white;
            }
        </style>
    </head>
    <body>
        <div class="dashboard-container">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2 class="mb-0">¡Bienvenido, Entrenador <span style="color: var(--primary-color);"><%= entrenador.getNombre() %></span>!</h2>
                <div>
                    <a href="LogoutServlet" class="btn btn-outline-danger">
                        <i class="fas fa-sign-out-alt me-1"></i> Cerrar Sesión
                    </a>
                </div>
            </div>

            <% if (mensaje != null) { %>
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <%= mensaje %>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            <% } %>

            <% if (error != null) { %>
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <%= error %>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            <% } %>

            <ul class="nav nav-tabs" id="entrenadorTabs" role="tablist">
                <li class="nav-item" role="presentation">
                    <button class="nav-link active" id="ejercicios-tab" data-bs-toggle="tab" 
                            data-bs-target="#ejercicios" type="button" role="tab" 
                            aria-controls="ejercicios" aria-selected="true">
                        <i class="fas fa-dumbbell"></i> Ejercicios
                    </button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link" id="rutinas-tab" data-bs-toggle="tab" 
                            data-bs-target="#rutinas" type="button" role="tab" 
                            aria-controls="rutinas" aria-selected="false">
                        <i class="fas fa-list-check"></i> Rutinas
                    </button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link" id="nuevo-tab" data-bs-toggle="tab" 
                            data-bs-target="#nuevo" type="button" role="tab" 
                            aria-controls="nuevo" aria-selected="false">
                        <i class="fas fa-plus-circle"></i> Agregar Nuevo
                    </button>
                </li>
            </ul>
            
            <%
            accion = request.getParameter("accion");
            String filtroNombre = request.getParameter("filtroNombre");

            List<Ejercicio> ejercicios = new ArrayList<>();

            if ("buscarEjercicios".equals(accion)) {
                if (filtroNombre != null && !filtroNombre.trim().isEmpty()) {
                    ejercicios = ejercicioDAO.buscarPorNombre(filtroNombre.trim());
                } else {
                    ejercicios = ejercicioDAO.obtenerTodosLosEjercicios();
                }
            } else {
                // Opción: puedes decidir si mostrar todos por defecto o nada
                ejercicios = ejercicioDAO.obtenerTodosLosEjercicios(); // o simplemente dejar la lista vacía
            }
        %>
        
        <form method="get" action="SeccionEntrenador.jsp" class="d-flex mb-4" role="search">
                <input type="text" name="filtroNombre" class="form-control me-2" placeholder="Buscar ejercicio por nombre"
                    value="<%= request.getParameter("filtroNombre") != null ? request.getParameter("filtroNombre") : "" %>">
                <button class="btn btn-outline-primary" type="submit" >Buscar</button>
                <input type="hidden" name="accion" value="buscarEjercicios">
            </form
            

            <div class="tab-content" id="entrenadorTabsContent">
                <div class="tab-pane fade show active" id="ejercicios" role="tabpanel" aria-labelledby="ejercicios-tab">
                    
                
                    
                    <div class="row">
                        <% for (Ejercicio ejercicio : ejercicios) { %>
                        <div class="col-md-4 mb-4">
                            <div class="exercise-card h-100">
                                <% if (ejercicio.getUrlImagenIncial() != null && !ejercicio.getUrlImagenIncial().isEmpty()) { %>
                                <img src="<%= ejercicio.getUrlImagenIncial() %>" class="card-img-top" alt="<%= ejercicio.getNombre() %>">
                                <% } else { %>
                                <div class="card-img-top bg-secondary text-white d-flex align-items-center justify-content-center" style="height: 150px;">
                                    <i class="fas fa-dumbbell fa-3x"></i>
                                </div>
                                <% } %>
                                <div class="card-body">
                                    <h5 class="card-title"><%= ejercicio.getNombre() %></h5>
                                    <p class="card-text"><%= ejercicio.getDescripcion() %></p>
                                    <div class="d-flex flex-wrap gap-1 mb-2">
                                        <% for (GrupoMuscular grupo : ejercicio.getGruposMusculares()) { %>
                                        <span class="badge bg-primary"><%= grupo %></span>
                                        <% } %>
                                    </div>
                                    <small class="text-muted">
                                        <i class="fas fa-dumbbell"></i> <%= ejercicio.getEquipamiento() != null ? ejercicio.getEquipamiento() : "Ninguno" %><br>
                                        <i class="fas fa-repeat"></i> <%= ejercicio.getSeries() %>x<%= ejercicio.getRepeticiones() %> rep<br>
                                        <i class="fas fa-clock"></i> <%= ejercicio.getTiempoDescanso() %>s descanso
                                    </small>
                                </div>
                            </div>
                        </div>
                        <% } %>
                    </div>
                </div>

                <div class="tab-pane fade" id="rutinas" role="tabpanel" aria-labelledby="rutinas-tab">
                    <div class="row">
                        <% for (Rutina rutina : rutinaDAO.obtenerTodosLasRutinas()) { %>
                        <div class="col-md-6 mb-4">
                            <div class="routine-card h-100">
                                <div class="card-header d-flex justify-content-between align-items-center">
                                    <h5 class="mb-0"><%= rutina.getNombreRutina() %></h5>
                                    <span class="badge <%= rutina.isAsignadaPorEntrenador() ? "bg-success" : "bg-primary" %>">
                                        <%= rutina.isAsignadaPorEntrenador() ? "Entrenador" : "Personalizada" %>
                                    </span>
                                </div>
                                <div class="card-body">
                                    <h6 class="card-subtitle mb-3"><i class="fas fa-dumbbell me-2"></i>Ejercicios:</h6>
                                    <ul class="list-group list-group-flush mb-3">
                                        <% for (Ejercicio ejercicio : rutina.getEjercicios()) { %>
                                        <li class="list-group-item d-flex justify-content-between align-items-center">
                                            <div>
                                                <strong><%= ejercicio.getNombre() %></strong><br>
                                                <small class="text-muted">
                                                    <%= ejercicio.getSeries() %>x<%= ejercicio.getRepeticiones() %> rep • 
                                                    <%= ejercicio.getTiempoDescanso() %>s descanso
                                                </small>
                                            </div>
                                            <div>
                                                <% for (GrupoMuscular grupo : ejercicio.getGruposMusculares()) { %>
                                                <span class="badge bg-primary me-1"><%= grupo %></span>
                                                <% } %>
                                            </div>
                                        </li>
                                        <% } %>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <% } %>
                    </div>
                </div>

                <div class="tab-pane fade" id="nuevo" role="tabpanel" aria-labelledby="nuevo-tab">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="card mb-4">
                                <div class="card-header">
                                    <i class="fas fa-dumbbell me-2"></i>Agregar Nuevo Ejercicio
                                </div>
                                <div class="card-body">
                                    <form action="AgregarEjercicio.jsp" method="get">
                                        <button type="submit" class="btn btn-primary w-100">
                                            <i class="fas fa-plus me-2"></i>Crear Ejercicio
                                        </button>
                                    </form>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="card mb-4">
                                <div class="card-header">
                                    <i class="fas fa-list-check me-2"></i>Crear Nueva Rutina
                                </div>
                                <div class="card-body">
                                    <form action="CrearRutina.jsp" method="get">
                                        <input type="hidden" name="esEntrenador" value="true">
                                        <button type="submit" class="btn btn-success w-100">
                                            <i class="fas fa-plus me-2"></i>Crear Rutina
                                        </button>
                                    </form>
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