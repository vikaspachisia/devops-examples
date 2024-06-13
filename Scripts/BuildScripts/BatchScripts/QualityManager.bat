@ECHO OFF

@REM ******************** [BEGIN] MAIN **************************************
@REM ------------------------------------------------------------------------
:module
setlocal EnableDelayedExpansion

if not defined QM_CMD_DEBUG_LEVEL (set QM_CMD_DEBUG_LEVEL=%CMD_DEBUG_LEVEL%)
if not defined DO_NOT_RESET_ERRORLEVEL (set ERRORLEVEL=0)

call :main %*

set QM_CMD_DEBUG_LEVEL=

endlocal
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:main
if "%QM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][main][begin]: %*

call :initialize

if ERRORLEVEL 0 (call :parse_commandline_args %*)
if ERRORLEVEL 0 (call :validate_commands)
if ERRORLEVEL 0 (call :validate_parameters)
if ERRORLEVEL 0 (call :execute_commands)

call :uninitialize

if "%QM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][main][end]: result %ERRORLEVEL%
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:initialize
if "%QM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][initialize][begin]: %*

if "%CMD_DEBUG_LEVEL%" GEQ "4" @set

call :initialize_environment
call :initialize_enums
call :initialize_commands
call :initialize_parameters
call :initialize_variables

if "%QM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][initialize][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:uninitialize
if "%QM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][uninitialize][begin]: %*

if "%CMD_DEBUG_LEVEL%" GEQ "4" @set

call :uninitialize_variables
call :uninitialize_parameters
call :uninitialize_commands
call :uninitialize_enums
call :uninitialize_environment

if "%QM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][uninitialize][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:initialize_environment
if "%QM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][initialize_environment][begin]: %*

set THIS_WINDOW_CURRENT_TITLE=Command Prompt %~nx0
REM for /f "usebackq delims=" %%t in (`powershell -noprofile -c "[Console]::Title.Replace(' - '+[Environment]::CommandLine,'')"`) do set THIS_WINDOW_CURRENT_TITLE=%%t
@TITLE Quality Manager

if "%QM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][initialize_environment][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:uninitialize_environment
if "%QM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][uninitialize_environment][begin]: %*

@TITLE %THIS_WINDOW_CURRENT_TITLE%
set THIS_WINDOW_CURRENT_TITLE=

if "%QM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][uninitialize_environment][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:initialize_enums
if "%QM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][initialize_enums][begin]: %*

REM NOOP

if "%QM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][initialize_enums][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:uninitialize_enums
if "%QM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][uninitialize_enums][begin]: %*

REM NOOP

if "%QM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][uninitialize_enums][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:initialize_commands
if "%QM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][initialize_commands][begin]: %*

set QM_CMD_HELP=0
set QM_CMD_ANALYZE=0
set QM_CMD_TEST=0

if "%QM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][initialize_commands][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:uninitialize_commands
if "%QM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][uninitialize_commands][begin]: %*

set QM_CMD_HELP=
set QM_CMD_ANALYZE=
set QM_CMD_TEST=

if "%QM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][uninitialize_commands][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:initialize_parameters
if "%QM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][initialize_parameters][begin]: %*

set QM_PARAM_SOLUTION_FILEPATH=..\..\..\devops-examples.sln
set QM_PARAM_VERSION_FILEPATH=..\..\..\shared\common\version.h
set QM_PARAM_COVERITY_FILENAME=RealProtect.cov
set QM_PARAM_COVERITY_LOGFILENAME=%QM_PARAM_COVERITY_FILENAME%.log
set QM_PARAM_REPORTDIR_PATH=..\..\outputs\reportfiles
set QM_PARAM_BLDDIR_PATH=..\..\outputs\builtfiles
set QM_PARAM_SAMPLESDIR_PATH=..\..\outputs\samplefiles

set QM_PARAM_PRODUCT_NAME=DevopsExamples
set QM_PARAM_PRODUCT_ID=1
set QM_PARAM_TARGET_CONFIGURATIONS=Release
set QM_PARAM_TARGET_ARCHITECTURES=x64

