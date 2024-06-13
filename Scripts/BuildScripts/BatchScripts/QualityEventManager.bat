@ECHO OFF

@REM ******************** [BEGIN] MAIN **************************************
@REM ------------------------------------------------------------------------
:module
setlocal EnableDelayedExpansion

if not defined QEM_CMD_DEBUG_LEVEL (set QEM_CMD_DEBUG_LEVEL=%CMD_DEBUG_LEVEL%)
if not defined DO_NOT_RESET_ERRORLEVEL (set ERRORLEVEL=0)

call :main %*

set QEM_CMD_DEBUG_LEVEL=

endlocal
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:main
if "%QEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][main][begin]: %*

call :initialize

if ERRORLEVEL 0 (call :parse_commandline_args %*)
if ERRORLEVEL 0 (call :validate_commands)
if ERRORLEVEL 0 (call :validate_parameters)
if ERRORLEVEL 0 (call :execute_commands)

call :uninitialize

if "%QEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][main][end]: result %ERRORLEVEL%
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:initialize
if "%QEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][initialize][begin]: %*

if "%CMD_DEBUG_LEVEL%" GEQ "4" @set

call :initialize_environment
call :initialize_enums
call :initialize_commands
call :initialize_parameters
call :initialize_variables

if "%QEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][initialize][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:uninitialize
if "%QEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][uninitialize][begin]: %*

if "%CMD_DEBUG_LEVEL%" GEQ "4" @set

call :uninitialize_variables
call :uninitialize_parameters
call :uninitialize_commands
call :uninitialize_enums
call :uninitialize_environment

if "%QEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][uninitialize][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:initialize_environment
if "%QEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][initialize_environment][begin]: %*

set THIS_WINDOW_CURRENT_TITLE=Command Prompt %~nx0
REM for /f "usebackq delims=" %%t in (`powershell -noprofile -c "[Console]::Title.Replace(' - '+[Environment]::CommandLine,'')"`) do set THIS_WINDOW_CURRENT_TITLE=%%t
@TITLE Quality Event Manager

if "%QEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][initialize_environment][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:uninitialize_environment
if "%QEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][uninitialize_environment][begin]: %*

@TITLE %THIS_WINDOW_CURRENT_TITLE%
set THIS_WINDOW_CURRENT_TITLE=

if "%QEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][uninitialize_environment][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:initialize_enums
if "%QEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][initialize_enums][begin]: %*

REM NOOP

if "%QEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][initialize_enums][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:uninitialize_enums
if "%QEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][uninitialize_enums][begin]: %*

REM NOOP

if "%QEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][uninitialize_enums][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:initialize_commands
if "%QEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][initialize_commands][begin]: %*

set QEM_CMD_HELP=0
set QEM_CMD_CLEAN=0
set QEM_CMD_PREQUALITYCHECK=0
set QEM_CMD_POSQUALITYCHECK=0

if "%QEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][initialize_commands][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:uninitialize_commands
if "%QEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][uninitialize_commands][begin]: %*

set QEM_CMD_HELP=
set QEM_CMD_CLEAN=
set QEM_CMD_PREQUALITYCHECK=
set QEM_CMD_POSTQUALITYCHECK=

if "%QEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][uninitialize_commands][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:initialize_parameters
if "%QEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][initialize_parameters][begin]: %*

set QEM_PARAM_SOLUTION_FILEPATH=..\..\..\devops-examples.sln
set QEM_PARAM_VERSION_FILEPATH=..\..\..\shared\common\version.h

set QEM_PARAM_TARGET_CONFIGURATIONS=Release
set QEM_PARAM_TARGET_ARCHITECTURES=x64

if "%QEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][initialize_parameters][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:uninitialize_parameters
if "%QEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][uninitialize_parameters][begin]: %*

set QEM_PARAM_SOLUTION_FILEPATH=
set QEM_PARAM_VERSION_FILEPATH=

