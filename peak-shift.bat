@echo off
setlocal enabledelayedexpansion
set "peak_time=22-06"
set "peak_battery=10-30"
set "else_battery=90-100"

:parseArgs
:: asks for the -foo argument and store the value in the variable FOO
call:getArgWithValue "-peak-time" "peak_time" "%~1" "%~2" && shift && shift && goto :parseArgs
call:getArgWithValue "-peak-bat" "peak_battery" "%~1" "%~2" && shift && shift && goto :parseArgs
call:getArgWithValue "-else-bat" "else_battery" "%~1" "%~2" && shift && shift && goto :parseArgs
:: asks for the -bar argument and store the value in the variable BAR
:: call:getArgWithValue "-bar" "BAR" "%~1" "%~2" && shift && shift && goto :parseArgs
:: asks for the -flag argument. If exist set the variable FLAG to "TRUE"
:: call:getArgFlag "-flag" "FLAG" "%~1" && shift && goto :parseArgs

:: =====================================================================
:: This function sets a variable from a cli arg with value
:: 1 cli argument name
:: 2 variable name
:: 3 current Argument Name
:: 4 current Argument Value

echo Peaktime:"%peak_time%"
echo Battery will be: %peak_battery%
echo Else will be: %else_battery%

for /f "tokens=1* delims=-" %%a in ("%peak_time%") do (set "h=%%a:00"
set "h2=%%b:00")

for /f "tokens=1* delims=-" %%a in ("%else_battery%") do (set "else_min=%%a"
set "else_max=%%b"
)
for /f "tokens=1* delims=-" %%a in ("%peak_battery%") do (set "peak_min=%%a"
set "peak_max=%%b")

echo %h%
echo %h2%

set "currentTime=%Time: =0%"
echo %currentTime:~0,2%

echo %h:~0,2%
echo %h2:~0,2%

if %currentTime:~0,2% leq %h:~0,2% if %currentTime:~0,2% geq %h2:~0,2% (
echo We are not in the peak
echo "%~dp0ChargeThreshold.exe" on %else_max% %else_min%
CALL "%~dp0ChargeThreshold.exe" on %else_max% %else_min%
goto EXEC
)

set "h=%h2%"
echo We are in the peak
CALL "%~dp0ChargeThreshold.exe" on %peak_max% %peak_min%
goto EXEC

:EXEC
echo Next exection will be "%h%"

SCHTASKS /CREATE /F /SC DAILY /TN "peak-shifter\daily" /TR "%~dpnx0 -peak-time=%peak_time% -peak-bat=%peak_battery% -else-bat=%else_battery%"  /ST %h%
goto eof



:eof
pause
exit

:getArgWithValue
if "%~3"=="%~1" (
  if "%~4"=="" (
    REM unset the variable if value is not provided
    set "%~2="
    exit /B 1
  )
  set "%~2=%~4"
  exit /B 0
)
exit /B 1
goto:eof
:: =====================================================================
:: This function sets a variable to value "TRUE" from a cli "flag" argument
:: 1 cli argument name
:: 2 variable name
:: 3 current Argument Name
:getArgFlag
if "%~3"=="%~1" (
  set "%~2=TRUE"
  exit /B 0
)
exit /B 1
goto:eof
exit /b