if "%QM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][initialize_parameters][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:uninitialize_parameters
if "%QM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][uninitialize_parameters][begin]: %*

set QM_PARAM_SOLUTION_FILEPATH=
set QM_PARAM_VERSION_FILEPATH=
set QM_PARAM_COVERITY_FILENAME=
set QM_PARAM_COVERITY_LOGFILENAME=
set QM_PARAM_REPORTDIR_PATH=
set QM_PARAM_BLDDIR_PATH=
set QM_PARAM_SAMPLESDIR_PATH=
set QM_PARAM_PRODUCT_NAME=
set QM_PARAM_PRODUCT_ID=
set QM_PARAM_TARGET_CONFIGURATIONS=
set QM_PARAM_TARGET_ARCHITECTURES=

if "%QM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][uninitialize_parameters][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:initialize_variables
if "%QM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][initialize_variables][begin]: %*

set QM_VARS_COMMAND_VALID=0
set QM_VARS_COMMAND_PARAMS_VALID=0

set QM_VARS_VERSION_STRING=*.*.*.0
set QM_VARS_VERSION_STRING_PARTS=* * * 0

if "%QM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][initialize_variables][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:uninitialize_variables
if "%QM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][uninitialize_variables][begin]: %*

set QM_VARS_COMMAND_VALID=
set QM_VARS_COMMAND_PARAMS_VALID=

set QM_VARS_VERSION_STRING=
set QM_VARS_VERSION_STRING_PARTS=

if "%QM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][uninitialize_variables][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------
@REM ******************** [END] MAIN ****************************************


@REM ******************** [BEGIN] COMMAND MANAGEMENT ************************
@REM ------------------------------------------------------------------------
:parse_commandline_args
if "%QM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][parse_commandline_args][begin]: %*

call ArgumentManager.bat /set_environment %*
call :parse_commandline_arg %*
call ArgumentManager.bat /reset_environment

if "%QM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][parse_commandline_args][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:parse_commandline_arg
if "%QM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][parse_commandline_arg][begin]: %*

call :parse_commands %*
call :parse_parameters %*
call :parse_variables %*

if "%QM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][parse_commandline_arg][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:parse_commands
if "%QM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][parse_commands][begin]: %*

set QM_CMD_HELP=%AM_ENV_CMD_HELP%
set QM_CMD_ANALYZE=%AM_ENV_CMD_ANALYZE%
set QM_CMD_TEST=%AM_ENV_CMD_TEST%

if "%QM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][parse_commands][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:parse_parameters
if "%QM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][parse_parameters][begin]: %*

set QM_PARAM_SOLUTION_FILEPATH=%AM_ENV_SOURCES_PATH%\%AM_ENV_SOURCE_SOLUTION_FILENAME%
set QM_PARAM_VERSION_FILEPATH=%AM_ENV_SHARED_COMMON_PATH%\%AM_ENV_SOURCE_VERSION_FILENAME%
set QM_PARAM_COVERITY_FILENAME=%AM_ENV_QUALITY_COVERITY_FILENAME%
set QM_PARAM_COVERITY_LOGFILENAME=%AM_ENV_QUALITY_COVERITY_LOGFILENAME%
set QM_PARAM_REPORTDIR_PATH=%AM_ENV_RPTDIR_PATH%
set QM_PARAM_BLDDIR_PATH=%AM_ENV_BLDDIR_PATH%
set QM_PARAM_SAMPLESDIR_PATH=%AM_ENV_SAMPLESDIR_PATH%
set QM_PARAM_PRODUCT_NAME=%AM_ENV_PRODUCT_NAME%
set QM_PARAM_PRODUCT_ID=%AM_ENV_PRODUCT_ID%
set QM_PARAM_TARGET_CONFIGURATIONS=%AM_ENV_TARGET_CONFIGURATIONS%
set QM_PARAM_TARGET_ARCHITECTURES=%AM_ENV_TARGET_ARCHITECTURES%

