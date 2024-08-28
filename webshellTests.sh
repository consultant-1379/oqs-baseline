#!/bin/bash
docker exec -it oqs_development_express_1 ./tests/allTests.sh
docker cp oqs_development_express_1:/usr/src/app/coverage .
