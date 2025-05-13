<%-- 
    Document   : InicioUsuario
    Created on : 12 may 2025, 22:22:31
    Author     : Arturo ITSON
--%>


<%@page import="colecciones.GrupoMuscular"%>
<%@page import="colecciones.Ejercicio"%>
<%@page import="daos.EjercicioDAO"%>
<%@page import="java.util.List"%>
<%@page import="daos.IEjercicioDAO"%>
<%@page import="colecciones.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    Usuario usuario = (Usuario) request.getAttribute("usuario");

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

            .search-bar {
                display: flex;
                gap: 1rem;
                flex-wrap: wrap;
            }

            .search-bar input {
                flex: 1;
                border-radius: 8px;
                padding: 12px 15px;
                border: 1px solid #ccc;
            }

            .search-bar button {
                background: var(--primary-color);
                color: white;
                border: none;
                padding: 12px 20px;
                border-radius: 8px;
                transition: background 0.3s;
            }

            .search-bar button:hover {
                background: var(--secondary-color);
            }

            .results-section {
                margin-top: 2rem;
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
            }

            .exercise-card h5 {
                color: var(--dark-color);
            }

            .sidebar {
                background-color: rgba(255, 255, 255, 0.8);
                border-left: 4px solid var(--primary-color);
                border-radius: 10px;
                padding: 1rem;
                margin-top: 2rem;
            }

            .sidebar h4 {
                font-weight: bold;
                color: var(--dark-color);
            }

            .routine-item {
                padding: 0.5rem 0;
                border-bottom: 1px solid #e1e1e1;
            }

            @media (min-width: 768px) {
                .dashboard-layout {
                    display: grid;
                    grid-template-columns: 3fr 1fr;
                    gap: 2rem;
                }
            }
        </style>
    </head>
    <body>
        <div class="dashboard-container">
            <h2 class="text-center mb-4">¡Bienvenido, <span style="color: var(--primary-color);"><%= usuario.getUsuario()%></span>!</h2>

            <div class="dashboard-layout">
                <!-- Main content -->
                <div>
                    <div class="search-bar mb-3">
                        <input type="text" id="busqueda" placeholder="Buscar ejercicios...">
                        <button onclick="buscarEjercicios()">Buscar</button>
                    </div>

                    <div class="results-section" id="resultados">
                        <!-- Aquí se mostrarán los ejercicios encontrados -->
                        <div class="exercise-card">
                            <h5>Flexiones</h5>
                            <p>Ejercicio de fuerza para pecho y brazos. Ideal para principiantes y avanzados.</p>
                        </div>
                        <div class="exercise-card">
                            <h5>Sentadillas</h5>
                            <p>Trabaja glúteos y piernas. Puedes hacerlas con o sin peso adicional.</p>
                        </div>
                    </div>
                </div>

                <!-- Sidebar -->
                <div class="sidebar">
                    <h4>Rutinas Completadas</h4>
                    <div class="routine-item">Rutina Pecho - 10/05/2025</div>
                    <div class="routine-item">Rutina Piernas - 09/05/2025</div>
                    <div class="routine-item">Rutina Cardio - 08/05/2025</div>
                </div>
            </div>

            <%-- Agrega esta sección después de la sección de rutinas --%>

            <h3 class="mb-3 mt-5"><i class="fas fa-dumbbell"></i> Ejercicios Disponibles</h3>

            <%
                IEjercicioDAO ejercicioDAO = new EjercicioDAO();
                List<Ejercicio> ejercicios = ejercicioDAO.obtenerTodosLosEjercicios();
            %>

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
                                <span class="badge bg-primary"><%= grupo.name()%></span>
                                <% }%>
                            </div>
                            <small class="text-muted">
                                Equipo: <%= ejercicio.getEquipamiento() != null ? ejercicio.getEquipamiento() : "Ninguno"%> | 
                                <%= ejercicio.getSeries()%>x<%= ejercicio.getRepeticiones()%> rep
                            </small>
                        </div>
                    </div>
                </div>
                <% }%>
            </div>
        </div>

        <script>
            function buscarEjercicios() {
                const query = document.getElementById('busqueda').value.toLowerCase();
                const contenedor = document.getElementById('resultados');
                contenedor.innerHTML = '';

                // Este ejemplo simula resultados estáticos. Puedes reemplazar por una llamada AJAX.
                const ejercicios = [
                    {nombre: 'Flexiones', desc: 'Ejercicio de fuerza para pecho y brazos.'},
                    {nombre: 'Sentadillas', desc: 'Trabaja glúteos y piernas.'},
                    {nombre: 'Abdominales', desc: 'Fortalece la zona media del cuerpo.'},
                    {nombre: 'Plancha', desc: 'Ejercicio isométrico para core.'},
                ];

                const filtrados = ejercicios.filter(e => e.nombre.toLowerCase().includes(query));

                if (filtrados.length === 0) {
                    contenedor.innerHTML = '<p class="text-muted">No se encontraron ejercicios.</p>';
                    return;
                }

                filtrados.forEach(e => {
                    const card = document.createElement('div');
                    card.className = 'exercise-card';
                    card.innerHTML = `<h5>${e.nombre}</h5><p>${e.desc}</p>`;
                    contenedor.appendChild(card);
                });
            }
        </script>
    </body>
</html>