if "%QM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][parse_parameters][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:parse_variables
if "%QM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][parse_variables][begin]: %*

set __vm_cmd_debug_level=%VM_CMD_DEBUG_LEVEL%
set VM_CMD_DEBUG_LEVEL=0
for /f "useback delims=*" %%v in (`VersionManager /get_version /filepath^=%QM_PARAM_VERSION_FILEPATH%`) do (set QM_VARS_VERSION_STRING=%%v)
for /f "useback delims=*" %%v in (`VersionManager /get_version_parts /version^=%QM_VARS_VERSION_STRING%`) do (set QM_VARS_VERSION_STRING_PARTS=%%v)
set VM_CMD_DEBUG_LEVEL=%__vm_cmd_debug_level%

if "%QM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][parse_variables][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:validate_commands
if "%QM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][validate_commands][begin]: %*

set /A __local_cmd_count=0

if "%QM_CMD_HELP%"=="1" (set /A __local_cmd_count+=1)
if "%QM_CMD_ANALYZE%"=="1" (set /A __local_cmd_count+=1)
if "%QM_CMD_TEST%"=="1" (set /A __local_cmd_count+=1)

if "%__local_cmd_count%" NEQ "1" (
   if "%QM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [ERROR\%~nx0][validate_commands]: cannot identify the command to run. command count=%__local_cmd_count%
   set __local_cmd_count=
   set QM_VARS_COMMAND_VALID=0
   exit /B 22
) else (
    set QM_VARS_COMMAND_VALID=1
)

set __local_cmd_count=

if "%QM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][validate_commands][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:validate_parameters
if "%QM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][validate_parameters][begin]: %*

set /A __local_param_valid=1
set /A __validate_solution_filepath=0

if "%QM_CMD_ANALYZE%"=="1" (set __validate_solution_filepath=1)
if "%QM_CMD_TEST%"=="1" (set __validate_solution_filepath=1)

if "%__validate_solution_filepath%"=="1" (
     if not exist "%QM_PARAM_SOLUTION_FILEPATH%" (
        set __local_param_valid=0
        if "%QM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [ERROR\%~nx0][validate_parameters]: cannot find '%QM_PARAM_SOLUTION_FILEPATH%'.
    )
)

if "%AM_VARS_ENUM_PARAMS_VALID%"=="0" (
    set __local_param_valid=0
)

if "%__local_param_valid%" NEQ "1" (
   if "%QM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [ERROR\%~nx0][validate_parameters]: cannot find the parameters for the command to run.
   set __local_param_valid=
   set QM_VARS_COMMAND_PARAMS_VALID=0
   exit /B 87
) else (
    set QM_VARS_COMMAND_PARAMS_VALID=1
)

set __local_param_valid=

if "%QM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][validate_parameters][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:execute_commands
if "%QM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][execute_commands][begin]: %*

set /A __local_cmd_count=0

if !QM_VARS_COMMAND_VALID! EQU 1 (
    if !QM_VARS_COMMAND_PARAMS_VALID! EQU 1 (
        if "%QM_CMD_HELP%"=="1" (set /A __local_cmd_count+=1 & call :print_help)
        if "%QM_CMD_ANALYZE%"=="1" (set /A __local_cmd_count+=1 & call :analyze_targets)
        if "%QM_CMD_TEST%"=="1" (set /A __local_cmd_count+=1 & call :test_targets)
    ) else (
        if "%QM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [ERROR\%~nx0][execute_commands]: Command parameters are not valid.
    )
) else (
    if "%QM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [ERROR\%~nx0][execute_commands]: No valid command found.
)

if "!__local_cmd_count!" NEQ "1" (
   if "%QM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [ERROR\%~nx0][execute_commands]: No command found to execute. try "%~nx0 -help" for help.
   set __local_cmd_count=
   exit /B 22
)

set __local_cmd_count=

