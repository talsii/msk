#!/bin/bash

curl -X DELETE http://10.10.1.26:8083/connectors/s3_sink_connector

curl -X DELETE http://10.10.1.26:8083/connectors/s3_source_connector
