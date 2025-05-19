/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package daos;

import colecciones.Ejercicio;
import colecciones.GrupoMuscular;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Filters;
import com.mongodb.client.model.Updates;
import com.mongodb.client.result.DeleteResult;
import conexionBD.ConexionBD;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Pattern;
import org.bson.Document;
import org.bson.conversions.Bson;
import org.bson.types.ObjectId;

/**
 *
 * @author Arturo ITSON
 */
public class EjercicioDAO implements IEjercicioDAO{
    
    
    /** Base de datos de MongoDB. */
    MongoDatabase baseDeDatos;

    /** Colección de usuarios en la base de datos. */
    MongoCollection<Ejercicio> collectionEjercicio;
    
    
    /**
     * Constructor que inicializa la conexión con la base de datos y la colección "ejercicios".
     */
    public EjercicioDAO() {
        this.baseDeDatos = new ConexionBD().conexion();
        this.collectionEjercicio = baseDeDatos.getCollection("ejercicios", Ejercicio.class);
    }
    
    

    @Override
    public List<Ejercicio> obtenerTodosLosEjercicios() {
        return collectionEjercicio.find().into(new ArrayList<>());
    }
    

    @Override
    public Ejercicio agregarEjercicio(Ejercicio ejercicio) {
        try {
            System.out.println("Guardando ejercicio: " + ejercicio);
            collectionEjercicio.insertOne(ejercicio);
            return ejercicio;
        } catch (Exception e) {
            System.err.println("Error al guardar ejercicio: " + e.getMessage());
            throw new RuntimeException("Error al guardar ejercicio.", e);
        }
    }

    @Override
    public Ejercicio editarEjercicio(Ejercicio ejercicio) {
        Document query = new Document("_id", new ObjectId(ejercicio.getId().toString()));

        collectionEjercicio.updateOne(
                Filters.eq("_id", new ObjectId(ejercicio.getId().toString())),
                Updates.combine(
                        Updates.set("nombre", ejercicio.getNombre()),
                        Updates.set("descripcion", ejercicio.getDescripcion()),
                        Updates.set("grupoMusculares", ejercicio.getGruposMusculares()),
                        Updates.set("equipamiento", ejercicio.getEquipamiento()),
                        Updates.set("urlImagenInicial", ejercicio.getUrlImagenIncial()),
                        Updates.set("urlImagenFinal", ejercicio.getUrlImagenFinal()),
                        Updates.set("series", ejercicio.getSeries()),
                        Updates.set("repeticiones", ejercicio.getRepeticiones()),
                        Updates.set("tiempoDescanso", ejercicio.getTiempoDescanso())
                )
        );
        return ejercicio;
    }
    

    @Override
    public Ejercicio buscarEjercicio(Object id) {
        try {
            ObjectId objectId = new ObjectId(id.toString());
            return collectionEjercicio.find(Filters.eq("_id", objectId)).first();
        } catch (IllegalArgumentException ex) {
            System.err.println("El ID proporcionado no es válido: " + id);
            return null;
        }
    }
    
    
    @Override
    public boolean eliminarEjercicioPorId(ObjectId id) {
        
        Bson filtro = Filters.eq("_id", id);

        DeleteResult resultado = collectionEjercicio.deleteOne(filtro);

        return resultado.getDeletedCount() > 0;
    }
    

    @Override
    public boolean existeEjercicio(String nombreEjercicio) {
        long count = collectionEjercicio.countDocuments(Filters.eq("nombre", nombreEjercicio));
        return count > 0;

    }

    @Override
    public List<Ejercicio> obtenerTodosLosEjerciciosPorGrupoMuscular(GrupoMuscular grupoMuscular) {
        // Crea el filtro para buscar documentos donde el arreglo contenga el grupo muscular
        Bson filtro = Filters.in("gruposMusculares", grupoMuscular.name());

        // Ejecuta la consulta y devuelve la lista
        return collectionEjercicio.find(filtro).into(new ArrayList<>());    
    
    }
    

    @Override
    public List<Ejercicio> obtenerTodosLosEjerciciosPorEquipamiento(String equipamiento) {
        
        Bson filtro = Filters.eq("equipamiento", equipamiento);
        
        return collectionEjercicio.find(filtro).into(new ArrayList<>());
    }
    
    
    @Override
    public List<Ejercicio> buscarPorNombre(String nombre) {
        Bson filtro = Filters.regex("nombre", ".*" + Pattern.quote(nombre) + ".*", "i"); // Insensible a mayúsculas
        return collectionEjercicio.find(filtro).into(new ArrayList<>());
    }
    
}
