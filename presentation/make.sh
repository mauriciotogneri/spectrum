#!/usr/bin/env bash

set -e

BASE_DIR=`dirname $0`
INPUT="${BASE_DIR}/presentation.md"
OUTPUT="${BASE_DIR}/presentation.html"

npx @marp-team/marp-cli ${INPUT} -o ${OUTPUT}

google-chrome "${OUTPUT}"