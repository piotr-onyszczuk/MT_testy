@Echo Off
SetLocal EnableDelayedExpansion

for /f "tokens=*" %%a in (tests_groupB.txt) do (
    set /A problem = 0
	
    %1 tests\%%a
	
	echo %%a
    if !errorlevel! == 0 (
		ilasm tests\%%a.il
		if !errorlevel! == 0 (
			peverify tests\%%a.exe 
			if !%errorlevel! == 0 (
				if exist inputs\%%a (
					tests\%%a.exe < inputs\%%a > results\%%a
				) else (
					tests\%%a.exe > results\%%a
				)
				if NOT !%errorlevel! == 0 (
					set /A problem = 2
					)
			) else (
				set /A problem = 2
			)
		) else (
			set /A problem = 2
		)
	) else (
		set /A problem = 1
	)
	
	if !problem! == 1 (
		echo error> results\%%a
	)
	if !problem! == 2 (
		echo critical_error> results\%%a
	)
)

echo errors detected > errors_groupB.txt
for /f "tokens=*" %%a in (tests_groupB.txt) do (

	fc results\%%a expected_results\%%a
	if not !errorlevel! == 0 (
		fc results\%%a expected_results\%%a >> errors_groupB.txt
	)
)
