#!/bin/bash

set -e
set -o pipefail
            
CURRENT_PATH=`pwd`
if [ -f .docker-compose ]; 
then
    MY_TRAC_DEPLOYMENT=docker-compose
    rm .docker-compose
fi


if [[ -f .kubernetes && -z "$MY_TRAC_DEPLOYMENT" ]]; 
then
    MY_TRAC_DEPLOYMENT=kubernetes
    rm .kubernetes 
fi


if [[ -n ${MY_TRAC_DEPLOYMENT} && ${MY_TRAC_DEPLOYMENT} == "docker-compose" || ${MY_TRAC_DEPLOYMENT} == "kubernetes" ]]
then 
    # STOP My-TRAC Companion Components
    cd My-TRAC-Companion/examples/CSVToKafkaTopic/deployments/${MY_TRAC_DEPLOYMENT}
    ./stop.sh 

    #STOP Operators Portal Components
    cd $CURRENT_PATH
    cd Operators-Portal/examples/RatingsVisualizer/deployments/${MY_TRAC_DEPLOYMENT}
    ./stop.sh

    #STOP PLATFORM
#    cd $CURRENT_PATH
#    cd My-TRAC-Platform/examples/RatingModeler/deployments/${MY_TRAC_DEPLOYMENT} 
#    ./stop.sh 

    cd $CURRENT_PATH
    cd My-TRAC-Platform/deployments/${MY_TRAC_DEPLOYMENT}
    ./stop.sh
else
    echo "Not implemented yet"
fi