if "%QM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][execute_commands][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------
@REM ******************** [END] COMMAND MANAGEMENT **************************

@REM ******************** [BEGIN] COMMAND IMPLEMENTATION ********************
@REM ------------------------------------------------------------------------
:print_help
if "%QM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][print_help][begin]: %*

call ArgumentManager.bat /print_help

if "%QM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][print_help][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:analyze_targets
if "%QM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][analyze_targets][begin]: %*

if "%QM_CMD_DEBUG_LEVEL%" GEQ "2" @echo [DEBUG\%~nx0][analyze_targets]: analyzing code quality...
call :run_target_configurations "%QM_PARAM_TARGET_CONFIGURATIONS%" "%QM_PARAM_TARGET_ARCHITECTURES%" "analyze"
if "%QM_CMD_DEBUG_LEVEL%" GEQ "2" @echo [DEBUG\%~nx0][analyze_targets]: analyzed code quality.

if "%QM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][analyze_targets][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:test_targets
if "%QM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][test_targets][begin]: %*

if "%QM_CMD_DEBUG_LEVEL%" GEQ "2" @echo [DEBUG\%~nx0][test_targets]: testing code quality...
call :run_target_configurations "%QM_PARAM_TARGET_CONFIGURATIONS%" "%QM_PARAM_TARGET_ARCHITECTURES%" "test"
if "%QM_CMD_DEBUG_LEVEL%" GEQ "2" @echo [DEBUG\%~nx0][test_targets]: tested code quality.

if "%QM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][test_targets][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------
@REM ******************** [END] COMMAND IMPLEMENTATION **********************

@REM ******************** [BEGIN] UTILITY FUNCTIONS *************************
@REM ------------------------------------------------------------------------
:run_target_configurations
if "%QM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][run_target_configurations][begin]: %*
setlocal EnableDelayedExpansion

set _target_configurations=%~1
set _target_architectures=%~2
for /f "tokens=1,2,*" %%a in (%*) do (set _custom_parameters=%%~c)

:iterate_target_configurations
@for /F "tokens=1,* delims=;" %%a in ("%_target_configurations%") do (
    if "%QM_CMD_DEBUG_LEVEL%" GEQ "3" @echo [DEBUG\%~nx0][run_target_configurations]: configuration=%%a
    
    call :run_target_architectures "%%a" "%_target_architectures%" "%_custom_parameters%"
    
    set _target_configurations=%%b
    goto :iterate_target_configurations
)

set _custom_parameters=
set _target_architectures=
set _target_configurations=

endlocal
if "%QM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][run_target_configurations][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:run_target_architectures
if "%QM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][run_target_architectures][begin]: %*
setlocal EnableDelayedExpansion

set _target_configuration=%~1
set _target_architectures=%~2
for /f "tokens=1,2,*" %%a in (%*) do (set _custom_parameters=%%~c)

:iterate_target_architectures
@for /F "tokens=1,* delims=;" %%a in ("%_target_architectures%") do (
    if "%QM_CMD_DEBUG_LEVEL%" GEQ "3" @echo [DEBUG\%~nx0][run_target_architectures]: configuration=%_target_configuration%, architecture=%%a
    
    call :run_target_command "%_target_configuration%" "%%a" "%_custom_parameters%"
    
    set _target_architectures=%%b
    goto :iterate_target_architectures
)

set _custom_parameters=
set _target_architectures=
set _target_configurations=

endlocal
if "%QM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][run_target_architectures][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:run_target_command
if "%QM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][run_target_command][begin]: %*
setlocal EnableDelayedExpansion

set _target_configuration=%~1
set _target_architecture=%~2
set _command=%~3
for /f "tokens=1,2,3,*" %%a in (%*) do (set _command_parameters=%%~d)

if /I "%_command%"=="analyze" (
    call :analyze_with_coverity "%_target_configuration%" "%_target_architecture%" "%_command_parameters%"
    call :analyze_with_bullseye "%_target_configuration%" "%_target_architecture%" "%_command_parameters%"
)

