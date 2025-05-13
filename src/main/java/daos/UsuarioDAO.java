/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package daos;

import colecciones.Usuario;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Filters;
import com.mongodb.client.model.Updates;
import com.mongodb.client.result.DeleteResult;
import conexionBD.ConexionBD;
import java.util.ArrayList;
import java.util.List;
import org.bson.Document;
import org.bson.conversions.Bson;
import org.bson.types.ObjectId;

/**
 *
 * @author Arturo ITSON
 */
public class UsuarioDAO implements IUsuarioDAO{
    
        
    /** Base de datos de MongoDB. */
    MongoDatabase baseDeDatos;

    /** Colección de usuarios en la base de datos. */
    MongoCollection<Usuario> collectionUsuario;

    /**
     * Constructor que inicializa la conexión con la base de datos y la colección "usuarios".
     */
    public UsuarioDAO() {
        this.baseDeDatos = new ConexionBD().conexion();
        this.collectionUsuario = baseDeDatos.getCollection("usuarios", Usuario.class);
    }
    
    
    
    @Override
    public List<Usuario> obtenerTodosLosUsuario(){
        return collectionUsuario.find().into(new ArrayList<>());
    
    }
    

    /**
     * {@inheritDoc}
     */
    @Override
    public Usuario agregarUsuario(Usuario usuario) {
        try {
            System.out.println("Guardando usuario: " + usuario);
            collectionUsuario.insertOne(usuario);
            return usuario;
        } catch (Exception e) {
            System.err.println("Error al guardar usuario: " + e.getMessage());
            throw new RuntimeException("Error al guardar usuario.", e);
        }
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public Usuario editarUsuario(Usuario usuario) {
        Document query = new Document("_id", new ObjectId(usuario.getId().toString()));

        collectionUsuario.updateOne(
                Filters.eq("_id", new ObjectId(usuario.getId().toString())),
                Updates.combine(
                        Updates.set("nombre", usuario.getNombre()),
                        Updates.set("usuario", usuario.getUsuario()),
                        Updates.set("contrasena", usuario.getContrasena())
                )
        );
        return usuario;
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public Usuario buscarUsuario(Object id) {
        try {
            ObjectId objectId = new ObjectId(id.toString());
            return collectionUsuario.find(Filters.eq("_id", objectId)).first();
        } catch (IllegalArgumentException ex) {
            System.err.println("El ID proporcionado no es válido: " + id);
            return null;
        }
    }
    
    
    
    
    

    /**
     * {@inheritDoc}
     */
    @Override
    public boolean existeUsuario(String nombreUsaurio) {
        long count = collectionUsuario.countDocuments(Filters.eq("correo", nombreUsaurio));
        return count > 0;
    }
    
    
    
    @Override
    public boolean eliminarUsuarioPorId(ObjectId id) {
        
        Bson filtro = Filters.eq("_id", id);

        DeleteResult resultado = collectionUsuario.deleteOne(filtro);

        return resultado.getDeletedCount() > 0;
    }
    
    

    /**
     * {@inheritDoc}
     */
    @Override
    public Usuario buscarUsuarioPorNombreUsuario(String nombreUsuario) {
        Usuario usuario = collectionUsuario.find(Filters.eq("usuario", nombreUsuario)).first();
        if (usuario != null) {
            System.out.println("Usuario encontrado: " + usuario);
        } else {
            System.out.println("No se encontró usuario: " + nombreUsuario);
        }
        return usuario;
    }

    @Override
    public Usuario buscarUsuarioIniciarSesion(String correo, String contra) {
        throw new UnsupportedOperationException("Método obsoleto. Usa buscarUsuarioPorCorreo para obtener el usuario.");
    }
    
}
