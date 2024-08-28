#!/bin/bash
#To upgrade production OQS to a specific version, run ./auto_upgrade.sh <baseline_version> <client_version> <server_version> <helpdocs_version> <apidocs_version>
#Example:
#./auto_upgrade.sh 1.0.16 1.0.33 1.0.27 1.0.7 1.0.7

BASELINE_VERSION=$1
CLIENT_VERSION=$2
SERVER_VERSION=$3
HELPDOCS_VERSION=$4
APIDOCS_VERSION=$5

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

echo -e "Are you sure you want to upgrade OQS to versions:"
echo -e "BASELINE:\t$BASELINE_VERSION"
echo -e "CLIENT:\t\t$CLIENT_VERSION"
echo -e "SERVER:\t\t$SERVER_VERSION"
echo -e "HELPDOCS:\t$HELPDOCS_VERSION"
echo -e "APIDOCS:\t$APIDOCS_VERSION"
read -p "(Y/N)?" -n 1 -r

echo #move to a new line
if [[ $REPLY =~ ^[Y]$ ]]
then
    echo "Checking out the latest OQS Base-Line code...";
    git checkout -f master
    git reset --hard origin/master
    git pull -f

    echo "Performing OQS upgrade...";
    ./upgrade.sh $BASELINE_VERSION $CLIENT_VERSION $SERVER_VERSION $HELPDOCS_VERSION $APIDOCS_VERSION
    if [[ $? -ne 0 ]]
    then
        echo "OQS upgrade failed.";
    else
        echo "OQS upgrade complete.";
    fi
else
    echo "OQS upgrade cancelled.";
fi
