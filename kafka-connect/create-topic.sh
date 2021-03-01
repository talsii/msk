#!/bin/bash

export bootstrap_servers="b-2.msk-eu-west-1.15x4ul.c1.kafka.eu-west-1.amazonaws.com:9092,b-3.msk-eu-west-1.15x4ul.c1.kafka.eu-west-1.amazonaws.com:9092,b-1.msk-eu-west-1.15x4ul.c1.kafka.eu-west-1.amazonaws.com:9092"

topic=${1}
partitions=${2}
replication_factor=${3}
echo "Creating topic ${topic} with ${partitions} and a replication factor of ${replication_factor} .."
#kafka-topics --bootstrap-server ${bootstrap_servers} --create --topic connect_file --partitions 10 --replication-factor 3

