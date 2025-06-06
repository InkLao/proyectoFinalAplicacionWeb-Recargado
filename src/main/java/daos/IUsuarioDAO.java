/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package daos;

import colecciones.Usuario;
import java.util.List;
import org.bson.types.ObjectId;

/**
 * Interfaz para definir las operaciones de acceso a datos relacionadas con Usuarios.
 * 
 * @author Arturo ITSON
 */
public interface IUsuarioDAO {
    
    /** Regresa una lista con todos los usuarios */
    public List<Usuario> obtenerTodosLosUsuario();
    
    /** Agrega un nuevo usuario a la base de datos. */
    Usuario agregarUsuario(Usuario usuario);

    /** Edita los datos de un usuario existente. */
    Usuario editarUsuario(Usuario usuario);

    /** Busca un usuario por su identificador. */
    Usuario buscarUsuario(ObjectId id);
    
    /** Busca y elimina un usuario de la base de datos. */
    public boolean eliminarUsuarioPorId(ObjectId id);

    /** Busca un usuario por su correo y contraseña. */
    Usuario buscarUsuarioIniciarSesion(String correo, String contra);

    /** Verifica si un correo ya está registrado en la base de datos. */
    boolean existeUsuario(String nombreUsuario);

    /** Busca un usuario por su correo. */
    Usuario buscarUsuarioPorNombreUsuario(String nombreUsuario);
    
}
