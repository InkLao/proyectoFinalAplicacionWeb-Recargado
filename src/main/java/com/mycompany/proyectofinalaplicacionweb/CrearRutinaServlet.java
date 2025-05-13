/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.proyectofinalaplicacionweb;

import colecciones.Ejercicio;
import colecciones.Rutina;
import colecciones.Usuario;
import daos.EjercicioDAO;
import daos.IEjercicioDAO;
import daos.IRutinaDAO;
import daos.RutinaDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashSet;
import java.util.Set;
import org.bson.types.ObjectId;

@WebServlet("/CrearRutinaServlet")
public class CrearRutinaServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("usuario") == null) {
            response.sendRedirect("IniciarSesionJSP.jsp");
            return;
        }

        try {
            // Obtener usuario de la sesión
            Usuario usuario = (Usuario) session.getAttribute("usuario");
            
            // Obtener parámetros del formulario
            String nombreRutina = request.getParameter("routineName");
            String[] ejerciciosIds = request.getParameter("selectedExercises").split(",");
            
            // Validaciones básicas
            if (nombreRutina == null || nombreRutina.trim().isEmpty()) {
                response.sendRedirect("InicioUsuario.jsp?error=El nombre de la rutina es requerido");
                return;
            }
            
            if (ejerciciosIds == null || ejerciciosIds.length == 0 || 
                (ejerciciosIds.length == 1 && ejerciciosIds[0].isEmpty())) {
                response.sendRedirect("InicioUsuario.jsp?error=Debes seleccionar al menos un ejercicio");
                return;
            }
            
            // Obtener los ejercicios seleccionados
            IEjercicioDAO ejercicioDAO = new EjercicioDAO();
            Set<Ejercicio> ejercicios = new HashSet<>();
            
            for (String id : ejerciciosIds) {
                if (!id.isEmpty()) {
                    Ejercicio ejercicio = ejercicioDAO.buscarEjercicio(new ObjectId(id));
                    if (ejercicio != null) {
                        ejercicios.add(ejercicio);
                    }
                }
            }
            
            // Crear y guardar la rutina
            Rutina nuevaRutina = new Rutina();
            nuevaRutina.setNombreRutina(nombreRutina);
            nuevaRutina.setAsignadaPorEntrenador(false);
            nuevaRutina.setEjercicios(ejercicios);
            nuevaRutina.setNombreUsuario(usuario.getUsuario());
            nuevaRutina.setNombreEntrenador(null);
            
            IRutinaDAO rutinaDAO = new RutinaDAO();
            rutinaDAO.agregarRutina(nuevaRutina);
            
            // Redirigir manteniendo la sesión
            response.sendRedirect("InicioUsuario.jsp?mensaje=Rutina creada exitosamente");
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("InicioUsuario.jsp?error=Error al crear la rutina: " + e.getMessage());
        }
    }
}
