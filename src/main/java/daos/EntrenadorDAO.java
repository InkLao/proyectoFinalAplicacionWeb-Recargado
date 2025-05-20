package daos;

import colecciones.Entrenador;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Filters;
import com.mongodb.client.model.Updates;
import com.mongodb.client.result.DeleteResult;
import conexionBD.ConexionBD;
import java.util.ArrayList;
import java.util.List;
import org.bson.conversions.Bson;
import org.bson.types.ObjectId;

/**
 * 
 * @author eduar
 */
public class EntrenadorDAO implements IEntrenadorDAO {
    
    private final MongoDatabase baseDeDatos;
    private final MongoCollection<Entrenador> collectionEntrenador;
    
    public EntrenadorDAO() {
        this.baseDeDatos = ConexionBD.getInstancia().getDatabase();
        this.collectionEntrenador = baseDeDatos.getCollection("entrenadores", Entrenador.class);
    }

    @Override
    public Entrenador agregarEntrenador(Entrenador entrenador) {
        try {
            collectionEntrenador.insertOne(entrenador);
            return entrenador;
        } catch (Exception e) {
            System.err.println("Error al guardar entrenador: " + e.getMessage());
            throw new RuntimeException("Error al guardar entrenador.", e);
        }
    }

    @Override
    public Entrenador editarEntrenador(Entrenador entrenador) {
        collectionEntrenador.updateOne(
                Filters.eq("_id", entrenador.getId()),
                Updates.combine(
                        Updates.set("nombre", entrenador.getNombre()),
                        Updates.set("usuario", entrenador.getUsuario()),
                        Updates.set("contrasena", entrenador.getContrasena())
                )
        );
        return entrenador;
    }

    @Override
    public boolean eliminarEntrenador(ObjectId id) {
        Bson filtro = Filters.eq("_id", id);
        DeleteResult resultado = collectionEntrenador.deleteOne(filtro);
        return resultado.getDeletedCount() > 0;
    }

    @Override
    public Entrenador buscarEntrenador(ObjectId id) {
        return collectionEntrenador.find(Filters.eq("_id", id)).first();
    }

    @Override
    public Entrenador buscarEntrenadorPorUsuario(String usuario) {
        return collectionEntrenador.find(Filters.eq("usuario", usuario)).first();
    }

    @Override
    public boolean existeEntrenador(String usuario) {
        return collectionEntrenador.countDocuments(Filters.eq("usuario", usuario)) > 0;
    }

    @Override
    public List<Entrenador> obtenerTodosLosEntrenadores() {
        return collectionEntrenador.find().into(new ArrayList<>());
    }
}