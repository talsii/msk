#!/bin/bash

curl http://10.10.1.26:8083/connectors/s3_sink_connector | jq .

curl http://10.10.1.26:8083/connectors/s3_sink_connector/status | jq .
