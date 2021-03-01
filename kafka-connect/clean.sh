#!/bin/bash

topic=${topic}

echo "Deleting connectors ..."
curl -X DELETE http://10.10.1.26:8083/connectors/s3_sink_connector

curl -X DELETE http://10.10.1.26:8083/connectors/s3_source_connector

echo "Deleting topic"

echo "Checking created topic ${topic} ..."
kafka-topics --bootstrap-server ${bootstrap_servers} --describe --topic ${topic}