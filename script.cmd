echo on
call choco install python --version 3.7.4 || goto :error
call refreshenv || goto :error
call python --version || goto :error
call choco pack -v || goto :error
call choco install dvc -dv -s . || goto :error
call dvc version || goto :error
call choco uninstall dvc || goto :error
call choco apikey --key %CHOCO_API_KEY% --source https://push.chocolatey.org/ || goto :error
call dir
call choco push dvc.0.70.0.nupkg --source https://push.chocolatey.org/ || goto :error
echo ====== DONE ======
goto :EOF

:error
echo ====== FAIL ======
exit /b 1
