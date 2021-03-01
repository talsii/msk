#!/bin/bash

export bootstrap_servers="b-2.msk-eu-west-1.15x4ul.c1.kafka.eu-west-1.amazonaws.com:9092,b-3.msk-eu-west-1.15x4ul.c1.kafka.eu-west-1.amazonaws.com:9092,b-1.msk-eu-west-1.15x4ul.c1.kafka.eu-west-1.amazonaws.com:9092"

topic=${topic}

echo "Deleting connectors ..."
curl -X DELETE http://10.10.1.26:8083/connectors/s3_sink_connector

curl -X DELETE http://10.10.1.26:8083/connectors/s3_source_connector

echo "Deleting topic"

kafka-topics --bootstrap-server ${bootstrap_servers} --delete --topic ${topic}
