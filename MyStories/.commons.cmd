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
	echo "title %~1 Command Prompt"



	
:checkJDK8
	for /f "tokens=2-3" %%i in ('java -version 2^>^&1 ^| findstr /i "version recognized"')do (
	    set JAVAVER=%%j
		set version=%%i
	)
	
	if "%version%" NEQ "version" (
		echo Java is not installed
		set JDK8=NOT OK
		goto :eof
	)
	set JAVAVER=%JAVAVER:"=%
	SET _result=%JAVAVER:~0,3%
	
	if %_result% GEQ 1.8 (
		set JDK8=OK
	) else (
		set JDK8=NOT OK
	)

	goto :eof
	



:checkOS
	for /f "tokens=3-7" %%i in ('systeminfo 2^>^&1 ^| findstr /B /C:"OS Name"') do (
				set Vers=%%i.%%j.%%k.%%l
				
	)
	for /f "tokens=2,3 delims=." %%i in ("%Vers%") do (
		
		
		if "%%i"=="Windows" (
			
			if "%%j"=="10" ( 
				set OS="success"
			) else (
				set OS="failure"
			)
		) else (
			set OS="failure"
		
		)
		
	)
	
	
	goto :eof

:checkRAM
	for /f "tokens=1" %%i in ('wmic MEMORYCHIP get Capacity') do (
		if "%%i"=="Capacity" (
			echo " "
		) else (
			set capacity=%%i
			goto :eof
				
		)
	)
	
:convertGB

			
		
		SET /a _result=%capacity:~0,-3%
		set /a _digits=%capacity:~-3%
		set /a int=%_result%/1024
		set /a int=%int%*1000+%_digits%+1000
		set /a int=%int%/1024/1024
		if %int% GEQ %~1 (
				set RAM=OK
			) else (
				set RAM=NOT OK
			)
		goto :eof



:checkInternetSpeed
	for /f "tokens=3,6,9" %%i in ('ping google.com 2^>^&1 ^| findstr /i "maximum try"')do (
		set SPEED=%%i.%%j.%%k 
	)
	
	
	for /f "delims=., tokens=1-3" %%v in ("%SPEED%") do (
 		set minimum= %%v
	    set maximum= %%w
	    set average= %%x
	)
	if %average%==check (
		echo true
		set InternetConnection=Not OK
		goto :eof
		
	)
	
	set /a avg=%average:~0,-3%
	set InternetConnection=OK
	
	if %avg% LEQ %~1 (
		set InternetSpeed=OK
	) else (
		set InternetSpeed=NOT OK
	)	
	
	goto :eof

	

:resolveEnv
	echo ENVIRONMENT:
	echo   CURRENT USER:   %USERNAME%
	echo   CURRENT HOST:   %COMPUTERNAME%
	echo   JAVA VERSION:   %JAVAVER%
	echo   OS VERSION:     %Vers%
	
	
	echo -----------------------------------
	
	
	echo JDK8 Status:  		   %JDK8%
	echo OS STATUS: 	%OS%
	echo   RAM STATUS:  %RAM%
	echo InternetConnection status: %InternetConnection%
	echo Speed STATUS: 		   %InternetSpeed%
	goto :eof


:testErrorlevel
    echo testErrorlevel
    exit /b 1
