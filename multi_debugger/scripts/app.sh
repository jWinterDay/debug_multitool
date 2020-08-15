#!/bin/bash

ROOT=$PWD
FLUTTER_VERSION="1.21.0-7.0.pre"
RED_COLOR='\033[0;31m'
GREEN_COLOR='\033[0;32m'
YELLOW_COLOR='\033[1;33m'
ORANGE_COLOR='\033[0;33m'
NO_COLOR='\033[0m'

function checking_flutter_version {
  cd $(dirname $(which flutter)) && cd ..

  flutter_version=$(cat version)
  printf "${ORANGE_COLOR}flutter version: ${GREEN_COLOR}$flutter_version${NO_COLOR}\n"
  # if ! [[ $flutter_version == $FLUTTER_VERSION ]]; then
  #   printf "${RED_COLOR}wrong flutter version ($flutter_version). Version must be: $FLUTTER_VERSION${NO_COLOR}\n"
  #   exit 1;
  # fi
  cd $ROOT
}

function creating_local_settings {
  if ! [[ -f "application_bundle/local_settings.json" ]]; then
    cp -f "$ROOT/application_bundle/default_local_settings.json" $ROOT/application_bundle/local_settings.json
    printf "${ORANGE_COLOR}created local settings ${NO_COLOR}\n"
  fi
}


# call functions
checking_flutter_version;
creating_local_settings;