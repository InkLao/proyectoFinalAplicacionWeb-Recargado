<%@page import="java.util.Arrays"%>
<%@page import="java.util.HashSet"%>
<%@page import="java.util.Set"%>
<%@page import="daos.IEntrenadorDAO"%>
<%@page import="daos.EntrenadorDAO"%>
<%@page import="java.util.List"%>
<%@page import="daos.IUsuarioDAO"%>
<%@page import="daos.UsuarioDAO"%>
<%@page import="colecciones.Usuario"%>
<%@page import="colecciones.Entrenador"%>
<%@page import="colecciones.Ejercicio"%>
<%@page import="colecciones.GrupoMuscular"%>
<%@page import="daos.IEjercicioDAO"%>
<%@page import="daos.EjercicioDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    IUsuarioDAO usuarioDao = new UsuarioDAO();
    IEntrenadorDAO entrenadorDao = new EntrenadorDAO();
    IEjercicioDAO ejercicioDAO = new EjercicioDAO();

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
    } else if ("insertarEjercicios".equals(accion)) {
        // Lógica para insertar ejercicios masivamente
        try {
            insertarEjerciciosMasivos(ejercicioDAO);
            mensaje = "Ejercicios insertados exitosamente";
        } catch (Exception e) {
            mensaje = "Error al insertar ejercicios: " + e.getMessage();
        }
    }
%>

