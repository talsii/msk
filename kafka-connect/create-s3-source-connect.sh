#!/bin/bash

topic=${1}
connector="s3_source_connector_${topic}"

generate_body() {
cat <<EOF
{
    "name": "${connector}",
    "config": {
        "connector.class": "io.confluent.connect.s3.S3SourceConnector",
        "topics": "${topic}",
        "s3.region": "eu-west-1",
        "tasks.max": 1,
        "s3.bucket.name": "talsii.kafka.connect.source",
        "format.class": "io.confluent.connect.s3.format.avro.AvroFormat"
    }
}
EOF
}

echo "Creating s3 source connector:  ${connector} ..."

curl -X POST http://10.10.1.26:8083/connectors \
-H 'Accept: */*' \
-H 'Content-Type: application/json' \
-d "$(generate_body)"

sleep 5

echo "Checking s3 source connector: ${connector} ..."
curl http://10.10.1.26:8083/connectors/${connector} | jq .