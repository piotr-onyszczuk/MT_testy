@Echo Off
SetLocal EnableDelayedExpansion

for /f "tokens=*" %%a in (tests_groupA.txt) do (
    set /A problem = 0
	
    %1 tests\%%a
	
    if !errorlevel! == 0 (
		ilasm tests\%%a.il
		if !errorlevel! == 0 (
			peverify tests\%%a.exe 
			if !%errorlevel! == 0 (
				tests\%%a.exe > results\%%a
			) else (
				set /A problem = 1
			)
		) else (
			set /A problem = 1
		)
	) else (
		set /A problem = 1
	)
	
	if !problem! == 1 (
		echo error> results\%%a
	)
)

echo errors detected > errors_groupA.txt
for /f "tokens=*" %%a in (tests_groupA.txt) do (

	fc results\%%a expected_results\%%a
	if not !errorlevel! == 0 (
		fc results\%%a expected_results\%%a >> errors_groupA.txt
	)
)
