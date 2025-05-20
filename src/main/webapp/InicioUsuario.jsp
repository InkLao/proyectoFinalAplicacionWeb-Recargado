<%-- 
    Document   : InicioUsuario
    Created on : 12 may 2025, 22:22:31
    Author     : Arturo ITSON
--%>

<%@page import="java.util.HashSet"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.ArrayList"%>
<%@page import="colecciones.Rutina"%>
<%@page import="daos.RutinaDAO"%>
<%@page import="daos.IRutinaDAO"%>
<%@page import="colecciones.GrupoMuscular"%>
<%@page import="colecciones.Ejercicio"%>
<%@page import="daos.EjercicioDAO"%>
<%@page import="java.util.List"%>
<%@page import="daos.IEjercicioDAO"%>
<%@page import="colecciones.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    HttpSession sesion = request.getSession(false);
    Usuario usuario = null;
    
    IEjercicioDAO ejercicioDAO = new EjercicioDAO();
    IRutinaDAO rutinaDAO = new RutinaDAO();
    
    
    String mensaje = request.getParameter("mensaje");
    String error = request.getParameter("error");
    
    
    if (sesion != null) {
        usuario = (Usuario) sesion.getAttribute("usuario");
    }

    String accion = request.getParameter("accion");
    
    
    if ("guardarRutina".equalsIgnoreCase("accion")){
        String nombreRutina = request.getParameter("routineName");
        String nombreUsuario = request.getParameter("nombreUsuario");
        String selected = request.getParameter("selectedExercises");
        

        Set<Ejercicio> ejercicios = new HashSet<>();

        if (selected != null && !selected.isEmpty()) {
            String[] ids = selected.split(",");

            for (String id : ids) {
                Ejercicio ejercicio = ejercicioDAO.buscarEjercicio(id.trim());
                if (ejercicio != null) {
                    ejercicios.add(ejercicio);
                }
            }
        }
        
        Rutina rutina = new Rutina();
        rutina.setNombreRutina(nombreRutina);
        rutina.setNombreUsuario(nombreUsuario);
        rutina.setAsignadaPorEntrenador(false);
        rutina.setNombreEntrenador("none");
        rutina.setEjercicios(ejercicios);

        rutinaDAO.agregarRutina(rutina);
        mensaje = "rutina agregada exitosamente";
    
    }
    
    

    if ("cerrarSesion".equalsIgnoreCase(accion)) {
        // Si el usuario está logueado, invalida la sesión
        if (usuario != null) {
            sesion.invalidate(); // cerrar sesión correctamente
        }
        response.sendRedirect("IniciarSesionJSP.jsp");
        return;
    }

    
%>

<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <title>Dashboard - FitRoutine</title>
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

            .exercise-card {
                background-color: rgba(74, 144, 226, 0.1);
                border-radius: 10px;
                padding: 1rem;
                margin-bottom: 1rem;
                transition: all 0.3s;
                border: none;
                box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            }

            .exercise-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 15px 30px rgba(0,0,0,0.1);
            }

            .exercise-card .card-img-top {
                height: 150px;
                object-fit: cover;
                border-radius: 8px 8px 0 0;
            }

            /* Estilos para el modal de rutinas */
            .routine-modal {
    display: none;
    position: fixed;
    z-index: 1050;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    overflow: hidden;
    background-color: rgba(0, 0, 0, 0.5);
}

.routine-modal-content {
    background-color: #fff;
    margin: 4% auto;
    width: 90%;
    max-width: 600px;
    max-height: 90vh;
    display: flex;
    flex-direction: column;
    border-radius: 8px;
    overflow: hidden;
}

.modal-header-custom {
    padding: 16px;
    background-color: #f8f9fa;
    border-bottom: 1px solid #ddd;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.modal-body-custom {
    padding: 16px;
    overflow-y: auto;
    flex-grow: 1;
}

