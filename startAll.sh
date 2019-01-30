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

CURRENT_PATH=`pwd`

if [[ -n "${MY_TRAC_DEPLOYMENT}" ]]
then 
    export MY_TRAC_DEPLOYMENT

    echo "Deploying My-TRAC Platform"
    cd My-TRAC-Platform/deployments/${MY_TRAC_DEPLOYMENT}
    ./start.sh


    echo "Deploying CSVToKafkaTopic"
    cd $CURRENT_PATH
    cd My-TRAC-Companion/examples/CSVToKafkaTopic/deployments/${MY_TRAC_DEPLOYMENT}
    ./start.sh

    echo "Deploying RatingsVisualizer"
    cd $CURRENT_PATH
    cd Operators-Portal/examples/RatingsVisualizer/deployments/${MY_TRAC_DEPLOYMENT}
    ./start.sh
else
    echo "Not implemented yet"
fi