<%!
    // Método para insertar ejercicios masivamente
    private void insertarEjerciciosMasivos(IEjercicioDAO ejercicioDao) {
        // Ejercicios para pecho
        ejercicioDao.agregarEjercicio(crearEjercicio(
                "Press de banca",
                "Acostado en un banco, baja la barra al pecho y luego empújala hacia arriba",
                new GrupoMuscular[]{GrupoMuscular.PECHO, GrupoMuscular.TRICEPS},
                "Barra y banco",
                "https://static.strengthlevel.com/images/exercises/bench-press/bench-press-800.jpg",
                4, 10, 60
        ));

        ejercicioDao.agregarEjercicio(crearEjercicio(
                "Flexiones",
                "Con el cuerpo recto, baja el pecho al suelo y luego empuja hacia arriba",
                new GrupoMuscular[]{GrupoMuscular.PECHO, GrupoMuscular.TRICEPS},
                null,
                "https://static.strengthlevel.com/images/exercises/push-ups/push-ups-800.jpg",
                3, 15, 45
        ));

        // Ejercicios para espalda
        ejercicioDao.agregarEjercicio(crearEjercicio(
                "Dominadas",
                "Colgado de una barra, eleva tu cuerpo hasta que la barbilla supere la barra",
                new GrupoMuscular[]{GrupoMuscular.ESPALDA, GrupoMuscular.BICEPS},
                "Barra de dominadas",
                "https://www.fisioterapiaconmueve.com/wp-content/uploads/2019/11/dominada.jpg",
                3, 8, 60
        ));

        ejercicioDao.agregarEjercicio(crearEjercicio(
                "Remo con barra",
                "Inclinado hacia adelante, tira de la barra hacia el abdomen",
                new GrupoMuscular[]{GrupoMuscular.ESPALDA, GrupoMuscular.BICEPS},
                "Barra",
                "https://static.strengthlevel.com/images/exercises/bent-over-row/bent-over-row-800.jpg",
                4, 8, 60
        ));

        // Ejercicios para hombro
        ejercicioDao.agregarEjercicio(crearEjercicio(
                "Press militar",
                "Desde una posición sentada o de pie, empuja la barra por encima de la cabeza",
                new GrupoMuscular[]{GrupoMuscular.HOMBRO, GrupoMuscular.TRICEPS},
                "Barra o mancuernas",
                "https://cdn.shopify.com/s/files/1/0269/5551/3900/files/Standing-Barbell-Shoulder-Press_600x600.png?v=1619977694",
                4, 10, 60
        ));

        ejercicioDao.agregarEjercicio(crearEjercicio(
                "Elevaciones laterales",
                "Con mancuernas, eleva los brazos lateralmente hasta la altura de los hombros",
                new GrupoMuscular[]{GrupoMuscular.HOMBRO},
                "Mancuernas",
                "https://www.gladiatorfit.ch/wp-content/uploads/2022/09/elevation-laterale-muscles-epaule.jpg",
                3, 12, 45
        ));

// Ejercicios para antebrazo
        ejercicioDao.agregarEjercicio(crearEjercicio(
                "Curl de muñeca",
                "Con el antebrazo apoyado, flexiona las muñecas hacia arriba con una barra ligera",
                new GrupoMuscular[]{GrupoMuscular.ANTEBRAZO},
                "Barra",
                "https://cdn.shopify.com/s/files/1/0269/5551/3900/files/Seated-Barbell-Wrist-Curl_600x600.png?v=1619978365",
                3, 15, 30
        ));

        ejercicioDao.agregarEjercicio(crearEjercicio(
                "Rotación de muñeca",
                "Gira una mancuerna con la muñeca en ambas direcciones para fortalecer los antebrazos",
                new GrupoMuscular[]{GrupoMuscular.ANTEBRAZO},
                "Mancuerna",
                "https://fitcron.com/wp-content/uploads/2021/03/03991301-Dumbbell-Seated-One-Arm-Rotate_Forearms_720.gif",
                3, 15, 30
        ));

// Ejercicios para cuádriceps
        ejercicioDao.agregarEjercicio(crearEjercicio(
                "Sentadillas",
                "Con la barra sobre los hombros, baja en cuclillas manteniendo la espalda recta",
                new GrupoMuscular[]{GrupoMuscular.CUADRICEPS, GrupoMuscular.GLUTEO},
                "Barra",
                "https://i.blogs.es/93405c/sentadilla/450_1000.webp",
                4, 10, 60
        ));

        ejercicioDao.agregarEjercicio(crearEjercicio(
                "Extensiones de pierna",
                "Sentado en la máquina, extiende las piernas hasta quedar rectas",
                new GrupoMuscular[]{GrupoMuscular.CUADRICEPS},
                "Máquina de extensión de pierna",
                "https://static.strengthlevel.com/images/exercises/leg-extension/leg-extension-800.jpg",
                3, 12, 45
        ));

// Ejercicios para femoral
        ejercicioDao.agregarEjercicio(crearEjercicio(
                "Curl femoral tumbado",
                "Acostado en la máquina, flexiona las rodillas para acercar los talones al glúteo",
                new GrupoMuscular[]{GrupoMuscular.FEMORAL},
                "Máquina de curl femoral",
                "https://static.strengthlevel.com/images/exercises/lying-leg-curl/lying-leg-curl-800.jpg",
                3, 12, 45
        ));

        ejercicioDao.agregarEjercicio(crearEjercicio(
                "Peso muerto rumano",
                "Con piernas casi rectas, baja la barra deslizando por los muslos y vuelve a subir",
                new GrupoMuscular[]{GrupoMuscular.FEMORAL, GrupoMuscular.GLUTEO},
                "Barra",
                "https://static.strengthlevel.com/images/exercises/dumbbell-romanian-deadlift/dumbbell-romanian-deadlift-800.jpg",
                4, 10, 60
        ));

// Ejercicios para glúteo
        ejercicioDao.agregarEjercicio(crearEjercicio(
                "Hip thrust",
                "Con la espalda apoyada, eleva la cadera con una barra sobre la pelvis",
                new GrupoMuscular[]{GrupoMuscular.GLUTEO, GrupoMuscular.FEMORAL},
                "Barra y banco",
                "https://100x100fitness.com/img/cms/Hip-thrust-.jpg",
                4, 12, 60
        ));

        ejercicioDao.agregarEjercicio(crearEjercicio(
                "Patada de glúteo",
                "En máquina o con banda, empuja la pierna hacia atrás en un movimiento controlado",
                new GrupoMuscular[]{GrupoMuscular.GLUTEO},
                "Máquina o banda elástica",
                "http://static.strengthlevel.com/images/exercises/cable-kickback/cable-kickback-800.jpg",
                3, 15, 45
        ));

// Ejercicios para pantorrilla
        ejercicioDao.agregarEjercicio(crearEjercicio(
                "Elevación de talones de pie",
                "De pie, eleva los talones y contrae las pantorrillas",
                new GrupoMuscular[]{GrupoMuscular.PANTORILLA},
                "Peso corporal o barra",
                "https://static.strengthlevel.com/images/exercises/barbell-calf-raise/barbell-calf-raise-800.jpg",
                4, 15, 30
        ));

        ejercicioDao.agregarEjercicio(crearEjercicio(
                "Elevación de talones sentado",
                "Sentado, eleva los talones con resistencia sobre las rodillas",
                new GrupoMuscular[]{GrupoMuscular.PANTORILLA},
                "Máquina de elevación de talones",
                "https://static.strengthlevel.com/images/exercises/seated-calf-raise/seated-calf-raise-800.jpg",
                4, 15, 30
        ));

// Ejercicios para abdomen
        ejercicioDao.agregarEjercicio(crearEjercicio(
                "Crunch abdominal",
                "Acostado, eleva el torso contrayendo el abdomen",
                new GrupoMuscular[]{GrupoMuscular.ABDOMEN},
                "Colchoneta",
                "https://www.shutterstock.com/image-vector/man-doing-crunches-abdominals-exercise-600nw-1842272014.jpg",
                3, 20, 30
        ));

        ejercicioDao.agregarEjercicio(crearEjercicio(
                "Elevación de piernas",
                "Acostado o colgado, eleva las piernas manteniéndolas rectas",
                new GrupoMuscular[]{GrupoMuscular.ABDOMEN},
                "Colchoneta o barra",
                "https://static.strengthlevel.com/images/exercises/lying-leg-raise/lying-leg-raise-800.jpg",
                3, 15, 45
        ));

// Ejercicios para todo el cuerpo
        ejercicioDao.agregarEjercicio(crearEjercicio(
                "Burpees",
                "Desde de pie, baja a una flexión y luego salta verticalmente",
                new GrupoMuscular[]{GrupoMuscular.TODO_EL_CUERPO},
                null,
                "https://holidaygym.es/wp-content/uploads/2020/04/burpees-948x1024.jpg",
                3, 12, 60
        ));

        ejercicioDao.agregarEjercicio(crearEjercicio(
                "Clean and press",
                "Lleva la barra desde el suelo hasta los hombros y luego sobre la cabeza",
                new GrupoMuscular[]{GrupoMuscular.TODO_EL_CUERPO},
                "Barra",
                "https://static.strengthlevel.com/images/exercises/clean-and-press/clean-and-press-800.jpg",
                4, 8, 90
        ));

    }

    private Ejercicio crearEjercicio(String nombre, String descripcion, GrupoMuscular[] grupos,
            String equipamiento, String urlImagen,
            int series, int repeticiones, int descanso) {
        Ejercicio ejercicio = new Ejercicio();
        ejercicio.setNombre(nombre);
        ejercicio.setDescripcion(descripcion);

        Set<GrupoMuscular> gruposSet = new HashSet<>(Arrays.asList(grupos));
        ejercicio.setGruposMusculares(gruposSet);

        ejercicio.setEquipamiento(equipamiento);
        ejercicio.setUrlImagenIncial(urlImagen);
        ejercicio.setSeries(series);
        ejercicio.setRepeticiones(repeticiones);
        ejercicio.setTiempoDescanso(descanso);

        return ejercicio;
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

            <% if (mensaje != null) {%>
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <%= mensaje%>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <% }%>

            <div class="row mb-4">
                <div class="col-md-4">
                    <div class="user-count">
                        <h3><%= usuarioDao.obtenerTodosLosUsuario().size()%></h3>
                        <p class="mb-0">Usuarios registrados</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="user-count">
                        <h3><%= entrenadorDao.obtenerTodosLosEntrenadores().size()%></h3>
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
                <li class="nav-item" role="presentation">
                    <button class="nav-link" id="acciones-tab" data-bs-toggle="tab" 
                            data-bs-target="#acciones" type="button" role="tab" 
                            aria-controls="acciones" aria-selected="false">
                        <i class="fas fa-cog"></i> Acciones
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
                                    <% for (Usuario usuario : usuarioDao.obtenerTodosLosUsuario()) {%>
                                    <tr>
                                        <td><%= usuario.getId()%></td>
                                        <td><%= usuario.getNombre()%></td>
                                        <td><%= usuario.getUsuario()%></td>
                                        <td><%= usuario.getContrasena()%></td>
                                        <td>
                                            <form action="SeccionAdmin.jsp" method="post">
                                                <input type="hidden" name="accion" value="eliminar">
                                                <input type="hidden" name="id" value="<%= usuario.getId()%>">
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
                                    <% for (Entrenador entrenador : entrenadorDao.obtenerTodosLosEntrenadores()) {%>
                                    <tr>
                                        <td><%= entrenador.getId()%></td>
                                        <td><%= entrenador.getNombre()%></td>
                                        <td><%= entrenador.getUsuario()%></td>
                                        <td><%= entrenador.getContrasena()%></td>
                                        <td>
                                            <form action="SeccionAdmin.jsp" method="post">
                                                <input type="hidden" name="accion" value="eliminarEntrenador">
                                                <input type="hidden" name="id" value="<%= entrenador.getId()%>">
                                                <button type="submit" class="btn btn-danger">Eliminar</button>
                                            </form>
                                        </td>
                                    </tr>
                                    <% }%>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

                <div class="tab-pane fade" id="acciones" role="tabpanel" aria-labelledby="acciones-tab">
                    <div class="row">
                        <div class="col-md-4 mb-3">
                            <a href="AgregarEjercicio.jsp" class="btn btn-success w-100">
                                <i class="fas fa-plus"></i> Agregar ejercicio
                            </a>
                        </div>
                        <div class="col-md-4 mb-3">
                            <a href="CrearRutina.jsp" class="btn btn-primary w-100">
                                <i class="fas fa-plus"></i> Crear nueva rutina
                            </a>
                        </div>
                        <div class="col-md-4 mb-3">
                            <form action="SeccionAdmin.jsp" method="post">
                                <input type="hidden" name="accion" value="insertarEjercicios">
                                <button type="submit" class="btn btn-info w-100">
                                    <i class="fas fa-dumbbell"></i> Insertar Ejercicios
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>