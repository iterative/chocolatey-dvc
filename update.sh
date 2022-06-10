#!/bin/sh

set -e
set -x

LATEST=$1
if [ ! $LATEST ]; then
	LATEST=$(./latest.sh)
fi

PROJECT="iterative/dvc"
GHAPI_URL="https://api.github.com/repos/$PROJECT/releases/latest"
LATEST=$(curl --silent $GHAPI_URL | jq -r .tag_name)
TAR="dvc-$LATEST.tar.gz"
TAR_URL="https://pypi.io/packages/source/d/dvc/$TAR"

wget $TAR_URL
CHECKSUM=$(sha256sum $TAR | cut -d " " -f1)

sed -i 's/^\$version.*$/$version = '"'$LATEST'"'/g' tools/chocolateyinstall.ps1
sed -i 's/^\$checksum.*$/$checksum = '"'$CHECKSUM'"'/g' tools/chocolateyinstall.ps1
sed -i 's/<version>.*<\/version>/<version>'$LATEST'<\/version>/g' dvc.nuspec