set QEM_PARAM_TARGET_CONFIGURATIONS=
set QEM_PARAM_TARGET_ARCHITECTURES=

if "%QEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][uninitialize_parameters][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:initialize_variables
if "%QEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][initialize_variables][begin]: %*

set QEM_VARS_COMMAND_VALID=0
set QEM_VARS_COMMAND_PARAMS_VALID=0

set QEM_VARS_VERSION_STRING=*.*.*.0
set QEM_VARS_VERSION_STRING_PARTS=* * * 0

if "%QEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][initialize_variables][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:uninitialize_variables
if "%QEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][uninitialize_variables][begin]: %*

set QEM_VARS_COMMAND_VALID=
set QEM_VARS_COMMAND_PARAMS_VALID=

set QEM_VARS_VERSION_STRING=
set QEM_VARS_VERSION_STRING_PARTS=

if "%QEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][uninitialize_variables][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------
@REM ******************** [END] MAIN ****************************************


@REM ******************** [BEGIN] COMMAND MANAGEMENT ************************
@REM ------------------------------------------------------------------------
:parse_commandline_args
if "%AM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][parse_commandline_args][begin]: %*

call ArgumentManager.bat /set_environment %*
call :parse_commandline_arg %*
call ArgumentManager.bat /reset_environment

if "%AM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][parse_commandline_args][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:parse_commandline_arg
if "%AM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][parse_commandline_arg][begin]: %*

call :parse_commands %*
call :parse_parameters %*
call :parse_variables %*

if "%AM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][parse_commandline_arg][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:parse_commands
if "%AM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][parse_commands][begin]: %*

set QEM_CMD_HELP=%AM_ENV_CMD_HELP%
set QEM_CMD_CLEAN=%AM_ENV_CMD_CLEAN%
set QEM_CMD_PREQUALITYCHECK=%AM_PARAM_CMD_PREQUALITYCHECK%
set QEM_CMD_POSTQUALITYCHECK=%AM_PARAM_CMD_POSTQUALITYCHECK%

if "%AM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][parse_commands][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:parse_parameters
if "%AM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][parse_parameters][begin]: %*

set QEM_PARAM_SOLUTION_FILEPATH=%AM_ENV_SOURCES_PATH%\%AM_ENV_SOURCE_SOLUTION_FILENAME%
set QEM_PARAM_VERSION_FILEPATH=%AM_ENV_SHARED_COMMON_PATH%\%AM_ENV_SOURCE_VERSION_FILENAME%

set QEM_PARAM_TARGET_CONFIGURATIONS=%AM_ENV_TARGET_CONFIGURATIONS%
set QEM_PARAM_TARGET_ARCHITECTURES=%AM_ENV_TARGET_ARCHITECTURES%

if "%AM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][parse_parameters][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:parse_variables
if "%AM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][parse_variables][begin]: %*

set __vm_cmd_debug_level=%VM_CMD_DEBUG_LEVEL%
set VM_CMD_DEBUG_LEVEL=0
for /f "useback delims=*" %%v in (`VersionManager /get_version /filepath^=%QEM_PARAM_VERSION_FILEPATH%`) do (set QEM_VARS_VERSION_STRING=%%v)
for /f "useback delims=*" %%v in (`VersionManager /get_version_parts /version^=%QEM_VARS_VERSION_STRING%`) do (set QEM_VARS_VERSION_STRING_PARTS=%%v)
set VM_CMD_DEBUG_LEVEL=%__vm_cmd_debug_level%

if "%AM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][parse_variables][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:validate_commands
if "%QEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][validate_commands][begin]: %*

set /A __local_cmd_count=0

if "%QEM_CMD_HELP%"=="1" (set /A __local_cmd_count+=1)
if "%QEM_CMD_CLEAN%"=="1" (set /A __local_cmd_count+=1)
if "%QEM_CMD_PREQUALITYCHECK%"=="1" (set /A __local_cmd_count+=1)
if "%QEM_CMD_POSTQUALITYCHECK%"=="1" (set /A __local_cmd_count+=1)

