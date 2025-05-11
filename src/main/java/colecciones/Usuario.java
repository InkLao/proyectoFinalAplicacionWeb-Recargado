/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package colecciones;

import org.bson.types.ObjectId;

/**
 *
 * @author Arturo ITSON
 */
public class Usuario {
    
    
    ObjectId id;
    String nombre;
    String usuario;
    String contrasena;

    
    public Usuario(){
    
    }

    
    public Usuario(String nombre, String usuario, String contrasena) {
        this.nombre = nombre;
        this.usuario = usuario;
        this.contrasena = contrasena;
    }

    public Usuario(ObjectId id, String nombre, String usuario, String contrasena) {
        this.id = id;
        this.nombre = nombre;
        this.usuario = usuario;
        this.contrasena = contrasena;
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

    public String getUsuario() {
        return usuario;
    }

    public void setUsuario(String usuario) {
        this.usuario = usuario;
    }

    public String getContrasena() {
        return contrasena;
    }

    public void setContrasena(String contrasena) {
        this.contrasena = contrasena;
    }

    
    
    @Override
    public String toString() {
        return "Usuario{" + "id=" + id + ", nombre=" + nombre + ", usuario=" + usuario + ", contrasena=" + contrasena + '}';
    }

    
}
