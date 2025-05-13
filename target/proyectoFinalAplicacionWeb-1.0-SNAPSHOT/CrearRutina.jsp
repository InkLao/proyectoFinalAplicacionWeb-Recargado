<%-- 
    Document   : CrearRutina
    Created on : 13 may 2025, 3:30:23 p.m.
    Author     : eduar
--%>

<%@page import="daos.IRutinaDAO"%>
<%@page import="daos.RutinaDAO"%>
<%@page import="daos.IEjercicioDAO"%>
<%@page import="daos.EjercicioDAO"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.HashSet"%>
<%@page import="org.bson.types.ObjectId"%>
<%@page import="colecciones.Rutina"%>
<%@page import="colecciones.Ejercicio"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    // 1. Obtener parámetros
    String nombreRutina = request.getParameter("nombreRutina");
    String[] idsEjercicios = request.getParameterValues("ejercicios");
    
    // 2. Validar selección
    if (idsEjercicios == null || idsEjercicios.length == 0) {
        session.setAttribute("error", "Debes seleccionar al menos un ejercicio");
        response.sendRedirect("CrearRutina.jsp");
        return;
    }
    
    // 3. Obtener ejercicios seleccionados
    IEjercicioDAO ejercicioDAO = new EjercicioDAO();
    Set<Ejercicio> ejercicios = new HashSet<>();
    
    for (String id : idsEjercicios) {
        Ejercicio ej = ejercicioDAO.buscarEjercicio(new ObjectId(id));
        if (ej != null) {
            ejercicios.add(ej);
        }
    }
    
    // 4. Crear y guardar rutina
    Rutina nuevaRutina = new Rutina();
    nuevaRutina.setNombreRutina(nombreRutina);
    nuevaRutina.setEjercicios(ejercicios);
    nuevaRutina.setNombreUsuario("cliente"); // Cambiar por usuario real luego
    nuevaRutina.setAsignadaPorEntrenador(false);
    
    IRutinaDAO rutinaDAO = new RutinaDAO();
    rutinaDAO.agregarRutina(nuevaRutina);
    
    // 5. Redirigir con mensaje de éxito
    session.setAttribute("mensaje", "Rutina creada exitosamente!");
    response.sendRedirect("InicioUsuario.jsp");
%>