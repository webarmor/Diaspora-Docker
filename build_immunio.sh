#!/bin/bash

echo "1" | scripts/build.sh
echo "5" | scripts/build.sh
docker build -t immunio/diaspora immunio/

