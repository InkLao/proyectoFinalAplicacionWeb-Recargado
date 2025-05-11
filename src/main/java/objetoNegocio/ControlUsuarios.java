/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package objetoNegocio;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Arturo ITSON
 */
public class ControlUsuarios {
    
    private static List<Usuario> usuarios = new ArrayList<>();
    
    static{
        usuarios.add(new Usuario(1, "Arturo", "admin", "admin"));
    }
    
    
    public static List<Usuario> obtenerLista(){
        return usuarios;
    }
    
    
    public static void agregarUsuario(Usuario usuario){
        usuarios.add(usuario);
    }
    
    public static void eliminarUsuario(int id){
        for (Usuario usuario : usuarios) {
            if(usuario.getId() == id){
                usuarios.remove(usuario);
                break;
            }
        }
    }
    
    
    public static boolean estaNombreUsuarioEnUso(String nombreUsuario){
        for (Usuario usuario : usuarios) {
            if(usuario.getUsuario().equals(nombreUsuario)){
                
                return true;
            }
        }
        
        return false;
        
        
    }  
        
        
}

   
