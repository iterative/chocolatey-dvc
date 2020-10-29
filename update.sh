#!/bin/sh

set -e
set -x

LATEST=$1
if [ ! $LATEST ]; then
	LATEST=$(./latest.sh)
fi

GHAPI_URL="https://api.github.com/repos/iterative/dvc/releases/latest"
LATEST=$(curl --silent $GHAPI_URL | jq -r .tag_name)
ZIP="$LATEST.zip"
ZIP_URL="https://github.com/$PROJECT/archive/$ZIP"

wget $ZIP_URL
CHECKSUM=$(sha256sum $LATEST.zip | cut -d " " -f1)

sed -i 's/^\$version.*$/$version = '"'$LATEST'"'/g' tools/chocolateyinstall.ps1
sed -i 's/<version>.*<\/version>/<version>'$LATEST'<\/version>/g' dvc.nuspec

git add tools/chocolateyinstall.ps1 dvc.nuspec
git commit -m "dvc $LATEST"
