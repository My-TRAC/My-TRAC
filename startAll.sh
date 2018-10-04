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
        DEPLOYMENT="$2"
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

if [[ $DEPLOYMENT == "docker-compose" ]]
then 
    export DEPLOY_MY_TRAC="docker_compose"
    cd My-TRAC-Platform/deployments/docker-compose
    ./start.sh
    cd $CURRENT_PATH
    cd My-TRAC-Companion/examples/CSVToKafkaTopic/deployments/docker-compose
    ./start.sh
else
    echo "Not implemented yet"
fi
