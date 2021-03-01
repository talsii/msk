#!/bin/bash

export bootstrap_servers="b-2.msk-eu-west-1.15x4ul.c1.kafka.eu-west-1.amazonaws.com:9092,b-3.msk-eu-west-1.15x4ul.c1.kafka.eu-west-1.amazonaws.com:9092,b-1.msk-eu-west-1.15x4ul.c1.kafka.eu-west-1.amazonaws.com:9092"

topic=${1}

kafka-console-consumer --bootstrap-server ${bootstrap_servers} --topic ${topic} --from-beginning
