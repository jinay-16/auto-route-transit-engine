@echo off
echo =========================================================================
echo   Starting AutoRoute Full-Stack Transit Platform (Java 21 + Spring Boot)
echo =========================================================================
echo.
cd /d "%~dp0"
call mvnw.cmd spring-boot:run
pause
