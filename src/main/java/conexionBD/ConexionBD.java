/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package conexionBD;

import com.mongodb.ConnectionString;
import com.mongodb.MongoClientSettings;
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoDatabase;
import static org.bson.codecs.configuration.CodecRegistries.fromProviders;
import static org.bson.codecs.configuration.CodecRegistries.fromRegistries;
import org.bson.codecs.configuration.CodecRegistry;
import org.bson.codecs.pojo.PojoCodecProvider;


/**
 *
 * @author Arturo ITSON
 */
public class ConexionBD {
    
        public MongoDatabase conexion() {
            
            
            
        CodecRegistry codecRegistry = fromRegistries(
            MongoClientSettings.getDefaultCodecRegistry(),
            fromProviders(PojoCodecProvider.builder().automatic(true).build())
        );

        // Configura la cadena de conexión a la base de datos MongoDB local
        ConnectionString cadenaConexion = new ConnectionString("mongodb://localhost/27017");

        // Configura los ajustes del cliente MongoDB, incluyendo la cadena de conexión y el registro de códecs
        MongoClientSettings clientsSettings = MongoClientSettings.builder()
                .applyConnectionString(cadenaConexion)
                .codecRegistry(codecRegistry)
                .build();

        // Crea un cliente MongoDB utilizando los ajustes configurados
        MongoClient dbServer = MongoClients.create(clientsSettings);

        // Obtiene la base de datos específica ("ClaseBaseDatosAvanzadas") del cliente MongoDB
        return dbServer.getDatabase("FitRoutine");
    }
    
}
