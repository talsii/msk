#!/bin/bash

echo "Creating MirrorSourceConnector ..."
curl -X PUT -H "Content-Type: application/json" --data @/tmp/kafka/mm2-msc.json http://localhost:8083/connectors/mm2-msc/config | jq .

echo "Creating MirrorCheckpointConnector ..."
curl -X PUT -H "Content-Type: application/json" --data @/tmp/kafka/mm2-hbc.json http://localhost:8083/connectors/mm2-hbc/config | jq .


echo "Creating MirrorCheckpointConnector ..."
curl -X PUT -H "Content-Type: application/json" --data @/tmp/kafka/mm2-cpc.json http://localhost:8083/connectors/mm2-cpc/config | jq .