if /I "%_command%"=="test" (
    call :test_with_cppunit "%_target_configuration%" "%_target_architecture%" "%_command_parameters%"
)
set _command_parameters=
set _command=
set _target_architecture=
set _target_configuration=

endlocal
if "%QM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][run_target_command][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:analyze_with_coverity
if "%QM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][analyze_with_coverity][begin]: %*
setlocal EnableDelayedExpansion

set _target_configuration=%~1
set _target_architecture=%~2
set _process_command=%~3

if /I "%_target_architecture%"=="x86" (set _target_architecture_bitness=32)
if /I "%_target_architecture%"=="x64" (set _target_architecture_bitness=64)
set _version_string=%QM_VARS_VERSION_STRING%
set _solution_filepath=%QM_PARAM_SOLUTION_FILEPATH%

set _product_name=%QM_PARAM_PRODUCT_NAME%
set _product_id=%QM_PARAM_PRODUCT_ID%
set _reportdir_path=%QM_PARAM_REPORTDIR_PATH%\%_target_configuration%\%_target_architecture%
set _coverity_filepath=%_reportdir_path%\%QM_PARAM_COVERITY_FILENAME%
set _coverity_logfilepath=%_reportdir_path%\%QM_PARAM_COVERITY_LOGFILENAME%

if not exist "%_reportdir_path%" (
    if "%QM_CMD_DEBUG_LEVEL%" GEQ "2" @echo [DEBUG\%~nx0][analyze_with_coverity]: creating %_reportdir_path%...
    @mkdir "%_reportdir_path%"
    if "%QM_CMD_DEBUG_LEVEL%" GEQ "2" @echo [DEBUG\%~nx0][analyze_with_coverity]: created %_reportdir_path%.
)

if "%QM_CMD_DEBUG_LEVEL%" GEQ "3" @echo [INFO\%~nx0][analyze_with_coverity]: %_process_command% "%_coverity_filepath%" for "%_target_configuration%|%_target_architecture%"...
@echo call cov01 --off
@echo call cov-configure.exe --verbose 4 --compiler cl.exe
@echo call cov-build.exe --debug --verbose 4 --dir %_reportdir_path% devenv.com "%_solution_filepath%" %_process_command% "%_target_configuration%|%_target_architecture%"
@echo call cov-analyze.exe --debug --verbose 4 --dir %_reportdir_path%
@echo call cov-commit.exe %_product_name% %_reportdir_path%
@echo call cov01 --on
if "%QM_CMD_DEBUG_LEVEL%" GEQ "3" @echo [INFO\%~nx0][analyze_with_coverity]: %_process_command% "%_coverity_filepath%" for "%_target_configuration%|%_target_architecture%".

set _target_configuration=
set _target_architecture=
set _process_command=

set _target_architecture_bitness=
set _version_string=
set _solution_filepath=

set _product_name=
set _product_id=
set _reportdir_path=
set _coverity_filepath=
set _coverity_logfilepath=

endlocal
if "%QM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][analyze_with_coverity][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:analyze_with_bullseye
if "%QM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][analyze_with_bullseye][begin]: %*
setlocal EnableDelayedExpansion

set _target_configuration=%~1
set _target_architecture=%~2
set _process_command=%~3

if /I "%_target_architecture%"=="x86" (set _target_architecture_bitness=32)
if /I "%_target_architecture%"=="x64" (set _target_architecture_bitness=64)
set _version_string=%QM_VARS_VERSION_STRING%
set _solution_filepath=%QM_PARAM_SOLUTION_FILEPATH%

set _product_name=%QM_PARAM_PRODUCT_NAME%
set _product_id=%QM_PARAM_PRODUCT_ID%
set _reportdir_path=%QM_PARAM_REPORTDIR_PATH%\%_target_configuration%\%_target_architecture%
set _coverity_filepath=%_reportdir_path%\%QM_PARAM_COVERITY_FILENAME%
set _coverity_logfilepath=%_reportdir_path%\%QM_PARAM_COVERITY_LOGFILENAME%