.modal-footer-custom {
    padding: 16px;
    background-color: #f8f9fa;
    border-top: 1px solid #ddd;
}


            @keyframes modalFadeIn {
                from {opacity: 0; transform: translateY(-20px);}
                to {opacity: 1; transform: translateY(0);}
            }

            .exercise-selection {
                max-height: 300px;
                overflow-y: auto;
                margin: 15px 0;
                border: 1px solid #ddd;
                padding: 10px;
                border-radius: 5px;
                background-color: #f9f9f9;
            }

            .selected-exercises {
                margin: 15px 0;
                padding: 15px;
                background-color: #f8f9fa;
                border-radius: 5px;
                border: 1px dashed #ccc;
            }

            .selected-exercise-item {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 8px 0;
                border-bottom: 1px solid #eee;
            }

            .routine-card {
                transition: all 0.3s;
                margin-bottom: 20px;
                border: none;
                box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            }

            .routine-card:hover {
                transform: translateY(-3px);
                box-shadow: 0 8px 16px rgba(0,0,0,0.15);
            }

            .routine-card .card-header {
                background: linear-gradient(to right, #4a90e2, #6a5acd);
                color: white;
                font-weight: 600;
            }
        </style>
    </head>
    <body>
        <div class="dashboard-container">
            <!-- Mensajes de feedback -->
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

            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2 class="mb-0">¡Bienvenido, <span style="color: var(--primary-color);"><%= usuario.getUsuario()%></span>!</h2>
                <div>
                    <button class="btn btn-primary me-2" onclick="openRoutineModal()">
                        <i class="fas fa-plus me-1"></i> Nueva Rutina
                    </button>
                    <a href="LogoutServlet" class="btn btn-outline-danger">
                        <i class="fas fa-sign-out-alt me-1"></i> Cerrar Sesión
                    </a>
                </div>
            </div>

            <div class="row mb-4">
                <div class="col-md-6">
                    <div class="card h-100">
                        <div class="card-body text-center">
                            <h5 class="card-title"><i class="fas fa-dumbbell text-primary"></i> Ejercicios Disponibles</h5>
                            <p class="card-text"><%= new EjercicioDAO().obtenerTodosLosEjercicios().size() %> ejercicios en total</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="card h-100">
                        <div class="card-body text-center">
                            <h5 class="card-title"><i class="fas fa-list-check text-success"></i> Mis Rutinas</h5>
                            <p class="card-text"><%= new RutinaDAO().obtenerTodosLasRutinasPorCliente(usuario.getUsuario()).size() %> rutinas creadas</p>
                        </div>
                    </div>
                </div>
            </div>

            <h3 class="mb-3"><i class="fas fa-dumbbell"></i> Ejercicios Disponibles</h3>

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

            
            <form method="get" action="InicioUsuario.jsp" class="d-flex mb-4" role="search">
                <input type="text" name="filtroNombre" class="form-control me-2" placeholder="Buscar ejercicio por nombre"
                    value="<%= request.getParameter("filtroNombre") != null ? request.getParameter("filtroNombre") : "" %>">
                <button class="btn btn-outline-primary" type="submit" >Buscar</button>
                <input type="hidden" name="accion" value="buscarEjercicios">
            </form>
            <div class="row">
                <% for (Ejercicio ejercicio : ejercicios) { %>
                <div class="col-md-4 mb-4">
                    <div class="card exercise-card h-100">
                        <% if (ejercicio.getUrlImagenIncial() != null && !ejercicio.getUrlImagenIncial().isEmpty()) {%>
                        <img src="<%= ejercicio.getUrlImagenIncial()%>" class="card-img-top" alt="<%= ejercicio.getNombre()%>">
                        <% } else { %>
                        <div class="card-img-top bg-secondary text-white d-flex align-items-center justify-content-center" style="height: 150px;">
                            <i class="fas fa-dumbbell fa-3x"></i>
                        </div>
                        <% }%>
                        <div class="card-body">
                            <h5 class="card-title"><%= ejercicio.getNombre()%></h5>
                            <p class="card-text"><%= ejercicio.getDescripcion()%></p>
                            <div class="d-flex flex-wrap gap-1 mb-2">
                                <% for (GrupoMuscular grupo : ejercicio.getGruposMusculares()) {%>
                                <span class="badge bg-primary"><%= grupo%></span>
                                <% }%>
                            </div>
                            <small class="text-muted">
                                <i class="fas fa-dumbbell"></i> <%= ejercicio.getEquipamiento() != null ? ejercicio.getEquipamiento() : "Ninguno"%><br>
                                <i class="fas fa-repeat"></i> <%= ejercicio.getSeries()%>x<%= ejercicio.getRepeticiones()%> rep<br>
                                <i class="fas fa-clock"></i> <%= ejercicio.getTiempoDescanso()%>s descanso
                            </small>
                        </div>
                    </div>
                </div>
                <% }%>
            </div>

            <h3 class="mb-3 mt-5"><i class="fas fa-list-check"></i> Mis Rutinas</h3>

            <%
                List<Rutina> rutinas = rutinaDAO.obtenerTodosLasRutinasPorCliente(usuario.getUsuario());
            %>

            <% if (rutinas.isEmpty()) { %>
            <div class="alert alert-info">
                <i class="fas fa-info-circle me-2"></i>No has creado ninguna rutina aún. ¡Crea tu primera rutina!
            </div>
            <% } else { %>
            <div class="row">
                <% for (Rutina rutina : rutinas) {%>
                <div class="col-md-6 mb-4">
                    <div class="card routine-card h-100">
                        <div class="card-header">
                            <div class="d-flex justify-content-between align-items-center">
                                <h5 class="card-title mb-0"><%= rutina.getNombreRutina()%></h5>
                                <span class="badge <%= rutina.isAsignadaPorEntrenador() ? "bg-success" : "bg-primary"%>">
                                    <%= rutina.isAsignadaPorEntrenador() ? "Entrenador" : "Personalizada"%>
                                </span>
                            </div>
                        </div>
                        <div class="card-body">
                            <h6 class="card-subtitle mb-3"><i class="fas fa-dumbbell me-2"></i>Ejercicios:</h6>
                            <ul class="list-group list-group-flush mb-3">
                                <% for (Ejercicio ejercicio : rutina.getEjercicios()) {%>
                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                    <div>
                                        <strong><%= ejercicio.getNombre()%></strong><br>
                                        <small class="text-muted">
                                            <%= ejercicio.getSeries()%>x<%= ejercicio.getRepeticiones()%> rep • 
                                            <%= ejercicio.getTiempoDescanso()%>s descanso
                                        </small>
                                    </div>
                                    <div>
                                        <% for (GrupoMuscular grupo : ejercicio.getGruposMusculares()) {%>
                                        <span class="badge bg-primary me-1"><%= grupo%></span>
                                        <% }%>
                                    </div>
                                </li>
                                <% } %>
                            </ul>
                        </div>
                        <div class="card-footer text-end">
                            <button class="btn btn-sm btn-outline-danger" onclick="eliminarRutina('<%= rutina.getId().toString() %>')">
                                <i class="fas fa-trash me-1"></i>Eliminar
                            </button>
                        </div>
                    </div>
                </div>
                <% } %>
            </div>
            <% }%>
        </div>

<!-- Modal para crear rutinas -->
<div id="routineModal" class="routine-modal">
    <div class="routine-modal-content d-flex flex-column">
        
        <!-- Encabezado -->
        <div class="modal-header-custom">
            <h3 class="mb-0"><i class="fas fa-plus-circle me-2"></i>Crear Nueva Rutina</h3>
            <span class="close" onclick="closeRoutineModal()">&times;</span>
        </div>

        <!-- Cuerpo scrollable -->
        <div class="modal-body-custom">
            <form id="routineForm" action="CrearRutinaServlet" method="POST">
                <input type="hidden" name="accion" value="guardarRutina">

                <div class="mb-3">
                    <label for="routineName" class="form-label">Nombre de la Rutina</label>
                    <input type="text" class="form-control" id="routineName" name="routineName" required
                           placeholder="Ej: Rutina de pecho y tríceps">
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
                        <% for (Ejercicio ejercicio : ejercicios) { %>
                        <div class="form-check mb-2">
                            <input class="form-check-input exercise-checkbox" type="checkbox"
                                   value="<%= ejercicio.getId().toString() %>"
                                   id="ex-<%= ejercicio.getId().toString() %>"
                                   data-name="<%= ejercicio.getNombre() %>"
                                   onchange="updateSelectedExercises()">
                            <label class="form-check-label" for="ex-<%= ejercicio.getId().toString() %>">
                                <strong><%= ejercicio.getNombre() %></strong> -
                                <% for (GrupoMuscular grupo : ejercicio.getGruposMusculares()) { %>
                                <span class="badge bg-primary me-1"><%= grupo %></span>
                                <% } %>
                            </label>
                        </div>
                        <% } %>
                    </div>
                </div>

                <div class="selected-exercises" id="selectedExercises">
                    <p class="text-muted mb-0"><i class="fas fa-info-circle me-1"></i>No hay ejercicios seleccionados</p>
                </div>

                <input type="hidden" id="selectedExercisesInput" name="selectedExercises">
            </form>
        </div>

        <!-- Botones fijos -->
        <div class="modal-footer-custom d-grid gap-2">
            <button type="submit" class="btn btn-primary" form="routineForm">
                <i class="fas fa-save me-1"></i> Guardar Rutina
            </button>
            <button type="button" class="btn btn-outline-secondary" onclick="closeRoutineModal()">
                Cancelar
            </button>
        </div>

    </div>
</div>


<script>
function openRoutineModal() {
    document.getElementById('routineModal').style.display = 'block';
    document.getElementById('routineName').focus();
}

function closeRoutineModal() {
    document.getElementById('routineModal').style.display = 'none';
}

function updateSelectedExercises() {
    const selectedContainer = document.getElementById('selectedExercises');
    const checkboxes = document.querySelectorAll('.exercise-checkbox:checked');
    const selectedIds = [];
    let html = "";

    if (checkboxes.length === 0) {
        selectedContainer.innerHTML = `<p class="text-muted mb-0"><i class="fas fa-info-circle me-1"></i>No hay ejercicios seleccionados</p>`;
        document.getElementById('selectedExercisesInput').value = "";
        return;
    }

    html += `<h6>Ejercicios seleccionados:</h6>`;

checkboxes.forEach(cb => {
    const nombreEjercicio = cb.dataset.name || "Ejercicio";
    const checkboxId = cb.id;

    console.log("Ejercicio:", nombreEjercicio, "Checkbox ID:", checkboxId);


    html += 
  '<div style="background: #fff; border: 1px solid #ddd; border-radius: 6px; padding: 8px 12px; margin-bottom: 6px; display: flex; justify-content: space-between; align-items: center;">' +
    '<div style="display: flex; align-items: center; color: #333; font-weight: 500;">' +
      '<i class="fas fa-dumbbell text-primary me-2" style="margin-right: 8px;"></i>' +
      nombreEjercicio +
    '</div>' +
    '<button type="button" class="btn btn-sm btn-outline-danger" ' +
            'onclick="document.getElementById(\'' + checkboxId + '\').checked = false; updateSelectedExercises();">' +
        '<i class="fas fa-times"></i>' +
    '</button>' +
  '</div>';

    selectedIds.push(cb.value);
});



    console.log('HTML generado:', html);

    selectedContainer.innerHTML = html;
    document.getElementById('selectedExercisesInput').value = selectedIds.join(',');
}


function buscarEjercicios() {
    const query = document.getElementById('exerciseSearch').value.toLowerCase();
    const items = document.querySelectorAll('#exerciseSelection .form-check');

    items.forEach(item => {
        const checkbox = item.querySelector('.exercise-checkbox');
        const label = item.querySelector('label');

        if (!checkbox || !label) return;

        const nombre = (checkbox.dataset.name || "").toLowerCase();
        const textoLabel = label.textContent.toLowerCase();

        const coincide = nombre.includes(query) || textoLabel.includes(query);

        item.style.display = coincide ? 'block' : 'none';
    });
}


function eliminarRutina(idRutina) {
    if (confirm('¿Estás seguro de que deseas eliminar esta rutina? Esta acción no se puede deshacer.')) {
        fetch('EliminarRutinaServlet?id=' + idRutina, {
            method: 'POST'
        }).then(response => {
            if (response.ok) {
                location.reload();
            } else {
                alert('Error al eliminar la rutina');
            }
        }).catch(error => {
            console.error('Error:', error);
            alert('Error al eliminar la rutina');
        });
    }
}

document.addEventListener('DOMContentLoaded', function() {
    document.querySelectorAll('.exercise-checkbox').forEach(cb => {
        cb.addEventListener('change', updateSelectedExercises);
    });

    document.getElementById('routineForm').addEventListener('submit', function(e) {
        const checkboxes = document.querySelectorAll('.exercise-checkbox:checked');
        if (checkboxes.length === 0) {
            e.preventDefault();
            alert('Por favor selecciona al menos un ejercicio');
            return false;
        }
        return true;
    });

    window.onclick = function(event) {
        const modal = document.getElementById('routineModal');
        if (event.target === modal) {
            closeRoutineModal();
        }
    }
});
</script>
</html>