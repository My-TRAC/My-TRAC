#!/bin/bash

set -e
set -o pipefail

function print_usage { 
    echo "startAll.sh -d/--deployment [docker-compose/kubernetes]"
    echo "startAll.sh -h/--help"
}


if [[ $# == 0 ]]
then
    print_usage
    exit
fi

while [[ $# > 0 ]]
do
    key="$1"
    case $key in
    -h|--help)
        HELP=YES
        ;;
    -d|--deployment)
	MY_TRAC_DEPLOYMENT="$2"
	if [[ $MY_TRAC_DEPLOYMENT = "docker-compose" ]] 
	then
        touch .docker-compose
    else
        if [[ $MY_TRAC_DEPLOYMENT = "kubernetes" ]] 
        then
            touch .kubernetes
        else
		    echo "Invalid deployment type \"${MY_TRAC_DEPLOYMENT}\""
		    exit 1 
        fi
	fi
        shift # past argument
        ;;
    esac
    shift
done


if [[ ! -z $HELP ]]
then
	print_usage
	exit
fi


# LIST OF COMPONENTS TO START
COMPONENTS_LIST="
My-TRAC-Platform 
My-TRAC-Companion/examples/CSVToKafkaTopic
Operators-Portal/examples/RatingsVisualizer
"

COMPONENTS_LIST="
My-TRAC-Platform 
My-TRAC-Companion/examples/CSVToKafkaTopic
"

if [[ -n "${MY_TRAC_DEPLOYMENT}" ]]
then 

  export MY_TRAC_DEPLOYMENT
  CURRENT_PATH=`pwd`

  for COMPONENT in ${COMPONENTS_LIST}
  do
    echo "Deploying ${COMPONENT}"
    cd ${COMPONENT}/deployments/${MY_TRAC_DEPLOYMENT}
    ./start.sh
    cd ${CURRENT_PATH}
  done
else
    echo "Not implemented yet"
fi
