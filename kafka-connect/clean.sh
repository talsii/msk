#!/bin/bash

export bootstrap_servers="b-2.msk-eu-central-1.so6e1e.c3.kafka.eu-central-1.amazonaws.com:9092,b-3.msk-eu-central-1.so6e1e.c3.kafka.eu-central-1.amazonaws.com:9092,b-1.msk-eu-central-1.so6e1e.c3.kafka.eu-central-1.amazonaws.com:9092"

topic=${1}
sink_connector="s3_sink_connector_${topic}"
source_connector="s3_source_connector_${topic}"

echo "Deleting connectors ..."
curl -X DELETE http://10.10.1.26:8083/connectors/${sink_connector}

curl -X DELETE http://10.10.1.26:8083/connectors/${source_connector}

echo "Deleting topic"

kafka-topics --bootstrap-server ${bootstrap_servers} --delete --topic ${topic}