if not exist "%_reportdir_path%" (
    if "%QM_CMD_DEBUG_LEVEL%" GEQ "2" @echo [DEBUG\%~nx0][analyze_with_bullseye]: creating %_reportdir_path%...
    @mkdir "%_reportdir_path%"
    if "%QM_CMD_DEBUG_LEVEL%" GEQ "2" @echo [DEBUG\%~nx0][analyze_with_bullseye]: created %_reportdir_path%.
)

if "%QM_CMD_DEBUG_LEVEL%" GEQ "3" @echo [INFO\%~nx0][analyze_with_bullseye]: %_process_command% "%_coverity_filepath%" for "%_target_configuration%|%_target_architecture%"...
@echo call cov01 --off
@echo call covsrc --base --by-name --file "%_coverity_filepath%" --output %_coverity_logfilepath%
@echo call cov01 --on
if "%QM_CMD_DEBUG_LEVEL%" GEQ "3" @echo [INFO\%~nx0][analyze_with_bullseye]: %_process_command% "%_coverity_filepath%" for "%_target_configuration%|%_target_architecture%".

set _target_configuration=
set _target_architecture=
set _process_command=

set _target_architecture_bitness=
set _version_string=
set _solution_filepath=

set _product_name=
set _product_id=
set _reportdir_path=
set _coverity_filepath=
set _coverity_logfilepath=

endlocal
if "%QM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][analyze_with_bullseye][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:test_with_cppunit
if "%QM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][test_with_cppunit][begin]: %*
setlocal EnableDelayedExpansion

set _target_configuration=%~1
set _target_architecture=%~2
set _process_command=%~3

if /I "%_target_architecture%"=="x86" (set _target_architecture_bitness=32)
if /I "%_target_architecture%"=="x64" (set _target_architecture_bitness=64)
set _version_string=%QM_VARS_VERSION_STRING%
set _solution_filepath=%QM_PARAM_SOLUTION_FILEPATH%

set _product_name=%QM_PARAM_PRODUCT_NAME%
set _product_id=%QM_PARAM_PRODUCT_ID%
set _reportdir_path=%QM_PARAM_REPORTDIR_PATH%\%_target_configuration%\%_target_architecture%
set _blddir_path=%QM_PARAM_BLDDIR_PATH%\%_target_configuration%\%_target_architecture%
set _samplesdir_path=%QM_PARAM_SAMPLESDIR_PATH%\%_target_configuration%\%_target_architecture%

if not exist "%_reportdir_path%" (
    if "%QM_CMD_DEBUG_LEVEL%" GEQ "2" @echo [DEBUG\%~nx0][test_with_cppunit]: creating %_reportdir_path%...
    @mkdir "%_reportdir_path%"
    if "%QM_CMD_DEBUG_LEVEL%" GEQ "2" @echo [DEBUG\%~nx0][test_with_cppunit]: created %_reportdir_path%.
)

if "%QM_CMD_DEBUG_LEVEL%" GEQ "3" @echo [INFO\%~nx0][test_with_cppunit]: %_process_command% "cppunit" for "%_target_configuration%|%_target_architecture%"...
call "%_blddir_path%\CppUnitTest.exe" -samples="%_samplesdir_path%"
if "%QM_CMD_DEBUG_LEVEL%" GEQ "3" @echo [INFO\%~nx0][test_with_cppunit]: %_process_command% "cppunit" for "%_target_configuration%|%_target_architecture%".

set _target_configuration=
set _target_architecture=
set _process_command=

set _target_architecture_bitness=
set _version_string=
set _solution_filepath=

set _product_name=
set _product_id=
set _reportdir_path=
set _blddir_path=
set _samplesdir_path=

endlocal
if "%QM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][test_with_cppunit][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------
@REM ******************** [END] UTILITY FUNCTIONS ***************************