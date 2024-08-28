#!/bin/bash
if [[ $# -ne 1 ]] ; then
    echo 'Usage ./oqs-setup.sh [SIGNUM]'
    exit 1
fi
#API docs
git clone ssh://$1@gerrit.ericsson.se:29418/OSS/com.ericsson.aas.openstackqueuingsolution/oqs-apidocs && scp -p -P 29418 $1@gerrit.ericsson.se:hooks/commit-msg oqs-apidocs/.git/hooks/
#Client
git clone ssh://$1@gerrit.ericsson.se:29418/OSS/com.ericsson.aas.openstackqueuingsolution/oqs-client && scp -p -P 29418 $1@gerrit.ericsson.se:hooks/commit-msg oqs-client/.git/hooks/
#Help docs
git clone ssh://$1@gerrit.ericsson.se:29418/OSS/com.ericsson.aas.openstackqueuingsolution/oqs-helpdocs && scp -p -P 29418 $1@gerrit.ericsson.se:hooks/commit-msg oqs-helpdocs/.git/hooks/
#Server
git clone ssh://$1@gerrit.ericsson.se:29418/OSS/com.ericsson.aas.openstackqueuingsolution/oqs-server && scp -p -P 29418 $1@gerrit.ericsson.se:hooks/commit-msg oqs-server/.git/hooks/
#Smoketests
git clone ssh://$1@gerrit.ericsson.se:29418/OSS/com.ericsson.aas.openstackqueuingsolution/oqs-smoketests && scp -p -P 29418 $1@gerrit.ericsson.se:hooks/commit-msg oqs-smoketests/.git/hooks/

echo 'Cloning Complete. To run OQS run the ./dev.sh script'
