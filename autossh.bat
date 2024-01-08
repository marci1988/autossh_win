@echo off
set SSH_USER=%~1
set SSH_HOST=%~2
set LOCAL_PORT=%~3
set REMOTE_PORT=%~4
set CLIENT_ALIVE_INTERVAL=%~5
set CLIENT_ALIVE_COUNT_MAX=%~6

if "%SSH_USER%"=="" set SSH_USER=root
if "%SSH_HOST%"=="" set SSH_HOST=127.0.0.1
if "%LOCAL_PORT%"=="" set LOCAL_PORT=3389
if "%REMOTE_PORT%"=="" set REMOTE_PORT=3389
if "%CLIENT_ALIVE_INTERVAL%"=="" set CLIENT_ALIVE_INTERVAL=60
if "%CLIENT_ALIVE_COUNT_MAX%"=="" set CLIENT_ALIVE_COUNT_MAX=10

set /a "MAX_TRIES=%CLIENT_ALIVE_COUNT_MAX%"
set /a "SLEEP_TIME=%CLIENT_ALIVE_INTERVAL% * %MAX_TRIES%"

:SSH_LOOP
ssh -o ServerAliveInterval=%CLIENT_ALIVE_INTERVAL% -o ServerAliveCountMax=%CLIENT_ALIVE_COUNT_MAX% -p 1337 -R %REMOTE_PORT%:localhost:%LOCAL_PORT% %SSH_USER%@%SSH_HOST%
echo Verbindung abgebrochen. Versuche Neustart in %SLEEP_TIME% Sekunden...
timeout /t %SLEEP_TIME% /nobreak
goto SSH_LOOP
 