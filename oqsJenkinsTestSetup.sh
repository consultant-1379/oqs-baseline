#!/bin/bash
#API docs
git clone ssh://gerrit.ericsson.se:29418/OSS/com.ericsson.aas.openstackqueuingsolution/oqs-apidocs
#Client
git clone ssh://gerrit.ericsson.se:29418/OSS/com.ericsson.aas.openstackqueuingsolution/oqs-client
#Help docs
git clone ssh://gerrit.ericsson.se:29418/OSS/com.ericsson.aas.openstackqueuingsolution/oqs-helpdocs
#Server
git clone ssh://gerrit.ericsson.se:29418/OSS/com.ericsson.aas.openstackqueuingsolution/oqs-server
#Smoketests
git clone ssh://gerrit.ericsson.se:29418/OSS/com.ericsson.aas.openstackqueuingsolution/oqs-smoketests

echo 'Cloning Complete. To run OQS run ./preCodeReview.sh or ./smokeTests.sh'
