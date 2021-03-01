#!/bin/bash

echo "Creating MirrorCheckpointConnector ..."
curl -X PUT -H "Content-Type: application/json" --data @/tmp/kafka/mm2-hbc.json http://localhost:8083/connectors/mm2-hbc/config

echo "Checking MirrorCheckpointConnector status ..."
curl -s http://localhost:8083/connectors/mm2-hbc/status | jq .
