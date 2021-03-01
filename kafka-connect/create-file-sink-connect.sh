#!/bin/bash

curl -X POST http://10.10.1.26:8083/connectors \
-H 'Accept: */*' \
-H 'Content-Type: application/json' \
-d '{
    "name": "file_sink_connector",
    "config": {
        "connector.class": "org.apache.kafka.connect.file.FileStreamSinkConnector",
        "topics": "connect_topic",
        "file": "/home/ec2-user/output.csv",
        "value.converter": "org.apache.kafka.connect.storage.StringConverter"
    }
}'