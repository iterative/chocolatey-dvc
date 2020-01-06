Update-SessionEnvironment

$version = '0.70.0'
$url = "https://github.com/iterative/dvc/archive/$version.zip"
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$zipFile = "$toolsDir\dvc-$version.zip"
$projDir = "$toolsDir\dvc-$version"

$proxy = Get-EffectiveProxy
if ($proxy) {
  Write-Host "Setting CLI proxy: $proxy"
  $env:http_proxy = $env:https_proxy = $proxy
}

Get-ChocolateyWebFile -PackageName 'dvc' -Url "$url" -FileFullPath "$zipFile"
Get-ChocolateyUnzip -FileFullPath "$zipFile" -Destination "$toolsDir"
Set-Location -Path "$projDir"
New-Item -Path "dvc\utils" -Name "build.py" -ItemType "file" -Value "PKG = 'choco'"
python -m pip install '.[all]'
python -m dvc version
