/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package daos;

import colecciones.Ejercicio;
import colecciones.GrupoMuscular;
import java.util.List;
import org.bson.types.ObjectId;

/**
 *
 * @author Arturo ITSON
 */
public interface IEjercicioDAO {
    
    
    /** Regresa una lista con todos los ejercicios */
    public List<Ejercicio> obtenerTodosLosEjercicios();
    
    /** Agrega un nuevo ejercicio a la base de datos. */
    public Ejercicio agregarEjercicio(Ejercicio ejercicio);

    /** Edita los datos de un ejercicio existente. */
    public Ejercicio editarEjercicio(Ejercicio ejercicio);

    /** Busca un ejercicio por su identificador. */
    public Ejercicio buscarEjercicio(Object id);
    
    /** Busca y elimina un ejercicio de la base de datos. */
    public boolean eliminarEjercicioPorId(ObjectId id);

    /** Busca si existe un ejercicio por su nombre */
    boolean existeEjercicio(String nombreEjercicio);
   
    /** Regresa una lista con todos los ejercicios por grupoMuscular */
    public List<Ejercicio> obtenerTodosLosEjerciciosPorGrupoMuscular(GrupoMuscular grupoMuscular);
    
    /** Regresa una lista con todos los ejercicios por grupoMuscular */
    public List<Ejercicio> obtenerTodosLosEjerciciosPorEquipamiento(String equipamiento);
    
    public List<Ejercicio> buscarPorNombre(String nombre) ;
    
    
}
