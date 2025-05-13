/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package daos;

import colecciones.Rutina;
import java.util.List;
import org.bson.types.ObjectId;

/**
 *
 * @author Arturo ITSON
 */
public interface IRutinaDAO {
    
       
    /** Regresa una lista con todos las rutinas */
    public List<Rutina> obtenerTodosLasRutinas();
    
    /** Regresa una lista con todos las rutinas de una persona */
    public List<Rutina> obtenerTodosLasRutinasPorCliente(String usuarioCliente);
    
    /** Regresa una lista con todos las rutinas asignadas por un entrenador */
    public List<Rutina> obtenerTodosLasRutinasPorEntrenador(String usuarioEntrenador);
    
    /** Agrega una nueva rutina a la base de datos. */
    Rutina agregarRutina(Rutina rutina);

    /** Edita los datos de una rutina existente. */
    Rutina editarRutina(Rutina rutina);

    /** Busca una rutina por su identificador. */
    Rutina buscarRutina(ObjectId id);
    
    /** Busca y elimina una rutina de la base de datos. */
    public boolean eliminarRutinaPorId(ObjectId id);


    
}
