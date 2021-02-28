package com.amazon.kafkaStreamsAggregation;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

import java.util.Properties;
import java.util.concurrent.CountDownLatch;
import org.apache.kafka.common.serialization.Serdes;
import org.apache.kafka.streams.KafkaStreams;
import org.apache.kafka.streams.StreamsBuilder;
import org.apache.kafka.streams.StreamsConfig;
import org.apache.kafka.streams.Topology;
import org.apache.kafka.streams.kstream.KGroupedStream;
import org.apache.kafka.streams.kstream.KStream;
import org.apache.kafka.streams.kstream.KTable;
import org.apache.kafka.streams.kstream.Materialized;
import org.apache.kafka.streams.kstream.Produced;

public class StatefullAggregationsMain {

    public static void main(String[] args) {
        Properties props = new Properties();
        
        try (InputStream input = StatefullAggregationsMain.class.getClassLoader().getResourceAsStream("config.properties")) {
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

        String inputTopic = props.getProperty("input.topic");
        String outputTopic1 = props.getProperty("output.topic1");
        String outputTopic2 = props.getProperty("output.topic2");
        String outputTopic3 = props.getProperty("output.topic3");

        // Get the source stream.
        final StreamsBuilder builder = new StreamsBuilder();
        final KStream<String, String> source = builder.stream(inputTopic);

        // Group the source stream by the existing Key.
        KGroupedStream<String, String> groupedStream = source.groupByKey();
       
       // Create an aggregation that totals the length in characters of the value for all records sharing the same key.
        KTable<String, Integer> aggregatedTable = groupedStream.aggregate(
            () -> 0,
            (aggKey, newValue, aggValue) -> aggValue + newValue.length(),
            Materialized.with(Serdes.String(), Serdes.Integer()));
        aggregatedTable.toStream().to(outputTopic1, Produced.with(Serdes.String(), Serdes.Integer()));
       
        // Count the number of records for each key.
        KTable<String, Long> countedTable = groupedStream.count(Materialized.with(Serdes.String(), Serdes.Long()));
        countedTable.toStream().to(outputTopic2,  Produced.with(Serdes.String(), Serdes.Long()));
       
        // Combine the values of all records with the same key into a string separated by spaces.
        KTable<String, String> reducedTable = groupedStream.reduce((aggValue, newValue) -> aggValue + " " + newValue);
        reducedTable.toStream().to(outputTopic3);

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