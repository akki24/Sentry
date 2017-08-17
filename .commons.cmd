@echo off
    setlocal enableextensions

    rem Not to be directly called
    exit /b 9009


:title
	echo.
	echo --------------------------------------------------------------------------------
	echo ^|                        sentry - test automation for all                      ^|
	echo --------------------------------------------------------------------------------
	echo [:: %~1
	echo --------------------------------------------------------------------------------
	echo.
	goto :eof



	
:checkJDK8
	for /f "tokens=3" %%g in ('java -version 2^>^&1 ^| findstr /i "version"')do (
	    @echo Output: %%g
	    set JAVAVER=%%g
	)

	set JAVAVER=%JAVAVER:"=%
	
	if "%JAVAVER%"=="1.8.0_131" (
		echo java is installed
		set  JDK8="success"
	) else (
	     	echo ERROR!!!
		echo JAVA 8 is not installed on your system
		set JDK8="failure"
	)

	goto :eof
	



:checkOS
	for /f "tokens=1-4" %%i in ('ver') do set Version=%%i.%%j.%%k.%%l
	
	for /f "tokens=2 delims=." %%i in ("%Version%") do (
		if "%%i"=="Windows" (
			set OS="success"
		) else (
			set OS="failure"
		)
		
	)
	goto :eof

:checkRAM
	for /f "tokens=1" %%i in ('wmic MEMORYCHIP get Capacity') do (
		if "%%i"=="Capacity" (
			echo .
		) else (
			set RAM=%%i
			if %~1 LEQ "%RAM%" (
				set RAMCAPACITY="success"
			) else (
				set RAMCAPACITY="failure"
	
			)
			goto :eof
		)
	)
	





:checkInternetSpeed
	for /f "tokens=3,6,9" %%i in ('ping google.com 2^>^&1 ^| findstr /i "maximum"')do (
		set SPEED=%%i.%%j.%%k 
	)
	for /f "delims=., tokens=1-3" %%v in ("%SPEED%") do (
 		set minimum= %%v
	    	set maximum= %%w
	    	set average= %%x
	)
	if %average% LEQ 200ms (
		set SpeedRate="success"
	) else (
		set SpeedRate="failure"
	)	
	goto :eof

	

:resolveEnv
	echo ENVIRONMENT:
	echo   CURRENT USER:   %USERNAME%
	echo   CURRENT HOST:   %COMPUTERNAME%
	echo   JAVA:           %JAVA%
	echo   JAVA VERSION:   %JAVAVER%
	echo   OS Version:		%Version%
	echo   RAM:			%RAM%
	echo   SPEED:			%SPEED%
	echo For 32 bytes--- Minimum speed:%minimum% Maximum:%maximum% Average:%average%

	echo JDK8:  %JDK8%
	echo OS:  %OS%
	echo RAMCAPA: %RAMCAPACITY%
	echo Speed: %SpeedRate%

	goto :eof


:testErrorlevel
    echo testErrorlevel
    exit /b 1
