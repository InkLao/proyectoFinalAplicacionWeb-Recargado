<%-- 
    Document   : AgregarEjercicio
    Created on : 13 may 2025, 12:10:23
    Author     : Arturo ITSON
--%>

<%@page import="colecciones.GrupoMuscular"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashSet"%>
<%@page import="java.util.Set"%>
<%@page import="colecciones.Ejercicio"%>
<%@page import="daos.EjercicioDAO"%>
<%@page import="daos.IEjercicioDAO"%>
<%@page import="colecciones.Entrenador"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<% 
    // Verificar si es admin o entrenador
    Entrenador entrenador = (Entrenador) session.getAttribute("entrenador");
    boolean esEntrenador = entrenador != null;
    
    if (!esEntrenador && session.getAttribute("admin") == null) {
        response.sendRedirect("IniciarSesionJSP.jsp");
        return;
    }

    IEjercicioDAO ejercicioDAO = new EjercicioDAO();
    String accion = request.getParameter("accion");
    String mensaje = "";

    if ("guardar".equals(accion)) {
        String nombreEjercicio = request.getParameter("nombre");
        String descripcion = request.getParameter("descripcion");
        
        String[] gruposSeleccionados = request.getParameterValues("gruposMusculares");
        Set<GrupoMuscular> gruposMusculares = new HashSet<>();
        
        if (gruposSeleccionados != null) {
            for (String grupo : gruposSeleccionados) {
                GrupoMuscular grupoMuscular = GrupoMuscular.valueOf(grupo);
                gruposMusculares.add(grupoMuscular);
            }
        }
        
        String equipamiento = request.getParameter("equipamiento");
        String url = request.getParameter("urlImagenIncial");
        String series = request.getParameter("series");
        String repeticiones = request.getParameter("repeticiones");
        String tiempoDescanso = request.getParameter("tiempoDescanso");
        
        if (nombreEjercicio != null && !nombreEjercicio.trim().isEmpty() && !ejercicioDAO.existeEjercicio(nombreEjercicio)) {
            Ejercicio ejercicio = new Ejercicio();
            
            ejercicio.setDescripcion(descripcion);
            ejercicio.setEquipamiento(equipamiento);
            ejercicio.setGruposMusculares(gruposMusculares);
            ejercicio.setNombre(nombreEjercicio);
            ejercicio.setRepeticiones(Integer.valueOf(repeticiones));
            ejercicio.setSeries(Integer.valueOf(series));
            ejercicio.setTiempoDescanso(Integer.valueOf(tiempoDescanso));
            ejercicio.setUrlImagenIncial(url);
        
            ejercicioDAO.agregarEjercicio(ejercicio);
            
            // Redirección según el tipo de usuario
            if (esEntrenador) {
                response.sendRedirect("SeccionEntrenador.jsp?mensaje=Ejercicio guardado exitosamente");
            } else {
                response.sendRedirect("SeccionAdmin.jsp?mensaje=Ejercicio guardado exitosamente");
            }
            return;
        } else {
            mensaje = "El nombre de ejercicio ya está en uso o es inválido";
        }
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Agregar Ejercicio - FitRoutine</title>
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
            background: url('https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b') no-repeat center center fixed;
            background-size: cover;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .form-box {
            background-color: rgba(255, 255, 255, 0.95);
            border-radius: 15px;
            padding: 2.5rem;
            width: 100%;
            max-width: 700px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
        }

        .form-header {
            text-align: center;
            margin-bottom: 2rem;
        }

        .form-header h2 {
            color: var(--dark-color);
            font-weight: bold;
        }

        .form-control, .form-select {
            border-radius: 8px;
            padding: 12px 15px;
            margin-bottom: 1rem;
        }

        .btn-submit {
            background: linear-gradient(to right, var(--primary-color), var(--secondary-color));
            border: none;
            color: white;
            font-weight: 600;
            border-radius: 8px;
            padding: 12px;
            width: 100%;
        }

        .btn-submit:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
        }

        .image-preview {
            max-height: 150px;
            object-fit: contain;
            margin-bottom: 1rem;
            border-radius: 10px;
        }
    </style>
