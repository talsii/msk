#!/bin/bash

c9_public_ip=$(curl http://169.254.169.254/latest/meta-data/public-ipv4 2>/dev/null)

echo "Public IP: ${c9_public_ip}"

echo "Starting Promotheus container: ..."
sudo docker start prometheus
echo "Prometheus URL: http://${c9_public_ip}:9090"

echo "Starting Grafana container: ..."
sudo docker start grafana
echo "Grafana URL: http://${c9_public_ip}:3000"

echo "Starting Cruise Control service: ..."
cd /home/ec2-user/environment/monitoring/cruise-control-2.5.22
./kafka-cruise-control-start.sh -daemon config/cruisecontrol.properties 
echo "Cruise Control URL: http://${c9_public_ip}:9091"

