#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

if ! [[ "$0" =~ scripts/build.sh ]]; then
  echo "must be run from repository root"
  exit 255
fi

GOPATH="$(go env GOPATH)"

# apm root directory
APM_PATH=$( cd "$( dirname "${BASH_SOURCE[0]}" )"; cd .. && pwd )

# set default binary directory location
binary_directory="$GOPATH/src/github.com/ava-labs/apm/build"
name="apm"

if [[ $# -eq 1 ]]; then
    binary_directory=$1
elif [[ $# -eq 2 ]]; then
    binary_directory=$1
    name=$2
elif [[ $# -ne 0 ]]; then
    echo "Invalid arguments to build apm. Requires either no arguments (default) or one arguments to specify binary location."
    exit 1
fi

# Build apm, which is run as a subprocess
echo "Building $name in $binary_directory/$name"
go build -o "$binary_directory/$name" ./apm

mkdir -p ./build
go build -o ./build/apm ./apm
