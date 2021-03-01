#!/bin/bash

topic=${1}
connector="s3_source_connector_${topic}"

generate_body() {
cat <<EOF
{
    "name": "${connector}",
    "config": {
        "connector.class": "org.apache.kafka.connect.file.FileStreamSourceConnector",
        "topic": "${topic}",
        "file": "/home/ec2-user/input.csv",
        "value.converter": "org.apache.kafka.connect.storage.StringConverter"
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

