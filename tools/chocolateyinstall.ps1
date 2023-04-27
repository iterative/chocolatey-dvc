Update-SessionEnvironment

Set-PSDebug -Trace 1
$ErrorActionPreference = "Stop"

$version = '2.55.0'
$url = "https://pypi.io/packages/source/d/dvc/dvc-$version.tar.gz"
$checksum = '3ee239ae1e946fe1ac8999fc829ccb570e03c248938e5b8235f5647cf1dce806'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$tarFile = "$toolsDir\dvc-$version.tar"
$targzFile = "$tarFile.gz"
$projDir = "$toolsDir\dvc-$version"

Get-ChocolateyWebFile -PackageName 'dvc' -Url "$url" -FileFullPath "$targzFile" -ChecksumType sha256 -Checksum "$checksum"
Get-ChocolateyUnzip -FileFullPath "$targzFile" -Destination "$toolsDir"
if (Test-Path "$tarFile") {
  # workaround for https://github.com/chocolatey/choco/pull/1026
  # inspired by https://github.com/chocolatey-community/chocolatey-packages/blob/d00d111cdc6e638146359073417f9c1d57f8da84/automatic/kubernetes-cli/tools/chocolateyInstall.ps1#L15
  Get-ChocolateyUnzip -FileFullPath "$tarFile" -Destination "$toolsDir"
  Remove-Item "$tarFile"
}

Get-ChildItem -Path "$toolsDir" -Depth 2
Set-Location -Path "$projDir"
New-Item -Path "dvc\utils" -Name "build.py" -ItemType "file" -Value "PKG = 'choco'"
python -m pip install --upgrade pip
# NOTE: not installing pyarrow, as it doesn't have wheels for Windows Server 2012,
# see https://gist.github.com/choco-bot/d72732943836c947633625b1428a3f2c#file-install-txt-L1292
python -m pip install ".[gs,s3,azure,oss,ssh,gdrive]"
