#!/bin/bash

export bootstrap_servers="b-2.msk-eu-central-1.so6e1e.c3.kafka.eu-central-1.amazonaws.com:9092,b-3.msk-eu-central-1.so6e1e.c3.kafka.eu-central-1.amazonaws.com:9092,b-1.msk-eu-central-1.so6e1e.c3.kafka.eu-central-1.amazonaws.com:9092"

topic=${1}

kafka-console-consumer --bootstrap-server ${bootstrap_servers} --topic ${topic} --from-beginning
