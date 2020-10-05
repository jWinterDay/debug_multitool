#!/bin/bash

RUN_TYPE=$1
ROOT=$PWD

FILES_REGEX="(.dart|.g.dart//*)"

source scripts/constants.sh

function format {
  flutter format -l 120 lib

  killall dart -9
}

# EXPERIMENTAL
if [[ "$RUN_TYPE" == "e" ]]; then
  printf "${ORANGE_COLOR}try to rebuild by git hist ${NO_COLOR}\n"

  changedFiles=$(git status -sbv)
  result="include: [" #\"$package$\", \"lib/$lib$\" "
  index=0
  for f in $changedFiles
  do
    if [[ "$f" =~ $FILES_REGEX ]]; then
      if [[ $index == 0 ]]; then
        result+="\"$f\"";
      else
        result+=",\"$f\"";
      fi

      index=$(($index + 1))
    fi
  done
  result+="]"

  sed -i '' "s@#include:#@$result@" $ROOT/build.yaml

  # flutter packages pub run build_runner build --delete-conflicting-outputs

  # format;
  exit 0;
fi

flutter packages pub run build_runner build --delete-conflicting-outputs
format;