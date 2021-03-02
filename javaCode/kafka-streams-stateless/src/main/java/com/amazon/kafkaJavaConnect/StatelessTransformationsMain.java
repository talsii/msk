package com.amazon.kafkaStreamsStateless;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

import java.util.LinkedList;
import java.util.List;

import java.util.concurrent.CountDownLatch;
import org.apache.kafka.common.serialization.Serdes;
import org.apache.kafka.streams.KafkaStreams;
import org.apache.kafka.streams.KeyValue;
import org.apache.kafka.streams.StreamsBuilder;
import org.apache.kafka.streams.StreamsConfig;
import org.apache.kafka.streams.Topology;
import org.apache.kafka.streams.kstream.KStream;

public class StatelessTransformationsMain {

    public static void main(String[] args) {
        Properties props = new Properties();
        
        try (InputStream input = StatelessTransformationsMain.class.getClassLoader().getResourceAsStream("config.properties")) {
            if (input == null) {
                System.out.println("Sorry, unable to find config.properties");
                System.exit(1);
            }else {
                props.load(input);
            }
        } catch (IOException ex) {
            ex.printStackTrace();
        }

        // Set up the configuration.
        props.put(StreamsConfig.APPLICATION_ID_CONFIG, "inventory-data");
        props.put(StreamsConfig.CACHE_MAX_BYTES_BUFFERING_CONFIG, 0);
        // Since the input topic uses Strings for both key and value, set the default Serdes to String.
        props.put(StreamsConfig.DEFAULT_KEY_SERDE_CLASS_CONFIG, Serdes.String().getClass().getName());
        props.put(StreamsConfig.DEFAULT_VALUE_SERDE_CLASS_CONFIG, Serdes.String().getClass().getName());

        // Get the source stream.
        final StreamsBuilder builder = new StreamsBuilder();
        final KStream<String, String> source = builder.stream("stateless-transformations-input-topic");

        // Split the stream into two streams, one containing all records where the key starts with a and the other containing all other records.
        KStream<String, String>[] branches = source.branch((key, value) -> true, (key, value) -> true);
        KStream<String, String> aKeysStream = branches[0];
        KStream<String, String> othersStream = branches[1];

        // For the "a" stream, modify all records by uppercasing the key.
        aKeysStream = aKeysStream.map((key, value) -> KeyValue.pair(key, value.toUpperCase()));

        // For the "a" stream, modify all records by uppercasing the key.
        othersStream = othersStream.map((key, value) -> KeyValue.pair(key, value.toLowerCase()));

        //Merge the two streams back together.
        KStream<String, String> mergedStream = aKeysStream.merge(othersStream);

        //Print each record to the console.
        mergedStream.peek((key, value) -> System.out.println("key=" + key + ", value=" + value));

        //Output the transformed data to a topic.
        mergedStream.to("stateless-transformations-output-topic");

        final Topology topology = builder.build();
        final KafkaStreams streams = new KafkaStreams(topology, props);
        // Print the topology to the console.
        System.out.println(topology.describe());
        final CountDownLatch latch = new CountDownLatch(1);

        // Attach a shutdown handler to catch control-c and terminate the application gracefully.
        Runtime.getRuntime().addShutdownHook(new Thread("streams-wordcount-shutdown-hook") {
            @Override
            public void run() {
                streams.close();
                latch.countDown();
            }
        });

        try {
            streams.start();
            latch.await();
        } catch (final Throwable e) {
            System.out.println(e.getMessage());
            System.exit(1);
        }
        System.exit(0);
   }
}