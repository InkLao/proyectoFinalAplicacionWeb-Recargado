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
    
    private static ConexionBD instancia;
    private MongoClient mongoClient;
    private MongoDatabase mongoDatabase;

    // Nombre de la base de datos
    private static final String DB_NAME = "FitRoutine";

    // Constructor privado para evitar instanciación externa
    private ConexionBD() {
        CodecRegistry codecRegistry = fromRegistries(
            MongoClientSettings.getDefaultCodecRegistry(),
            fromProviders(PojoCodecProvider.builder().automatic(true).build())
        );

        ConnectionString cadenaConexion = new ConnectionString("mongodb://localhost:27017");

        MongoClientSettings clientSettings = MongoClientSettings.builder()
            .applyConnectionString(cadenaConexion)
            .codecRegistry(codecRegistry)
            .build();

        mongoClient = MongoClients.create(clientSettings);
        mongoDatabase = mongoClient.getDatabase(DB_NAME);
    }

    // Método público para obtener la instancia singleton
    public static ConexionBD getInstancia() {
        if (instancia == null) {
            synchronized (ConexionBD.class) {
                if (instancia == null) {
                    instancia = new ConexionBD();
                }
            }
        }
        return instancia;
    }

    // Método para obtener la base de datos
    public MongoDatabase getDatabase() {
        return mongoDatabase;
    }

    // Método para cerrar la conexión (llamar al parar la app)
    public void cerrarConexion() {
        if (mongoClient != null) {
            mongoClient.close();
            mongoClient = null;
            instancia = null;
        }
    }
    
}
