#!/bin/bash

echo "Creating MirrorCheckpointConnector ..."
curl -X PUT -H "Content-Type: application/json" --data @/tmp/kafka/mm2-cpc.json http://localhost:8083/connectors/mm2-cpc/config | jq .

sleep 5

echo "Checking MirrorCheckpointConnector status ..."
curl -s http://localhost:8083/connectors/mm2-cpc/status | jq .
