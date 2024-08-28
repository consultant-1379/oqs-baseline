#!/bin/bash

BASELINE_VERSION=$1
CLIENT_VERSION=$2
SERVER_VERSION=$3
HELPDOCS_VERSION=$4
APIDOCS_VERSION=$5

export COMPOSE_PROJECT_NAME="oqsproduction"
if [[ $BASELINE_VERSION == "" ]]
then
    echo "Baseline Version not found. Please specify a valid Baseline Version";
    exit 1
fi
if [[ $CLIENT_VERSION == "" ]]
then
    echo "Client Version not found. Please specify a valid Client Version";
    exit 1
fi
if [[ $SERVER_VERSION == "" ]]
then
    echo "Server Version not found. Please specify a valid Server Version";
    exit 1
fi
if [[ $HELPDOCS_VERSION == "" ]]
then
    echo "Help-Docs Version not found. Please specify a valid Help-Docs Version";
    exit 1
fi
if [[ $APIDOCS_VERSION == "" ]]
then
    echo "API-Docs Version not found. Please specify a valid API-Docs Version";
    exit 1
fi
time docker-compose -f docker-compose-production.yml pull
if [[ $? -ne 0 ]]
then
    exit 1
fi
time BASELINE_VERSION=$BASELINE_VERSION CLIENT_VERSION=$CLIENT_VERSION SERVER_VERSION=$SERVER_VERSION HELPDOCS_VERSION=$HELPDOCS_VERSION APIDOCS_VERSION=$APIDOCS_VERSION docker-compose -f docker-compose-production.yml up -d

./update_versions.sh $BASELINE_VERSION $CLIENT_VERSION $HELPDOCS_VERSION $APIDOCS_VERSION