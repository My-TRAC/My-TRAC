#!/bin/bash

set -e
set -o pipefail
            
CURRENT_PATH=`pwd`
if [[ -n ${MY_TRAC_DEPLOYMENT} && ${MY_TRAC_DEPLOYMENT} == "docker-compose" ]]
then 
    cd My-TRAC-Companion/examples/CSVToKafkaTopic/deployments/${MY_TRAC_DEPLOYMENT}
    ls
    ./stop.sh 
    cd $CURRENT_PATH
    cd My-TRAC-Platform/deployments/${MY_TRAC_DEPLOYMENT}
    ./stop.sh
else
    echo "Not implemented yet"
fi
