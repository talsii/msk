export MYBS=$(cat src/main/resources/config.properties | grep bootstrap | cut -d'=' -f2)
export OUTTOPIC=$(cat src/main/resources/config.properties | grep output.topic3| cut -d'=' -f2)

kafka-console-consumer --bootstrap-server $MYBS --topic $OUTTOPIC --property print.key=true 