if "%__local_cmd_count%" NEQ "1" (
   if "%QEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [ERROR\%~nx0][validate_commands]: cannot identify the command to run. command count=%__local_cmd_count%
   set __local_cmd_count=
   set QEM_VARS_COMMAND_VALID=0
   exit /B 22
) else (
    set QEM_VARS_COMMAND_VALID=1
)

set __local_cmd_count=

if "%QEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][validate_commands][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:validate_parameters
if "%QEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][validate_parameters][begin]: %*

set /A __local_param_valid=1

if "%QEM_CMD_PREQUALITYCHECK%"=="1" (
    if not exist "%QEM_PARAM_SOLUTION_FILEPATH%" (
        set __local_param_valid=0
        if "%QEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [ERROR\%~nx0][validate_parameters]: cannot find '%QEM_PARAM_SOLUTION_FILEPATH%'.
    )
    if not exist "%QEM_PARAM_VERSION_FILEPATH%" (
        set __local_param_valid=0
        if "%QEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [ERROR\%~nx0][validate_parameters]: cannot find '%QEM_PARAM_VERSION_FILEPATH%'.
    )
)

if "%QEM_CMD_POSTQUALITYCHECK%"=="1" (
    if not exist "%QEM_PARAM_SOLUTION_FILEPATH%" (
        set __local_param_valid=0
        if "%QEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [ERROR\%~nx0][validate_parameters]: cannot find '%QEM_PARAM_SOLUTION_FILEPATH%'.
    )
    if not exist "%QEM_PARAM_VERSION_FILEPATH%" (
        set __local_param_valid=0
        if "%QEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [ERROR\%~nx0][validate_parameters]: cannot find '%QEM_PARAM_VERSION_FILEPATH%'.
    )
)

if "%AM_VARS_ENUM_PARAMS_VALID%"=="0" (
    set __local_param_valid=0
)

if "%__local_param_valid%" NEQ "1" (
   if "%QEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [ERROR\%~nx0][validate_parameters]: cannot find the parameters for the command to run.
   set __local_param_valid=
   set QEM_VARS_COMMAND_PARAMS_VALID=0
   exit /B 87
) else (
    set QEM_VARS_COMMAND_PARAMS_VALID=1
)

set __local_param_valid=

if "%QEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][validate_parameters][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:execute_commands
if "%QEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][execute_commands][begin]: %*

set /A __local_cmd_count=0

if !QEM_VARS_COMMAND_VALID! EQU 1 (
    if !QEM_VARS_COMMAND_PARAMS_VALID! EQU 1 (
        if "%QEM_CMD_HELP%"=="1" (set /A __local_cmd_count+=1 & call :print_help)
        if "%QEM_CMD_CLEAN%"=="1" (set /A __local_cmd_count+=1 & call :clean_targets)
        if "%QEM_CMD_PREQUALITYCHECK%"=="1" (set /A __local_cmd_count+=1 & call :prequality_targets)
        if "%QEM_CMD_POSTQUALITYCHECK%"=="1" (set /A __local_cmd_count+=1 & call :postquality_targets)
    ) else (
        if "%QEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [ERROR\%~nx0][execute_commands]: Command parameters are not valid.
    )
) else (
    if "%QEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [ERROR\%~nx0][execute_commands]: No valid command found.
)

if "!__local_cmd_count!" NEQ "1" (
   if "%QEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [ERROR\%~nx0][execute_commands]: No command found to execute. try "%~nx0 -help" for help.
   set __local_cmd_count=
   exit /B 22
)

set __local_cmd_count=

if "%QEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][execute_commands][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------
@REM ******************** [END] COMMAND MANAGEMENT **************************

