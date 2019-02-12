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


# LIST OF COMPONENTS TO START
COMPONENTS_LIST="
My-TRAC-Platform 
My-TRAC-Companion/examples/CSVToKafkaTopic
Operators-Portal/examples/RatingsVisualizer
"

if [[ -n ${MY_TRAC_DEPLOYMENT} && ${MY_TRAC_DEPLOYMENT} == "docker-compose" || ${MY_TRAC_DEPLOYMENT} == "kubernetes" ]]
then 

  CURRENT_PATH=`pwd`

  for COMPONENT in ${COMPONENTS_LIST}
  do
    echo "Deploying ${COMPONENT}"
    cd ${COMPONENT}/deployments/${MY_TRAC_DEPLOYMENT}
    ./stop.sh
    cd ${CURRENT_PATH}
  done

else
    echo "Not implemented yet"
fi
