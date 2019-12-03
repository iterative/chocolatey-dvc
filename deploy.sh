#!/bin/bash

set -e
set -x

choco apikey --key $CHOCO_API_KEY --source https://push.chocolatey.org/
choco push dvc*.nupkg -y --force --source https://push.chocolatey.org/
