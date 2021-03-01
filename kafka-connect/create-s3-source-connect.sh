#!/bin/bash

topic=${1}

generate_body() {
cat <<EOF
{
    "name": "s3_source_connector",
    "config": {
        "connector.class": "io.confluent.connect.s3.S3SinkConnector",
        "topics": "${topic}",
        "s3.region": "eu-west-1",
        "s3.bucket.name": "talsii.kafka.connect.source",
        "s3.part.size": "5242880",
        "flush.size": 3,
        "value.converter": "org.apache.kafka.connect.storage.StringConverter",
        "format.class": "io.confluent.connect.s3.format.avro.AvroFormat",
        "partitioner.class": "io.confluent.connect.storage.partitioner.DefaultPartitioner",
        "storage.class": "io.confluent.connect.s3.storage.S3Storage"
    }
}
EOF
}

echo "Creating s3 sink connect ..."

curl -X POST http://10.10.1.26:8083/connectors \
-H 'Accept: */*' \
-H 'Content-Type: application/json' \
-d "$(generate_body)"

echo "Checking s3 sink connect ..."
curl http://10.10.1.26:8083/connectors/s3_source_connector | jq .