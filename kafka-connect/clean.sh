#!/bin/bash

curl -X DELETE http://10.10.1.26:8083/connectors/file_source_connector

curl -X DELETE http://10.10.1.26:8083/connectors/file_sink_connector
