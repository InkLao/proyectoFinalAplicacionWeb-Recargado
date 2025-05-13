/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package colecciones;

import java.util.Set;
import org.bson.types.ObjectId;

/**
 *
 * @author Arturo ITSON
 */
public class Rutina {
    
    
    private ObjectId id;
    private String nombreRutina;
    private boolean asignadaPorEntrenador;
    private Set<Ejercicio> ejercicios;
    private String nombreUsuario;
    private String nombreEntrenador;

    
    public Rutina() {
    }

    
    public Rutina(ObjectId id, String nombreRutina, boolean asignadaPorEntrenador, Set<Ejercicio> ejercicios, String nombreUsuario, String nombreEntrenador) {
        this.id = id;
        this.nombreRutina = nombreRutina;
        this.asignadaPorEntrenador = asignadaPorEntrenador;
        this.ejercicios = ejercicios;
        this.nombreUsuario = nombreUsuario;
        this.nombreEntrenador = nombreEntrenador;
    }
    

    public Rutina(String nombreRutina, boolean asignadaPorEntrenador, Set<Ejercicio> ejercicios, String nombreUsuario, String nombreEntrenador) {
        this.nombreRutina = nombreRutina;
        this.asignadaPorEntrenador = asignadaPorEntrenador;
        this.ejercicios = ejercicios;
        this.nombreUsuario = nombreUsuario;
        this.nombreEntrenador = nombreEntrenador;
    }

    
    public ObjectId getId() {
        return id;
    }

    public void setId(ObjectId id) {
        this.id = id;
    }

    public String getNombreRutina() {
        return nombreRutina;
    }

    public void setNombreRutina(String nombreRutina) {
        this.nombreRutina = nombreRutina;
    }

    public boolean isAsignadaPorEntrenador() {
        return asignadaPorEntrenador;
    }

    public void setAsignadaPorEntrenador(boolean asignadaPorEntrenador) {
        this.asignadaPorEntrenador = asignadaPorEntrenador;
    }

    public Set<Ejercicio> getEjercicios() {
        return ejercicios;
    }

    public void setEjercicios(Set<Ejercicio> ejercicios) {
        this.ejercicios = ejercicios;
    }

    public String getNombreUsuario() {
        return nombreUsuario;
    }

    public void setNombreUsuario(String nombreUsuario) {
        this.nombreUsuario = nombreUsuario;
    }

    public String getNombreEntrenador() {
        return nombreEntrenador;
    }

    public void setNombreEntrenador(String nombreEntrenador) {
        this.nombreEntrenador = nombreEntrenador;
    }
    

    @Override
    public String toString() {
        return "Rutina{" + "id=" + id + ", nombreRutina=" + nombreRutina + ", asignadaPorEntrenador=" + asignadaPorEntrenador + ", ejercicios=" + ejercicios + ", nombreUsuario=" + nombreUsuario + ", nombreEntrenador=" + nombreEntrenador + '}';
    }
    
    
    
}
