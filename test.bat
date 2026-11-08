@echo off
echo =========================================================================
echo   Executing AutoRoute Test Suite (JUnit 5 + Concurrency Tests)
echo =========================================================================
echo.
cd /d "%~dp0"
call mvnw.cmd clean test
pause
