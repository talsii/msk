export MYBS=$(cat src/main/resources/config.properties | grep bootstrap | cut -d'=' -f2)
export INPTOPIC=$(cat src/main/resources/config.properties | grep input.topic | cut -d'=' -f2)

kafka-console-producer --bootstrap-server $MYBS --topic $INPTOPIC --property parse.key=true --property key.separator=:
