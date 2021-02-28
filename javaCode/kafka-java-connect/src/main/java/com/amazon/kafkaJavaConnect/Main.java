package com.amazon.kafkaJavaConnect;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

import org.apache.kafka.clients.producer.*;

public class Main {

    public static void main(String[] args) {
        Properties props = new Properties();
        
        try (InputStream input = Main.class.getClassLoader().getResourceAsStream("config.properties")) {
            if (input == null) {
                System.out.println("Sorry, unable to find config.properties");
                System.exit(1);
            }else {
                props.load(input);
            }
        } catch (IOException ex) {
            ex.printStackTrace();
        }

        Producer<String, String> producer = new KafkaProducer<>(props);
        for (int i = 0; i < 100; i++) {
            producer.send(new ProducerRecord<String, String>("count-topic", "count", Integer.toString(i)));
        }
        producer.close();
    }
}
