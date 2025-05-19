package com.mycompany.proyectofinalaplicacionweb;

import colecciones.Entrenador;
import colecciones.Usuario;
import daos.EntrenadorDAO;
import daos.IEntrenadorDAO;
import daos.IUsuarioDAO;
import daos.UsuarioDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String accion = request.getParameter("accion");
        String nombre = request.getParameter("nombre");
        String password = request.getParameter("password");
        
        if ("Iniciar".equals(accion)) {
            // Verificar si es admin
            if (nombre.equals("admin") && password.equals("admin")) {
                response.sendRedirect("SeccionAdmin.jsp");
                return;
            }
            
            // Verificar si es entrenador
            IEntrenadorDAO entrenadorDAO = new EntrenadorDAO();
            Entrenador entrenador = entrenadorDAO.buscarEntrenadorPorUsuario(nombre);
            if (entrenador != null && entrenador.getContrasena().equals(password)) {
                HttpSession session = request.getSession();
                session.setAttribute("entrenador", entrenador);
                response.sendRedirect("SeccionEntrenador.jsp");
                return;
            }
            
            // Verificar si es usuario normal
            IUsuarioDAO usuarioDAO = new UsuarioDAO();
            if (usuarioDAO.existeUsuario(nombre)) {
                Usuario usuario = usuarioDAO.buscarUsuarioPorNombreUsuario(nombre);
                if (usuario != null && usuario.getContrasena().equals(password)) {
                    HttpSession session = request.getSession();
                    session.setAttribute("usuario", usuario);
                    response.sendRedirect("InicioUsuario.jsp");
                    return;
                } else {
                    response.sendRedirect("IniciarSesionJSP.jsp?mensaje=Credenciales incorrectas");
                    return;
                }
            }
            
            // Si no es ninguno
            response.sendRedirect("IniciarSesionJSP.jsp?mensaje=El usuario no existe");
        }
    }
}