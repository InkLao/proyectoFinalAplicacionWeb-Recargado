/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package daos;

import colecciones.Rutina;
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
public class RutinaDAO implements IRutinaDAO{

    
    /** Base de datos de MongoDB. */
    MongoDatabase baseDeDatos;

    /** Colección de usuarios en la base de datos. */
    MongoCollection<Rutina> collectionRutina;
    
    
    /**
     * Constructor que inicializa la conexión con la base de datos y la colección "rutinas".
     */
    public RutinaDAO() {
        this.baseDeDatos = ConexionBD.getInstancia().getDatabase();
        this.collectionRutina = baseDeDatos.getCollection("rutinas", Rutina.class);
    }
    
    
    @Override
    public List<Rutina> obtenerTodosLasRutinas() {
        return collectionRutina.find().into(new ArrayList<>());
    }
    

    @Override
    public List<Rutina> obtenerTodosLasRutinasPorCliente(String usuarioCliente) {

        Bson filtro = Filters.eq("nombreUsuario", usuarioCliente);
        
        return collectionRutina.find(filtro).into(new ArrayList<>());

    }
    

    @Override
    public List<Rutina> obtenerTodosLasRutinasPorEntrenador(String usuarioEntrenador) {

        Bson filtro = Filters.eq("nombreEntrenador", usuarioEntrenador);
        
        return collectionRutina.find(filtro).into(new ArrayList<>());

    }

    @Override
    public Rutina agregarRutina(Rutina rutina) {
        
        try {
            System.out.println("Guardando rutina: " + rutina);
            collectionRutina.insertOne(rutina);
            return rutina;
        } catch (Exception e) {
            System.err.println("Error al guardar rutina: " + e.getMessage());
            throw new RuntimeException("Error al guardar rutina.", e);
        }
    }

    @Override
    public Rutina editarRutina(Rutina rutina) {
        Document query = new Document("_id", new ObjectId(rutina.getId().toString()));

        collectionRutina.updateOne(
                Filters.eq("_id", new ObjectId(rutina.getId().toString())),
                Updates.combine(
                        Updates.set("nombreRutina", rutina.getNombreRutina()),
                        Updates.set("asignadaPorEntrendaor", rutina.isAsignadaPorEntrenador()),
                        Updates.set("ejercicios", rutina.getEjercicios()),
                        Updates.set("nombreUsuario", rutina.getNombreUsuario()),
                        Updates.set("nombreEntrenador", rutina.getNombreEntrenador())

                )
        );
        return rutina;
    }


    @Override
    public Rutina buscarRutina(ObjectId id) {
        
        try {
            ObjectId objectId = new ObjectId(id.toString());
            return collectionRutina.find(Filters.eq("_id", objectId)).first();
        } catch (IllegalArgumentException ex) {
            System.err.println("El ID proporcionado no es válido: " + id);
            return null;
        }
    }
    

    @Override
    public boolean eliminarRutinaPorId(ObjectId id) {
        Bson filtro = Filters.eq("_id", id);

        DeleteResult resultado = collectionRutina.deleteOne(filtro);

        return resultado.getDeletedCount() > 0;

    }
    
    
    
}
