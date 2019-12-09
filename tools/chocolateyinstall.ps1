$ErrorActionPreference = 'Stop';

Update-SessionEnvironment

$version = '0.70.0'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$proxy = Get-EffectiveProxy
if ($proxy) {
  Write-Host "Setting CLI proxy: $proxy"
  $env:http_proxy = $env:https_proxy = $proxy
}

Get-ChocolateyWebFile -PackageName 'dvc' -Url "https://github.com/iterative/dvc/archive/$version.zip" -FileFullPath "$toolsDir\dvc-$version.zip"

Get-ChocolateyUnzip -FileFullPath "$toolsDir\dvc-$version.zip" -Destination "$toolsDir"

Set-Location -Path "dvc-$version"

New-Item -Path "dvc\utils" -Name "build.py" -ItemType "file" -Value "PKG = 'choco'"

python -m pip install .[all]
