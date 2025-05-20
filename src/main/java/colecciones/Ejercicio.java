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
public class Ejercicio {
    
    
    private ObjectId id;
    private String nombre;
    private String descripcion;
    private Set<GrupoMuscular> gruposMusculares;
    private String equipamiento;
    private String urlImagenIncial;
    private String urlImagenFinal;
    private int series;
    private int repeticiones;
    private int tiempoDescanso;

    
    /**
     * Test
     */
    
    public Ejercicio() {
    }

    public Ejercicio(String nombre, String descripcion, Set<GrupoMuscular> gruposMusculares, String equipamiento, String urlImagenIncial, String urlImagenFinal, int series, int repeticiones, int tiempoDescanso) {
        this.nombre = nombre;
        this.descripcion = descripcion;
        this.gruposMusculares = gruposMusculares;
        this.equipamiento = equipamiento;
        this.urlImagenIncial = urlImagenIncial;
        this.urlImagenFinal = urlImagenFinal;
        this.series = series;
        this.repeticiones = repeticiones;
        this.tiempoDescanso = tiempoDescanso;
    }

    public Ejercicio(ObjectId id, String nombre, String descripcion, Set<GrupoMuscular> gruposMusculares, String equipamiento, String urlImagenIncial, String urlImagenFinal, int series, int repeticiones, int tiempoDescanso) {
        this.id = id;
        this.nombre = nombre;
        this.descripcion = descripcion;
        this.gruposMusculares = gruposMusculares;
        this.equipamiento = equipamiento;
        this.urlImagenIncial = urlImagenIncial;
        this.urlImagenFinal = urlImagenFinal;
        this.series = series;
        this.repeticiones = repeticiones;
        this.tiempoDescanso = tiempoDescanso;
    }
    
    

    public ObjectId getId() {
        return id;
    }

    public void setId(ObjectId id) {
        this.id = id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public Set<GrupoMuscular> getGruposMusculares() {
        return gruposMusculares;
    }

    public void setGruposMusculares(Set<GrupoMuscular> gruposMusculares) {
        this.gruposMusculares = gruposMusculares;
    }

    public String getEquipamiento() {
        return equipamiento;
    }

    public void setEquipamiento(String equipamiento) {
        this.equipamiento = equipamiento;
    }

    public String getUrlImagenIncial() {
        return urlImagenIncial;
    }

    public void setUrlImagenIncial(String urlImagenIncial) {
        this.urlImagenIncial = urlImagenIncial;
    }

    public String getUrlImagenFinal() {
        return urlImagenFinal;
    }

    public void setUrlImagenFinal(String urlImagenFinal) {
        this.urlImagenFinal = urlImagenFinal;
    }

    public int getSeries() {
        return series;
    }

    public void setSeries(int series) {
        this.series = series;
    }

    public int getRepeticiones() {
        return repeticiones;
    }

    public void setRepeticiones(int repeticiones) {
        this.repeticiones = repeticiones;
    }

    public int getTiempoDescanso() {
        return tiempoDescanso;
    }

    public void setTiempoDescanso(int tiempoDescanso) {
        this.tiempoDescanso = tiempoDescanso;
    }

    @Override
    public String toString() {
        return "Ejercicio{" + "id=" + id + ", nombre=" + nombre + ", descripcion=" + descripcion + ", gruposMusculares=" + gruposMusculares + ", equipamiento=" + equipamiento + ", urlImagenIncial=" + urlImagenIncial + ", urlImagenFinal=" + urlImagenFinal + ", series=" + series + ", repeticiones=" + repeticiones + ", tiempoDescanso=" + tiempoDescanso + '}';
    }
    
    
    
}
