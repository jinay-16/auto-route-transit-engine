@echo off
set SCRIPT_DIR=%~dp0
call "%SCRIPT_DIR%.maven\apache-maven-3.9.8\bin\mvn.cmd" %*
