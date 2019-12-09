$ErrorActionPreference = 'Stop';

Update-SessionEnvironment

$version = '0.70.0'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$proxy = Get-EffectiveProxy
if ($proxy) {
  Write-Host "Setting CLI proxy: $proxy"
  $env:http_proxy = $env:https_proxy = $proxy
}

Write-Host "Downloading zip"
Get-ChocolateyWebFile -PackageName 'dvc' -Url "https://github.com/iterative/dvc/archive/$version.zip" -FileFullPath "$toolsDir\dvc-$version.zip"

Write-Host "Unpacking zip"
Get-ChocolateyUnzip -FileFullPath "$toolsDir\dvc-$version.zip" -Destination "$toolsDir"

Write-Host "Listing dir"
dir "$toolsDir\dvc-$version"

Write-Host "Changing dir"
Set-Location -Path "$toolsDir\dvc-$version"

Write-Host "Creating build.py"
New-Item -Path "dvc\utils" -Name "build.py" -ItemType "file" -Value "PKG = 'choco'"

Write-Host "Installing from pip"
python -m pip install .[all]
