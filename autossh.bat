@echo off
set SSH_USER=%~1
set SSH_HOST=%~2
set LOCAL_PORT=%~3
set REMOTE_PORT=%~4
set SSH_PORT=%~5
set CLIENT_ALIVE_INTERVAL=%~6
set CLIENT_ALIVE_COUNT_MAX=%~7

if "%SSH_USER%"=="" echo Error: SSH_USER not provided. && goto :eof
if "%SSH_HOST%"=="" echo Error: SSH_HOST not provided. && goto :eof
if "%LOCAL_PORT%"=="" echo Error: LOCAL_PORT not provided. && goto :eof
if "%REMOTE_PORT%"=="" echo Error: REMOTE_PORT not provided. && goto :eof

if "%SSH_PORT%"=="" set SSH_PORT=22
if "%CLIENT_ALIVE_INTERVAL%"=="" set CLIENT_ALIVE_INTERVAL=60
if "%CLIENT_ALIVE_COUNT_MAX%"=="" set CLIENT_ALIVE_COUNT_MAX=10

set /a "MAX_TRIES=%CLIENT_ALIVE_COUNT_MAX%"
set /a "SLEEP_TIME=%CLIENT_ALIVE_INTERVAL% * %MAX_TRIES%"

:TUNNEL_LOOP
ssh -o ServerAliveInterval=%CLIENT_ALIVE_INTERVAL% -o ServerAliveCountMax=%CLIENT_ALIVE_COUNT_MAX% -p SSH_PORT -R %REMOTE_PORT%:localhost:%LOCAL_PORT% %SSH_USER%@%SSH_HOST%
echo Connection interrupted. Try restarting in %SLEEP_TIME% seconds...
timeout /t %SLEEP_TIME% /nobreak
goto TUNNEL_LOOP
