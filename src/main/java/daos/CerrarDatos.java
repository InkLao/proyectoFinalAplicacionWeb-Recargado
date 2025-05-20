/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package daos;

import conexionBD.ConexionBD;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

/**
 *
 * @author Arturo ITSON
 */

@WebListener
public class CerrarDatos implements ServletContextListener{
    
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        // Puedes iniciar recursos aquí si lo deseas
        System.out.println("Aplicación iniciada.");
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        ConexionBD.getInstancia().cerrarConexion();
        System.out.println("MongoDB connection closed on app shutdown.");
    }

    
}
