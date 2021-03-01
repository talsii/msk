#!/bin/bash

curl -X POST http://10.10.1.26:8083/connectors \
-H 'Accept: */*' \
-H 'Content-Type: application/json' \
-d '{
    "name": "file_source_connector",
    "config": {
        "connector.class": "org.apache.kafka.connect.file.FileStreamSourceConnector",
        "topic": "connect_file",
        "file": "/home/ec2-user/input.csv",
        "value.converter": "org.apache.kafka.connect.storage.StringConverter"
    }
}'
