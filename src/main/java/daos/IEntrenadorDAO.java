package daos;

import colecciones.Entrenador;
import java.util.List;
import org.bson.types.ObjectId;

/**
 * 
 * @author eduar
 */
public interface IEntrenadorDAO {
    Entrenador agregarEntrenador(Entrenador entrenador);
    Entrenador editarEntrenador(Entrenador entrenador);
    boolean eliminarEntrenador(ObjectId id);
    Entrenador buscarEntrenador(ObjectId id);
    Entrenador buscarEntrenadorPorUsuario(String usuario);
    boolean existeEntrenador(String usuario);
    List<Entrenador> obtenerTodosLosEntrenadores();
}