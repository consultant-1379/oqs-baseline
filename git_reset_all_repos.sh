#!/bin/bash
# This script is used to reset all oqs repos before starting working on a new task/story/improvement

# Baseline
echo "Reseting repo"
git reset --hard origin/master
echo "Fetching and Rebasing"
git fetch && git rebase origin/master

# Others
declare -a allRepos=("client" "server" "helpdocs" "apidocs" "smoketests")

for repo in "${allRepos[@]}"
do
    echo "---------------------------------------------------------------"
    echo "cd into oqs-$repo"
    cd oqs-$repo
    echo "Reseting repo oqs-$repo"
    git reset --hard origin/master
    echo "Fetching and Rebasing"
    git fetch && git rebase origin/master
    echo "cd back to oqs-baseline"
    cd ..
done

echo "Script Finished"
