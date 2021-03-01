#!/bin/bash

java -jar   /tmp/kafka/MM2GroupOffsetSync-1.0-SNAPSHOT.jar 
            -cgi mm2TestConsumer1 \
            -src msksource \
            -pfp /tmp/kafka/consumer.properties_sync_dest 2>&1 > /dev/null &
