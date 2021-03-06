@echo off
REM --------------------------------------------------------------------------------
REM environment variable guide
REM --------------------------------------------------------------------------------
REM JAVA_HOME           - home directory of a valid JDK installation (1.6 or above)
REM PROJECT_HOME        - home directory of your project.
REM SENTRY_OUT          - the output directory
REM FIREFOX_BIN         - the full path of firefox.exe
REM SENTRY_RUNMODE      - determine screen capture image strategy (local or server)
REM --------------------------------------------------------------------------------

REM setlocal enableextensions enabledelayedexpansion
setlocal enableextensions


call :title "sentry runner"
if NOT ERRORLEVEL 0 goto :exit

call :checkJDK8
if NOT ERRORLEVEL 0 goto :exit


call :checkOS "Microsoft.Windows.10.Pro"
if NOT ERRORLEVEL 0 goto :exit

call :checkRAM 
if NOT ERRORLEVEL 0 goto :exit


call :convertGB "16"
if NOT ERRORLEVEL 0 goto :exit

call :checkInternetSpeed "150"
if NOT ERRORLEVEL 0 goto :exit

call :resolveEnv
if NOT ERRORLEVEL 0 goto :exit

REM set list=%JAVA% %JAVAVER% %Version% %RAM% %Average%
REM	(for %%a in (%list%) do ( 
REM	echo %%a 
REM	))


endlocal
exit /b 0
goto :eof

:checkJDK8
	.commons.cmd %*
	
:checkInternetSpeed
	.commons.cmd %*
		
:checkJava
	.commons.cmd %*
:convertGB
	.commons.cmd %*

:checkOS
	.commons.cmd %*

:checkRAM
	.commons.cmd %*
	
:title
	.commons.cmd %*

:resolveEnv
	.commons.cmd %*

:reportBadInputAndExit
	echo.
	echo ERROR: Required input not found.
	echo USAGE: %0 [project name] [optional: testcase id, testcase id, ...]
	echo
	echo
	goto :exit

:exit
	endlocal
	exit /b 1
