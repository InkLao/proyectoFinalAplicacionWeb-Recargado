<%-- 
    Document   : GuardarRutina
    Created on : 19 may 2025, 11:47:11 a.m.
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
<%@page import="colecciones.Entrenador"%>
<%@page import="colecciones.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    // Verificar sesión
    HttpSession sessionObj = request.getSession(false);
    boolean esEntrenador = "true".equals(request.getParameter("esEntrenador"));
    String nombreUsuario = "";
    
    if (esEntrenador) {
        Entrenador entrenador = (Entrenador) sessionObj.getAttribute("entrenador");
        if (entrenador == null) {
            response.sendRedirect("IniciarSesionJSP.jsp");
            return;
        }
        nombreUsuario = entrenador.getUsuario();
    } else {
        Usuario usuario = (Usuario) sessionObj.getAttribute("usuario");
        if (usuario == null) {
            response.sendRedirect("IniciarSesionJSP.jsp");
            return;
        }
        nombreUsuario = usuario.getUsuario();
    }
    
    // 1. Obtener parámetros
    String nombreRutina = request.getParameter("nombreRutina");
    String[] idsEjercicios = request.getParameterValues("ejercicios");
    
    // 2. Validar selección
    if (idsEjercicios == null || idsEjercicios.length == 0) {
        sessionObj.setAttribute("error", "Debes seleccionar al menos un ejercicio");
        response.sendRedirect("CrearRutina.jsp?esEntrenador=" + esEntrenador);
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
    nuevaRutina.setNombreUsuario(nombreUsuario);
    nuevaRutina.setAsignadaPorEntrenador(esEntrenador);
    nuevaRutina.setNombreEntrenador(esEntrenador ? nombreUsuario : null);
    
    IRutinaDAO rutinaDAO = new RutinaDAO();
    rutinaDAO.agregarRutina(nuevaRutina);
    
    // 5. Redirigir con mensaje de éxito
    if (esEntrenador) {
        response.sendRedirect("SeccionEntrenador.jsp?mensaje=Rutina creada exitosamente!");
    } else {
        response.sendRedirect("InicioUsuario.jsp?mensaje=Rutina creada exitosamente!");
    }
%>