#!/bin/bash

curl http://10.10.1.26:8083/connectors/file_source_connector | jq .

curl http://10.10.1.26:8083/connectors/file_source_connector/status | jq .
