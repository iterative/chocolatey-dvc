@echo on
call choco pack -v || goto :error
call choco install dvc -dv -s . || goto :error
call dvc version || goto :error
call choco uninstall dvc || goto :error
echo ====== DONE ======
goto :EOF

:error
echo ====== FAIL ======
exit /b 1
