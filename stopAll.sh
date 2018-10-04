#!/bin/bash
            
CURRENT_PATH=`pwd`
if [[ $DEPLOY_MY_TRAC == "docker_compose" ]]
then 
    cd My-TRAC-Companion/examples/CSVToKafkaTopic/deployments/docker-compose
    yes | ./stop.sh 
    cd $CURRENT_PATH
    cd My-TRAC-Platform/deployments/docker-compose
    yes | ./stop.sh
else
    echo "Not implemented yet"
fi
