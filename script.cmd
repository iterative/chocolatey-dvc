echo on
call choco install python --version 3.7.4 || goto :error
call refreshenv || goto :error
call python --version || goto :error
call choco pack -v || goto :error
call choco install dvc -dv -s . || goto :error
call dvc version || goto :error
call choco uninstall dvc || goto :error
call choco apikey --key %CHOCO_API_KEY% --source https://push.chocolatey.org/ || goto :error
for %%pkg in (dvc*.nupkg) do (call choco push %%pkg -y --force --source https://push.chocolatey.org/)
echo ====== DONE ======
goto :EOF

:error
echo ====== FAIL ======
exit /b 1
