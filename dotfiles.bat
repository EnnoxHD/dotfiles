@echo off
chcp 1252 2>&1>nul
for /f "tokens=1,2 delims==" %%a in (dotfiles.config) do echo %%a %%b
pause
