#!/bin/bash

echo "Checking MirrorSourceConnector status ..."
curl -s http://localhost:8083/connectors/mm2-msc/status | jq .

echo "Checking MirrorCheckpointConnector status ..."
curl -s http://localhost:8083/connectors/mm2-cpc/status | jq .

echo "Checking MirrorHeartbeatConnector status ..."
curl -s http://localhost:8083/connectors/mm2-hbc/status | jq .
