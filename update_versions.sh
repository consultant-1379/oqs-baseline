#!/bin/bash
# This script is used to update Baseline, Client, Helpdocs and Apidocs versions.
# The arguments provided when running the script: ./update_versions.sh <baseline_version> <client_version> <helpdocs_version> <apidocs_version>

declare -A versions=( ["baseline"]="$1" ["client"]="$2" ["helpdocs"]="$3" ["apidocs"]="$4")

for version in "${!versions[@]}";
do
    docker exec -i oqsproduction_express_1 sh <<!
        echo "Updating $version version..."
        echo ${versions[$version]} > /usr/src/app/version-info/$version/VERSION
        echo "$version Version Updated to:"
        cat /usr/src/app/version-info/$version/VERSION
!
done