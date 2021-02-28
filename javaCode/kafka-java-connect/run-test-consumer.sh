export MYBS=$(cat src/main/resources/config.properties | grep bootstrap | cut -d'=' -f2)

kafka-console-consumer --bootstrap-server $MYBS --topic count-topic --from-beginning
