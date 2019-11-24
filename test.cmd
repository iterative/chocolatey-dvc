call choco install python || goto :error
call refreshenv || goto :error
call python --version || goto :error
call choco pack -v || goto :error
call choco install dvc -dv -s . || goto :error
call python -m dvc version || goto :error
call dvc version || goto :error
call choco uninstall dvc || goto :error

echo ====== DONE ======
goto :EOF

:error
echo ====== FAIL ======
exit /b 1
