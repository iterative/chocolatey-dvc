$ErrorActionPreference = 'Stop';

Update-SessionEnvironment

$version = '0.70.0'

$proxy = Get-EffectiveProxy
if ($proxy) {
  Write-Host "Setting CLI proxy: $proxy"
  $env:http_proxy = $env:https_proxy = $proxy
}

$client = New-Object System.Net.WebClient
try
{
  $client.DownloadFile("https://github.com/iterative/dvc/archive/$version.zip", "dvc-$version.zip")
}
finally
{
  $client.Dispose()
}

Expand-Archive "dvc-$version.zip"

dir

Set-Location -Path "dvc-$version"

dir

New-Item dvc\utils\build.py
Set-Content dvc\utils\build.py "PKG = 'choco'"

python -m pip install .[all]
