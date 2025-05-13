<%-- 
    Document   : VerRutina
    Created on : 13 may 2025, 3:33:06?p.m.
    Author     : eduar
--%>

<%@page import="colecciones.Ejercicio"%>
<%@page import="colecciones.GrupoMuscular"%>
<%@page import="daos.IRutinaDAO"%>
<%@page import="daos.RutinaDAO"%>
<%@page import="org.bson.types.ObjectId"%>
<%@page import="colecciones.Rutina"%>
<%@page import="colecciones.Usuario"%>

<%
    // Verificar sesión
    Usuario usuario = (Usuario) session.getAttribute("usuario");
    if (usuario == null) {
        response.sendRedirect("IniciarSesionJSP.jsp");
        return;
    }

    // Obtener rutina
    String idRutina = request.getParameter("id");
    IRutinaDAO rutinaDAO = new RutinaDAO();
    Rutina rutina = rutinaDAO.buscarRutina(new ObjectId(idRutina));

    // Verificar pertenencia
    if (rutina == null || !rutina.getNombreUsuario().equals(usuario.getUsuario())) {
        response.sendRedirect("InicioUsuario.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <title><%= rutina.getNombreRutina()%> - FitRoutine</title>
        <!-- Bootstrap y estilos -->
    </head>
    <body>
        <div class="container py-4">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h1><i class="fas fa-dumbbell"></i> <%= rutina.getNombreRutina()%></h1>
                <a href="InicioUsuario.jsp" class="btn btn-outline-secondary">
                    <i class="fas fa-arrow-left"></i> Volver
                </a>
            </div>

            <div class="list-group">
                <% for (Ejercicio ejercicio : rutina.getEjercicios()) {%>
                <div class="list-group-item mb-3">
                    <div class="d-flex w-100 justify-content-between">
                        <h5 class="mb-1"><%= ejercicio.getNombre()%></h5>
                        <small><%= ejercicio.getSeries()%>x<%= ejercicio.getRepeticiones()%></small>
                    </div>
                    <p class="mb-1"><%= ejercicio.getDescripcion()%></p>
                    <div class="d-flex flex-wrap gap-1 mt-2">
                        <% for (GrupoMuscular grupo : ejercicio.getGruposMusculares()) {%>
                        <span class="badge bg-primary"><%= grupo%></span>
                        <% }%>
                        <span class="badge bg-secondary"><%= ejercicio.getEquipamiento()%></span>
                    </div>
                </div>
                <% }%>
            </div>
        </div>
    </body>
</html>