</head>
<body>
<div class="form-box">
    <div class="form-header">
        <h2><i class="fas fa-dumbbell"></i> Agregar Ejercicio</h2>
        <p class="text-muted">Completa los datos para añadir un nuevo ejercicio</p>
    </div>
    <form onsubmit="return validarCheckboxes()" action="AgregarEjercicio.jsp" method="post">
        <input type="hidden" name="accion" value="guardar">
        <div class="row">
            <div class="col-md-6">
                <label for="nombre">Nombre</label>
                <input type="text" id="nombre" name="nombre" class="form-control" required>

                <label for="descripcion">Descripción</label>
                <textarea id="descripcion" name="descripcion" class="form-control" rows="3" required></textarea>

                <label for="equipamiento">Equipamiento</label>
                <input type="text" id="equipamiento" name="equipamiento" class="form-control">

                <label for="series">Series</label>
                <input type="number" id="series" name="series" class="form-control" min="1" required>

                <label for="repeticiones">Repeticiones</label>
                <input type="number" id="repeticiones" name="repeticiones" class="form-control" min="1" required>

                <label for="tiempoDescanso">Tiempo de descanso (segundos)</label>
                <input type="number" id="tiempoDescanso" name="tiempoDescanso" class="form-control" min="0" required>
            </div>

            <div class="col-md-6">
                <div class="mb-3">
                    <label class="form-label fw-bold">Grupos Musculares <span class="text-danger">*</span></label>
                    <div class="p-3 border rounded shadow-sm" style="background-color: rgba(74, 144, 226, 0.05);">
                        <div class="form-check" >
                            <input class="form-check-input" type="checkbox" name="gruposMusculares" value="PECHO" id="pecho">
                            <label class="form-check-label" for="pecho">Pecho</label>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" name="gruposMusculares" value="TRICEPS" id="triceps">
                            <label class="form-check-label" for="triceps">Tríceps</label>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" name="gruposMusculares" value="HOMBROS" id="hombros">
                            <label class="form-check-label" for="hombros">Hombros</label>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" name="gruposMusculares" value="ESPALDA" id="espalda">
                            <label class="form-check-label" for="espalda">Espalda</label>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" name="gruposMusculares" value="BICEPS" id="biceps">
                            <label class="form-check-label" for="biceps">Bíceps</label>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" name="gruposMusculares" value="ANTEBRAZO" id="antebrazo">
                            <label class="form-check-label" for="antebrazo">Antebrazo</label>
                        </div>  
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" name="gruposMusculares" value="CUADRICEPS" id="cuadriceps">
                            <label class="form-check-label" for="cuadriceps">Cuadriceps</label>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" name="gruposMusculares" value="FEMORAL" id="femoral">
                            <label class="form-check-label" for="femoral">Femoral</label>
                        </div> 
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" name="gruposMusculares" value="GLUTEO" id="gluteo">
                            <label class="form-check-label" for="gluteo">Gluteo</label>
                        </div> 
                                                <div class="form-check">
                            <input class="form-check-input" type="checkbox" name="gruposMusculares" value="PANTORILLA" id="pantorilla">
                            <label class="form-check-label" for="pantorilla">Pantorilla</label>
                        </div> 
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" name="gruposMusculares" value="Abdominales" id="abdominales">
                            <label class="form-check-label" for="abdominales">Abdominales</label>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" name="gruposMusculares" value="TODO_EL_CUERPO" id="todo_el_cuerpo">
                            <label class="form-check-label" for="todo_el_cuerpo">Todo el cuerpo</label>
                        </div>
                    </div>
                </div>


                <label for="urlImagenIncial">URL Imagen Inicial</label>
                <input type="url" id="urlImagenIncial" name="urlImagenIncial" class="form-control" oninput="previewImage('urlImagenIncial', 'previewInicial')">
                <img id="previewInicial" class="image-preview" src="#" alt="Vista previa inicial" style="display: none;">

            </div>
        </div>

        <button type="submit" class="btn-submit mt-3"><i class="fas fa-save"></i> Guardar Ejercicio</button>
    </form>
</div>

<script>
    function previewImage(inputId, imgId) {
        const url = document.getElementById(inputId).value;
        const img = document.getElementById(imgId);
        if (url.trim() !== "") {
            img.src = url;
            img.style.display = "block";
        } else {
            img.style.display = "none";
        }
    }
    
    
    function validarCheckboxes() {
    const checkboxes = document.querySelectorAll('input[name="gruposMusculares"]:checked');
    if (checkboxes.length === 0) {
        alert("Por favor, selecciona al menos un grupo muscular.");
        return false; // evita que se envíe el formulario
    }
    return true;
}
    
</script>
</body>
</html>

