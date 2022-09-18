@echo off
chcp 1252>&nul
copy .\gitconfig %USERPROFILE%\.gitconfig
copy .\minttyrc %USERPROFILE%\.minttyrc
