Update-SessionEnvironment

$version = '2.8.3'
$url = "https://github.com/iterative/dvc/archive/$version.zip"
$checksum = '57debc34192a3fd7f6050592f14e88b5f15694207ce82d98406e0c3bfdf8a7e2'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$zipFile = "$toolsDir\dvc-$version.zip"
$projDir = "$toolsDir\dvc-$version"

Get-ChocolateyWebFile -PackageName 'dvc' -Url "$url" -FileFullPath "$zipFile" -ChecksumType sha256 -Checksum "$checksum"
Get-ChocolateyUnzip -FileFullPath "$zipFile" -Destination "$toolsDir"
Set-Location -Path "$projDir"
New-Item -Path "dvc\utils" -Name "build.py" -ItemType "file" -Value "PKG = 'choco'"
python -m pip install --upgrade pip
# NOTE: not installing pyarrow, as it doesn't have wheels for Windows Server 2012,
# see https://gist.github.com/choco-bot/d72732943836c947633625b1428a3f2c#file-install-txt-L1292
python -m pip install '.[gs,s3,azure,oss,ssh,gdrive]'
