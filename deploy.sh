set -e
set -x

choco apikey --key $CHOCO_API_KEY --source https://push.chocolatey.org/
#push might return non-zero return code if we are re-pushing existing package version
choco push dvc*.nupkg -y --force --source https://push.chocolatey.org/ || true
