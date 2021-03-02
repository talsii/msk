#!/bin/bash

topic=${1}
connector="s3_source_connector_${topic}"

generate_body() {
cat <<EOF
{
    "name": "${connector}",
    "config": {
        "connector.class": "io.confluent.connect.s3.source.S3SourceConnector",
        "tasks.max": "1",
        "s3.region": "eu-west-1",
        "s3.bucket.name": "talsii.kafka.connect.source",
        "format.class": "io.confluent.connect.s3.format.avro.AvroFormat",
        "partitioner.class": "io.confluent.connect.storage.partitioner.DefaultPartitioner",
        "schema.compatibility": "NONE",
        "transforms": "AddPrefix",
        "transforms.AddPrefix.type": "org.apache.kafka.connect.transforms.RegexRouter",
        "transforms.AddPrefix.regex": ".*",
        "transforms.AddPrefix.replacement": "copy_of_$0",
        "confluent.license": "",
        "confluent.topic.bootstrap.servers": "b-2.msk-eu-west-1.15x4ul.c1.kafka.eu-west-1.amazonaws.com:9092,b-3.msk-eu-west-1.15x4ul.c1.kafka.eu-west-1.amazonaws.com:9092,b-1.msk-eu-west-1.15x4ul.c1.kafka.eu-west-1.amazonaws.com:9092",
        "confluent.topic.replication.factor": "3"
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