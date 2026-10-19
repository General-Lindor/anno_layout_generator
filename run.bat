@echo off

:: start the server in a new process so that the next commands can run async
start "" npx http-server --cors --port 8080

:: we want to wait until the local server is running before we run the web tool

:: setup vars for testing the server
setlocal enabledelayedexpansion
set "IP=127.0.0.1"
set "PORT=8080"
set /A "TRY=0"

:loop

:: use powershell to test
set /A TRY=%TRY%+1
powershell -Command "$t = Test-NetConnection -ComputerName !IP! -Port !PORT! -WarningAction SilentlyContinue; if ($t.TcpTestSucceeded) { exit 0 } else { exit 1 }" >nul 2>&1

if not !errorlevel! equ 0 (
	:: Only allow three tries
	if %TRY% lss 3 (
		goto loop
	) else (
		echo "ERROR: Couldn't find the server. Exiting..."
		timeout /t 5
		exit /b 1
	)
)

:: the local server is running; start running the web tool
start /max http://localhost:8080/generator.html