@REM ******************** [BEGIN] COMMAND IMPLEMENTATION ********************
@REM ------------------------------------------------------------------------
:print_help
if "%QEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][print_help][begin]: %*

call ArgumentManager.bat /print_help

if "%QEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][print_help][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:clean_targets
if "%BM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][clean_targets][begin]: %*

@REM NOOP -- Possibly undo git changes (pre or post build source changes)

if "%BM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][clean_targets][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:prequality_targets
if "%QEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][prequality_targets][begin]: %*

@call :run_quality_checks

if "%QEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][prequality_targets][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:postquality_targets
if "%QEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][postquality_targets][begin]: %*

@call :run_quality_checks

if "%QEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][postquality_targets][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------
@REM ******************** [END] COMMAND IMPLEMENTATION **********************

@REM ******************** [BEGIN] UTILITY FUNCTIONS *************************

@REM ------------------------------------------------------------------------
:run_quality_checks
if "%QEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][run_quality_checks][begin]: %*
setlocal EnableDelayedExpansion

call :run_target_configurations "%QEM_PARAM_TARGET_CONFIGURATIONS%" "%QEM_PARAM_TARGET_ARCHITECTURES%" "check_quality"

endlocal
if "%QEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][run_quality_checks][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:run_target_configurations
if "%QEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][run_target_configurations][begin]: %*
setlocal EnableDelayedExpansion

set _target_configurations=%~1
set _target_architectures=%~2
for /f "tokens=1,2,*" %%a in (%*) do (set _custom_parameters=%%~c)

:iterate_target_configurations
@for /F "tokens=1,* delims=;" %%a in ("%_target_configurations%") do (
    if "%QEM_CMD_DEBUG_LEVEL%" GEQ "3" @echo [DEBUG\%~nx0][run_target_configurations]: configuration=%%a
    
    call :run_target_architectures "%%a" "%_target_architectures%" "%_custom_parameters%"
    
    set _target_configurations=%%b
    goto :iterate_target_configurations
)

set _custom_parameters=
set _target_architectures=
set _target_configurations=

endlocal
if "%QEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][run_target_configurations][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:run_target_architectures
if "%QEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][run_target_architectures][begin]: %*
setlocal EnableDelayedExpansion

set _target_configuration=%~1
set _target_architectures=%~2
for /f "tokens=1,2,*" %%a in (%*) do (set _custom_parameters=%%~c)

:iterate_target_architectures
@for /F "tokens=1,* delims=;" %%a in ("%_target_architectures%") do (
    if "%QEM_CMD_DEBUG_LEVEL%" GEQ "3" @echo [DEBUG\%~nx0][run_target_architectures]: configuration=%_target_configuration%, architecture=%%a
    
    call :run_target_command "%_target_configuration%" "%%a" "%_custom_parameters%"
    
    set _target_architectures=%%b
    goto :iterate_target_architectures
)

set _custom_parameters=
set _target_architectures=
set _target_configurations=

endlocal
if "%QEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][run_target_architectures][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:run_target_command
if "%QEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][run_target_command][begin]: %*
setlocal EnableDelayedExpansion

set _target_configuration=%~1
set _target_architecture=%~2
set _command=%~3
for /f "tokens=1,2,3,*" %%a in (%*) do (set _command_parameters=%%~d)

if /I "%_command%"=="check_quality" (
    call :check_quality "%_target_configuration%" "%_target_architecture%" "%_command_parameters%"
)

set _command_parameters=
set _command=
set _target_architecture=
set _target_configuration=

endlocal
if "%QEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][run_target_command][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:check_quality
if "%QEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][check_quality][begin]: %*
setlocal EnableDelayedExpansion

set _target_configuration=%~1
set _target_architecture=%~2

@REM NOOP

set _target_architecture=
set _target_configuration=

endlocal
if "%QEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][check_quality][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ******************** [END] UTILITY FUNCTIONS ***************************