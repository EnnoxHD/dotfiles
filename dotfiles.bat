@echo off
chcp 1252 2>&1>nul
rem ===========================================================================================
rem uses the configuration file to set symlinks on the system pointing to the provided dotfiles
rem ===========================================================================================
setlocal enableextensions enabledelayedexpansion
set "demofile=%%userprofile%%\test"
goto :end
set "config=%~dp0dotfiles.config"
call set "config=%config%"
if not exist !config! (
	echo E: configuration file "!config!" not found
	goto :end
) else (
	set "configf=!config!\\"
	call set "configf=!configf!"
	echo !configf!
	if exist !configf! (
		echo E: configuration file "!config!" not found
		goto :end
	)
	echo I: reading configuration file "!config!"
)
set /a line = 1
for /f "tokens=1,2 delims==" %%a in (!config!) do (
	if not "%%a" == "" (
		set "ax=%%a"
		if "!ax:~0,1!" == "#" (
			echo I^(!line!^): skipping comment
		) else (
			call set "ax=!ax!"
			if not "%%b" == "" (
				set "bx=%%b"
				call set "bx=!bx!"
				if "%%a" == " " (
					if exist !bx! (
						echo I^(!line!^): deleting "!bx!"
						del !bx!
					) else (
						echo I^(!line!^): skipping deletion, file "!bx!" does not exist
					)
				) else (
					echo I^(!line!^): configured correct
					if exist !ax! (
						echo.
					) else (
						echo W^(!line!^): skipping due to misconfiguration, source not found
					)
				)
			) else (
				echo W^(!line!^): skipping due to misconfiguration
			)
		)
	) else (
		echo W^(!line!^): skipping due to misconfiguration
	)
	set /a line += 1
)
:end
endlocal
echo.
pause
exit /b 0

rem +---------------------------------------------------------------------------------------------------+
rem |    function name: exists                                                                          |
rem |      description: Expands and normalizes a given path and analyzes if it is a file or folder.     |
rem |    parameter %~1: any_path            -> a path to expand, normalize and proof existance and type |
rem | return value %~2: ret_type            -> 0 - nothing, 1 - file, 2 - folder                        |
rem | return value %~3: ret_normalized_path -> expanded and normalized path (1, 2) or space (0)         |
rem +---------------------------------------------------------------------------------------------------+
:exists
setlocal
set "any_path=%~1"
set /a "ret_type=0"
set "ret_normalized_path= "
rem code here
endlocal&set "%~2=%ret_type%"&set "%~3=%ret_normalized_path%"&exit /b 0
