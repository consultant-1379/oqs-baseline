# OpenStack Queuing Solution #
The OQS is used to handle the queuing of Deployment CI/CD pipelines within their respective OpenStack multi-tenant Cloud (Pod) environments.

The purpose of the tool is to allow administrators to configure specific queuing for each individual Pod,
as well as provide a Radiator-View interface for users to analyse the queuing information for every Pod.

The tool is organised into 5 different repos, under the oqs-baseline repo.
Each one of them holds the code responsible for serving a specific function, as indicated by their names:

- oqs-baseline

    - oqs-client: client-side code repo
    - oqs-server: server-side code repo
    - oqs-helpdocs
    - oqs-apidocs
    - oqs-smoketests

After cloning the baseline repo, all other repos can be cloned by running the shell script `oqsDevSetup.sh [SIGNUM]`

[More information about OQS](https://atvoqs.athtem.eei.ericsson.se/help-docs/#help/app/helpdocs)

# Prerequisites #

## Setting up WSL2 on Windows ##
If working from Windows Environment, WSL2 should be set up.

Steps can be found through this [link](https://eteamspace.internal.ericsson.com/display/TST/Docker+on+Windows+10)

## Install ##
Docker, Docker-compose, GIT

## Setting up Gerrit ##
SSH public key can be added in Gerrit settings.

# .env Variables #

Before running the project in development mode, the .env file is required at the root of the project with the following contents (Note: See oqs-smoketests repo .env file for up to date contents):
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
LDAP_URL=LDAPS://ldap-egad.internal.ericsson.com:3269
BASE_DN_LIST=OU=CA,OU=User,OU=P001,OU=ID,OU=Data,DC=ericsson,DC=se:OU=External,OU=P017,OU=ID,OU=Data,DC=ericsson,DC=se:OU=CA,OU=SvcAccount,OU=P001,OU=ID,OU=Data,DC=ericsson,DC=se
SEARCH_FILTER=(name={{username}})
OQS_EMAIL_ADDRESS=no-reply-oqs@ericsson.com
DTT_EMAIL_ADDRESS=no-reply-dtt@ericsson.com
DTT_EMAIL_PASSWORD=
TEAM_EMAIL=PDLCIINFRA@pdl.internal.ericsson.com
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Deployment (Development) #

Run oqsDevSetup.sh to clone all other repos of OQS: `./oqsDevSetup.sh`

Run git_reset_all_repos.sh to reset/fetch and rebase all repos: `./git_reset_all_repos.sh`

Run dev.sh: `./dev.sh`

To verify: From within your preferred web browser navigate to `localhost:80` or `<VM_IP_ADDRESS>:80`

To find out the VM IP Address, run: `hostname -I`

If port 80 is already in use, open `docker-compose.yml` and update port number in `nginx: ports` to any other availabe port.

To stop process: Ctrl+C in the terminal.

Verify by navigating to 'localhost'

# Deployment (Production) #

## Install ##

ssh root into the Production OQS Server

Make the /oqs/ directory:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
mkdir -p /oqs/
cd /oqs/
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Clone down the OQS repo so that the docker-compose related files can be used:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
git clone ssh://<signum>@gerrit.ericsson.se:29418/OSS/com.ericsson.aas.openstackqueuingsolution/oqs-baseline
cd oqs-baseline
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(Optional) Ensure full permissions are available on the files: `chmod 777 . -R`

To launch production mode locally, first **SSl Cert** needs to be set up.
Steps can be found through this [link](https://eteamspace.internal.ericsson.com/display/ENTT/CI+Infra+-+OQS+-+SSL+Certificate+Local+Setup)

After setting it up, run the script:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./install.sh <BASELINE_VERSION> <CLIENT_VERSION> <SERVER_VERSION> <HELPDOCS_VERSION> <APIDOCS_VERSION>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Example:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./install.sh 1.0.16 1.0.33 1.0.27 1.0.7 1.0.7
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**Note**: if in unlkely event upgrade fails with an error 'Permision denied (Public key). fatal: Could not read from remote repository'.

Ssh into the vm.

 Cd into a tool folder and check that there is a valid user signum infront of gerrit url:

`cat .git/config` If there isn't use `vi .git/config` to modify.

Run `cat ~/.shh/id_rsa.pub`. Paste contents in Gerrit under Settings - SSH Public Keys.

## Upgrade ##

**Note**: Only if there issue with Team's Upgrade Tool these actions are used.

ssh root into the Production OQS Server

Navigate to the /oqs/oqs-baseline directory: `cd /oqs/oqs-baseline/`

Now run the auto_upgrade.sh script, passing in each repo version to upgrade, like in following order:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./auto_upgrade.sh <BASELINE_VERSION> <CLIENT_VERSION> <SERVER_VERSION> <HELPDOCS_VERSION> <APIDOCS_VERSION>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Example:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./auto_upgrade.sh 1.0.16 1.0.33 1.0.27 1.0.7 1.0.7
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
It will ask you to confirm the versions passed in.

This will get latest code for baseline repo.

Passes the versions into upgrade.sh. upgrade.sh will set the versions in the docker-compose-production.yml and a database backup is taken before the new container is brought up.

Check that OQS is up and running after the upgrade script completes by navigating to it in your web browser and verifying that it is available.

# Rollback (Downgrade) #

**Note**: Only if there issue with Team's Upgrade Tool these actions are used.

If a rollback of OQS is required, run the same actions as for upgrade, but instead use the version you want to roll back to.

# Import the latest DB #

- To get Network Name, run `docker network ls`
- To import DBs from a local source: `./import_latest_DB.sh <network_name> local`
- To import DBs from the live tool: `./import_latest_DB.sh <network_name> live`

# Running the Tests #

## Smoke Tests ##

* After all OQS repos are cloned. Without the tool running, in the oqs-baseline folder execute: `./smokeTests.sh`

## Linting and Unit Tests ##

* In a seperate terminal (whilst OQS is running) execute: `./webshellTests.sh`

* To run only Server or Linting tests:
 - Execute `./webshell.sh`
 - Execute `./tests/allTests.sh`

# Change Logs #
- Newer (six months worth): https://arm1s11-eiffel004.eiffel.gic.ericsson.se:8443/nexus/content/sites/tor/oqs-baseline/latest/changelog.html
- For Versions 1.16.2 and older:
https://arm1s11-eiffel004.eiffel.gic.ericsson.se:8443/nexus/content/sites/tor/oqs-baseline/latest/change_log.html

# Authors #

**CI Infra Team** - PDLCIINFRA@pdl.internal.ericsson.com