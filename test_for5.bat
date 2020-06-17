@Echo Off
SetLocal EnableDelayedExpansion

for /f "tokens=*" %%a in (tests_for5.txt) do (
    set /A problem = 0
	
	echo %%a
	
    %1 tests\%%a
	
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

echo errors detected > errors_for5.txt
for /f "tokens=*" %%a in (tests_for5.txt) do (

	fc results\%%a expected_results\%%a
	if not !errorlevel! == 0 (
		fc results\%%a expected_results\%%a >> errors_for5.txt
	)
)

call test.bat %1
call test_groupA.bat %1
call test_groupB.bat %1
call test_groupC.bat %1
type errors.txt >> errors_for5.txt
type errors_groupA.txt >> errors_for5.txt
type errors_groupB.txt >> errors_for5.txt
type errors_groupC.txt >> errors_for5.txt
errors_for5.txt