<%-- 
    Document   : CrearRutina
    Created on : 13 may 2025, 3:30:23 p.m.
    Author     : eduar
--%>

<%@page import="daos.IEjercicioDAO"%>
<%@page import="daos.EjercicioDAO"%>
<%@page import="colecciones.Ejercicio"%>
<%@page import="colecciones.GrupoMuscular"%> <!-- Importación añadida -->
<%@page import="colecciones.Entrenador"%>
<%@page import="colecciones.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    // Verificar sesión
    HttpSession sessionObj = request.getSession(false);
    boolean esEntrenador = "true".equals(request.getParameter("esEntrenador"));
    
    if (esEntrenador) {
        Entrenador entrenador = (Entrenador) sessionObj.getAttribute("entrenador");
        if (entrenador == null) {
            response.sendRedirect("IniciarSesionJSP.jsp");
            return;
        }
    } else {
        Usuario usuario = (Usuario) sessionObj.getAttribute("usuario");
        if (usuario == null) {
            response.sendRedirect("IniciarSesionJSP.jsp");
            return;
        }
    }
    
    IEjercicioDAO ejercicioDAO = new EjercicioDAO();
    String error = (String) sessionObj.getAttribute("error");
    if (error != null) {
        sessionObj.removeAttribute("error");
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Crear Nueva Rutina - FitRoutine</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .exercise-selection {
            max-height: 400px;
            overflow-y: auto;
            margin: 15px 0;
            border: 1px solid #ddd;
            padding: 10px;
            border-radius: 5px;
        }
        .selected-exercises {
            margin: 15px 0;
            padding: 15px;
            background-color: #f8f9fa;
            border-radius: 5px;
            border: 1px dashed #ccc;
        }
    </style>
</head>
<body>
    <div class="container py-4">
        <div class="card">
            <div class="card-header">
                <h3><i class="fas fa-plus-circle me-2"></i>Crear Nueva Rutina</h3>
            </div>
            <div class="card-body">
                <% if (error != null) { %>
                    <div class="alert alert-danger">
                        <%= error %>
                    </div>
                <% } %>
                
                <form action="GuardarRutina.jsp" method="post">
                    <input type="hidden" name="esEntrenador" value="<%= esEntrenador %>">
                    
                    <div class="mb-3">
                        <label for="nombreRutina" class="form-label">Nombre de la Rutina</label>
                        <input type="text" class="form-control" id="nombreRutina" name="nombreRutina" required>
                    </div>
                    
                    <div class="mb-3">
                        <label class="form-label">Seleccionar Ejercicios</label>
                        <div class="input-group mb-2">
                            <input type="text" id="exerciseSearch" class="form-control" placeholder="Buscar ejercicios...">
                            <button class="btn btn-outline-secondary" type="button" onclick="buscarEjercicios()">
                                <i class="fas fa-search"></i>
                            </button>
                        </div>
                        <div class="exercise-selection" id="exerciseSelection">
                            <% for (Ejercicio ejercicio : ejercicioDAO.obtenerTodosLosEjercicios()) { %>
                            <div class="form-check mb-2">
                                <input class="form-check-input exercise-checkbox" type="checkbox" 
                                       value="<%= ejercicio.getId().toString() %>" 
                                       id="ex-<%= ejercicio.getId().toString() %>"
                                       name="ejercicios">
                                <label class="form-check-label" for="ex-<%= ejercicio.getId().toString() %>">
                                    <strong><%= ejercicio.getNombre() %></strong> - 
                                    <% for (GrupoMuscular grupo : ejercicio.getGruposMusculares()) { %>
                                    <span class="badge bg-primary me-1"><%= grupo.name() %></span>
                                    <% } %>
                                </label>
                            </div>
                            <% } %>
                        </div>
                    </div>
                    
                    <div class="selected-exercises" id="selectedExercises">
                        <p class="text-muted mb-0"><i class="fas fa-info-circle me-1"></i>No hay ejercicios seleccionados</p>
                    </div>
                    
                    <div class="d-grid gap-2 mt-4">
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save me-1"></i> Guardar Rutina
                        </button>
                        <a href="<%= esEntrenador ? "SeccionEntrenador.jsp" : "InicioUsuario.jsp" %>" 
                           class="btn btn-outline-secondary">
                            Cancelar
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script>
        function buscarEjercicios() {
            const query = document.getElementById('exerciseSearch').value.toLowerCase();
            const checkboxes = document.querySelectorAll('.exercise-checkbox');
            
            checkboxes.forEach(checkbox => {
                const label = document.querySelector(`label[for="${checkbox.id}"]`).textContent.toLowerCase();
                const item = checkbox.closest('.form-check');
                
                if (label.includes(query)) {
                    item.style.display = 'block';
                } else {
                    item.style.display = 'none';
                }
            });
        }
        
        function updateSelectedExercises() {
            const selectedContainer = document.getElementById('selectedExercises');
            const checkboxes = document.querySelectorAll('.exercise-checkbox:checked');
            
            if (checkboxes.length === 0) {
                selectedContainer.innerHTML = '<p class="text-muted mb-0"><i class="fas fa-info-circle me-1"></i>No hay ejercicios seleccionados</p>';
                return;
            }
            
            let html = '<h6 class="mb-3"><i class="fas fa-check-circle text-success me-1"></i>Ejercicios seleccionados:</h6>';
            
            checkboxes.forEach(checkbox => {
                const label = document.querySelector(`label[for="${checkbox.id}"]`).textContent;
                html += `
                    <div class="selected-exercise-item">
                        <span>${label}</span>
                        <button type="button" class="btn btn-sm btn-outline-danger" 
                                onclick="document.getElementById('${checkbox.id}').checked = false; updateSelectedExercises();">
                            <i class="fas fa-times"></i>
                        </button>
                    </div>
                `;
            });
            
            selectedContainer.innerHTML = html;
        }
        
        // Inicializar eventos
        document.addEventListener('DOMContentLoaded', function() {
            document.querySelectorAll('.exercise-checkbox').forEach(checkbox => {
                checkbox.addEventListener('change', updateSelectedExercises);
            });
        });
    </script>
</body>
</html>