/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.proyectofinalaplicacionweb;

import daos.IRutinaDAO;
import daos.RutinaDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import org.bson.types.ObjectId;

@WebServlet("/EliminarRutinaServlet")
public class EliminarRutinaServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("usuario") == null) {
            response.sendRedirect("IniciarSesionJSP.jsp");
            return;
        }

        try {
            String idRutina = request.getParameter("id");
            if (idRutina == null || idRutina.isEmpty()) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID de rutina no proporcionado");
                return;
            }

            IRutinaDAO rutinaDAO = new RutinaDAO();
            boolean eliminado = rutinaDAO.eliminarRutinaPorId(new ObjectId(idRutina));

            if (eliminado) {
                response.sendRedirect("InicioUsuario.jsp?mensaje=Rutina eliminada correctamente");
            } else {
                response.sendRedirect("InicioUsuario.jsp?error=No se pudo eliminar la rutina");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("InicioUsuario.jsp?error=Error al procesar la solicitud");
        }
    }
}
