#!/bin/bash

echo "Creating MirrorSourceConnector ..."
curl -X PUT -H "Content-Type: application/json" --data @/tmp/kafka/mm2-msc.json http://localhost:8083/connectors/mm2-msc/config

echo "Checking MirrorSourceConnector status ..."
curl -s http://localhost:8083/connectors/mm2-msc/status | jq .
