#!/bin/bash

export bootstrap_servers="b-2.msk-eu-west-1.15x4ul.c1.kafka.eu-west-1.amazonaws.com:9092,b-3.msk-eu-west-1.15x4ul.c1.kafka.eu-west-1.amazonaws.com:9092,b-1.msk-eu-west-1.15x4ul.c1.kafka.eu-west-1.amazonaws.com:9092"

kafka-topics --bootstrap-server ${bootstrap_servers} --create --topic connect_file --partitions 10 --replication-factor 3

