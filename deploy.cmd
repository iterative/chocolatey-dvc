@echo on
call choco apikey --key %CHOCO_API_KEY% --source https://push.chocolatey.org/ || goto :error
REM push might return non-zero return code if we are re-pushing existing package version
call choco push dvc*.nupkg -y --force --source https://push.chocolatey.org/
echo ====== DONE ======
goto :EOF

:error
echo ====== FAIL ======
exit /b 1
