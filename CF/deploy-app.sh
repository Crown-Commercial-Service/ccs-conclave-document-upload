#!/bin/bash

# exit on failures
set -e
set -o pipefail

usage() {
  echo "Usage: $(basename "$0") [OPTIONS]" 1>&2
  echo "  -h                    - help"
  echo "  -u <CF_USER>          - CloudFoundry user             (required)"
  echo "  -p <CF_PASS>          - CloudFoundry password         (required)"
  echo "  -o <CF_ORG>           - CloudFoundry org              (required)" 
  echo "  -s <CF_SPACE>         - CloudFoundry space to target  (required)" 
  echo "  -a <CF_API_ENDPOINT>  - CloudFoundry API endpoint     (default: https://api.london.cloud.service.gov.uk)"
  echo "  -f                    - Force a deploy of a non standard branch to given environment"
  exit 1
}

SCRIPT_PATH="$( cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"

CF_API_ENDPOINT="https://api.london.cloud.service.gov.uk"

while getopts "a:u:p:o:s:h:f" opt; do
  case $opt in
    u)
      CF_USER=$OPTARG
      ;;
    p)
      CF_PASS=$OPTARG
      ;;
    o)
      CF_ORG=$OPTARG
      ;;
    s)
      CF_SPACE=$OPTARG
      ;;
    a)
      CF_API_ENDPOINT=$OPTARG
      ;;
    f)
      FORCE=yes
      ;;
    h)
      usage
      exit;;
    *)
      usage
      exit;;
  esac
done

# if required arguments are not passed exit with usage
if [[ -z "$CF_USER" || -z "$CF_PASS" || -z "$CF_ORG" || -z "$CF_SPACE" ]]; then
  echo "Some or all of the required parameters are empty";
  usage
fi

if [ ! -z ${TRAVIS_BRANCH+x} ]
then
 git checkout $TRAVIS_BRANCH
fi
BRANCH=$(git symbolic-ref --short HEAD)
echo "INFO: deploying $BRANCH to $CF_SPACE"
release_branch_re='\<release\>'
if [[ ! "$FORCE" == "yes" ]]
then

  if [[ "$CF_SPACE" == "development" ]]
  then
    if [[ ! "$BRANCH" == "develop" ]]
    then
      echo "We only deploy the 'develop' branch to $CF_SPACE"
      echo "if you want to deploy $BRANCH to $CF_SPACE use -f"
      exit 1
    fi
  fi

  if [[ "$CF_SPACE" == "sandbox" ]]
  then
    if [[ ! "$BRANCH" =~ "$release_branch_re" ]]
    then
      echo "We only deploy the 'preview' branch to $CF_SPACE"
      echo "if you want to deploy $BRANCH to $CF_SPACE use -f"
      exit 1
    fi
  fi
  
  if [[ "$CF_SPACE" == "prodouction" ]]
  then
    if [[ ! "$BRANCH" == "main" ]]
    then
      echo "We only deploy the 'master' branch to $CF_SPACE"
      echo "if you want to deploy $BRANCH to $CF_SPACE use -f"
      exit 1
    fi
  fi
fi

# environment variable(s) for manifest
MEMORY_LIMIT="768M"

cd "$SCRIPT_PATH" || exit

# login and target space
cf login -u "$CF_USER" -p "$CF_PASS" -o "$CF_ORG" -a "$CF_API_ENDPOINT" -s "$CF_SPACE"
cf target -o "$CF_ORG" -s "$CF_SPACE"

# generate manifest
sed "s/CF_SPACE/$CF_SPACE/g" manifest.yml | sed "s/MEMORY_LIMIT/$MEMORY_LIMIT/g" > "$CF_SPACE.manifest.yml"

# deploy
cd .. || exit

cf push ccs-conclave-document-upload -f CF/"$CF_SPACE".manifest.yml --strategy rolling