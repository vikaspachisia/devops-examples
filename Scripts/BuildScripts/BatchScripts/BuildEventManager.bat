@ECHO OFF

@REM ******************** [BEGIN] MAIN **************************************
@REM ------------------------------------------------------------------------
:module
setlocal EnableDelayedExpansion

if not defined BEM_CMD_DEBUG_LEVEL (set BEM_CMD_DEBUG_LEVEL=%CMD_DEBUG_LEVEL%)
if not defined DO_NOT_RESET_ERRORLEVEL (set ERRORLEVEL=0)

call :main %*

set BEM_CMD_DEBUG_LEVEL=

endlocal
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:main
if "%BEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][main][begin]: %*

call :initialize

if ERRORLEVEL 0 (call :parse_commandline_args %*)
if ERRORLEVEL 0 (call :validate_commands)
if ERRORLEVEL 0 (call :validate_parameters)
if ERRORLEVEL 0 (call :execute_commands)

call :uninitialize

if "%BEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][main][end]: result %ERRORLEVEL%
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:initialize
if "%BEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][initialize][begin]: %*

if "%CMD_DEBUG_LEVEL%" GEQ "4" @set

call :initialize_environment
call :initialize_enums
call :initialize_commands
call :initialize_parameters
call :initialize_variables

if "%BEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][initialize][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:uninitialize
if "%BEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][uninitialize][begin]: %*

if "%CMD_DEBUG_LEVEL%" GEQ "4" @set

call :uninitialize_variables
call :uninitialize_parameters
call :uninitialize_commands
call :uninitialize_enums
call :uninitialize_environment

if "%BEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][uninitialize][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:initialize_environment
if "%BEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][initialize_environment][begin]: %*

set THIS_WINDOW_CURRENT_TITLE=Command Prompt %~nx0
REM for /f "usebackq delims=" %%t in (`powershell -noprofile -c "[Console]::Title.Replace(' - '+[Environment]::CommandLine,'')"`) do set THIS_WINDOW_CURRENT_TITLE=%%t
@TITLE Build Event Manager

if "%BEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][initialize_environment][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:uninitialize_environment
if "%BEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][uninitialize_environment][begin]: %*

@TITLE %THIS_WINDOW_CURRENT_TITLE%
set THIS_WINDOW_CURRENT_TITLE=

if "%BEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][uninitialize_environment][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:initialize_enums
if "%BEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][initialize_enums][begin]: %*

REM NOOP

if "%BEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][initialize_enums][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:uninitialize_enums
if "%BEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][uninitialize_enums][begin]: %*

REM NOOP

if "%BEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][uninitialize_enums][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:initialize_commands
if "%BEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][initialize_commands][begin]: %*

set BEM_CMD_HELP=0
set BEM_CMD_CLEAN=0
set BEM_CMD_PREBUILD=0
set BEM_CMD_POSTBUILD=0

if "%BEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][initialize_commands][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:uninitialize_commands
if "%BEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][uninitialize_commands][begin]: %*

set BEM_CMD_HELP=
set BEM_CMD_CLEAN=
set BEM_CMD_PREBUILD=
set BEM_CMD_POSTBUILD=

if "%BEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][uninitialize_commands][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:initialize_parameters
if "%BEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][initialize_parameters][begin]: %*

set BEM_PARAM_SOLUTION_FILEPATH=..\..\..\devops-examples.sln
set BEM_PARAM_VERSION_FILEPATH=..\..\..\shared\common\version.h
set BEM_PARAM_MODULE1_PATH=..\..\..\source\module1
set BEM_PARAM_SCRIPTS_DB_PATH=..\..\..\scripts\dbscripts
set BEM_PARAM_SIGNTOOL_FILEPATH=..\..\..\tools\SignTools\SignTool.exe
set BEM_PARAM_SIGNCERT_FILEPATH=..\..\..\tools\SignTools\devops_private_test_cert.pfx
set BEM_PARAM_OUTDIR_PATH=..\..\..\outputs\builtfiles\bin

set BEM_PARAM_TARGET_CONFIGURATIONS=Release
set BEM_PARAM_TARGET_ARCHITECTURES=x64
set BEM_PARAM_TARGET_RELEASE_IDENTIFIER=QA
set BEM_PARAM_TARGET_SIGN_TYPE=None

set BEM_PARAM_UPDATE_MODEL_BINARIES=Yes
set BEM_PARAM_UPDATE_MODEL_SETTINGS=Yes

if "%BEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][initialize_parameters][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:uninitialize_parameters
if "%BEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][uninitialize_parameters][begin]: %*

set BEM_PARAM_SOLUTION_FILEPATH=
set BEM_PARAM_VERSION_FILEPATH=
set BEM_PARAM_MODULE1_PATH=
set BEM_PARAM_SCRIPTS_DB_PATH=
set BEM_PARAM_SIGNTOOL_FILEPATH=
set BEM_PARAM_SIGNCERT_FILEPATH=
set BEM_PARAM_OUTDIR_PATH=

set BEM_PARAM_TARGET_CONFIGURATIONS=
set BEM_PARAM_TARGET_ARCHITECTURES=
set BEM_PARAM_TARGET_RELEASE_IDENTIFIER=
set BEM_PARAM_TARGET_SIGN_TYPE=

set BEM_PARAM_UPDATE_MODEL_BINARIES=
set BEM_PARAM_UPDATE_MODEL_SETTINGS=

if "%BEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][uninitialize_parameters][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:initialize_variables
if "%BEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][initialize_variables][begin]: %*

set BEM_VARS_COMMAND_VALID=0
set BEM_VARS_COMMAND_PARAMS_VALID=0

set BEM_VARS_VERSION_STRING=*.*.*.0
set BEM_VARS_VERSION_STRING_PARTS=* * * 0

if "%BEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][initialize_variables][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:uninitialize_variables
if "%BEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][uninitialize_variables][begin]: %*

set BEM_VARS_COMMAND_VALID=
set BEM_VARS_COMMAND_PARAMS_VALID=

set BEM_VARS_VERSION_STRING=
set BEM_VARS_VERSION_STRING_PARTS=

if "%BEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][uninitialize_variables][end]: %*
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

set BEM_CMD_HELP=%AM_ENV_CMD_HELP%
set BEM_CMD_CLEAN=%AM_ENV_CMD_CLEAN%
set BEM_CMD_PREBUILD=%AM_ENV_CMD_PREBUILD%
set BEM_CMD_POSTBUILD=%AM_ENV_CMD_POSTBUILD%

if "%AM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][parse_commands][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:parse_parameters
if "%AM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][parse_parameters][begin]: %*

set BEM_PARAM_SOLUTION_FILEPATH=%AM_ENV_SOURCES_PATH%\%AM_ENV_SOURCE_SOLUTION_FILENAME%
set BEM_PARAM_VERSION_FILEPATH=%AM_ENV_SHARED_COMMON_PATH%\%AM_ENV_SOURCE_VERSION_FILENAME%
set BEM_PARAM_MODULE1_PATH=%AM_ENV_SDK_MODULE1_PATH%
set BEM_PARAM_SCRIPTS_DB_PATH=%AM_ENV_SCRIPTS_DB_PATH%
set BEM_PARAM_SIGNTOOL_FILEPATH=%AM_ENV_TOOLS_SIGNTOOLS_PATH%\%AM_ENV_SIGN_TOOL_FILENAME%
set BEM_PARAM_SIGNCERT_FILEPATH=%AM_ENV_TOOLS_SIGNTOOLS_PATH%\%AM_ENV_SIGN_CERTIFICATE_FILENAME%
set BEM_PARAM_OUTDIR_PATH=%AM_ENV_OUTDIR_PATH%

set BEM_PARAM_TARGET_CONFIGURATIONS=%AM_ENV_TARGET_CONFIGURATIONS%
set BEM_PARAM_TARGET_ARCHITECTURES=%AM_ENV_TARGET_ARCHITECTURES%
set BEM_PARAM_TARGET_RELEASE_IDENTIFIER=%AM_ENV_TARGET_RELEASE_IDENTIFIER%
set BEM_PARAM_TARGET_SIGN_TYPE=%AM_ENV_TARGET_SIGN_TYPE%

set BEM_PARAM_UPDATE_MODEL_BINARIES=%AM_ENV_UPDATE_MODEL_BINARIES%
set BEM_PARAM_UPDATE_MODEL_SETTINGS=%AM_ENV_UPDATE_MODEL_SETTINGS%

if "%AM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][parse_parameters][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:parse_variables
if "%AM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][parse_variables][begin]: %*

set __vm_cmd_debug_level=%VM_CMD_DEBUG_LEVEL%
set VM_CMD_DEBUG_LEVEL=0
for /f "useback delims=*" %%v in (`VersionManager /get_version /filepath^=%BEM_PARAM_VERSION_FILEPATH%`) do (set BEM_VARS_VERSION_STRING=%%v)
for /f "useback delims=*" %%v in (`VersionManager /get_version_parts /version^=%BEM_VARS_VERSION_STRING%`) do (set BEM_VARS_VERSION_STRING_PARTS=%%v)
set VM_CMD_DEBUG_LEVEL=%__vm_cmd_debug_level%

if "%AM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][parse_variables][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:validate_commands
if "%BEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][validate_commands][begin]: %*

set /A __local_cmd_count=0

if "%BEM_CMD_HELP%"=="1" (set /A __local_cmd_count+=1)
if "%BEM_CMD_CLEAN%"=="1" (set /A __local_cmd_count+=1)
if "%BEM_CMD_PREBUILD%"=="1" (set /A __local_cmd_count+=1)
if "%BEM_CMD_POSTBUILD%"=="1" (set /A __local_cmd_count+=1)

if "%__local_cmd_count%" NEQ "1" (
   if "%BEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [ERROR\%~nx0][validate_commands]: cannot identify the command to run. command count=%__local_cmd_count%
   set __local_cmd_count=
   set BEM_VARS_COMMAND_VALID=0
   exit /B 22
) else (
    set BEM_VARS_COMMAND_VALID=1
)

set __local_cmd_count=

if "%BEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][validate_commands][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:validate_parameters
if "%BEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][validate_parameters][begin]: %*

set /A __local_param_valid=1

if "%BEM_CMD_PREBUILD%"=="1" (
    if not exist "%BEM_PARAM_SOLUTION_FILEPATH%" (
        set __local_param_valid=0
        if "%BEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [ERROR\%~nx0][validate_parameters]: cannot find '%BEM_PARAM_SOLUTION_FILEPATH%'.
    )
    if not exist "%BEM_PARAM_VERSION_FILEPATH%" (
        set __local_param_valid=0
        if "%BEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [ERROR\%~nx0][validate_parameters]: cannot find '%BEM_PARAM_VERSION_FILEPATH%'.
    )
    if not exist "%BEM_PARAM_MODULE1_PATH%" (
        set __local_param_valid=0
        if "%BEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [ERROR\%~nx0][validate_parameters]: cannot find '%BEM_PARAM_MODULE1_PATH%'.
    )
    if not exist "%BEM_PARAM_SCRIPTS_DB_PATH%" (
        set __local_param_valid=0
        if "%BEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [ERROR\%~nx0][validate_parameters]: cannot find '%BEM_PARAM_SCRIPTS_DB_PATH%'.
    )
)

if "%BEM_CMD_POSTBUILD%"=="1" (
    if not exist "%BEM_PARAM_SIGNTOOL_FILEPATH%" (
        set __local_param_valid=0
        if "%BEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [ERROR\%~nx0][validate_parameters]: cannot find '%BEM_PARAM_SIGNTOOL_FILEPATH%'.
    )
    if not exist "%BEM_PARAM_SIGNCERT_FILEPATH%" (
        set __local_param_valid=0
        if "%BEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [ERROR\%~nx0][validate_parameters]: cannot find '%BEM_PARAM_SIGNCERT_FILEPATH%'.
    )
    if not exist "%BEM_PARAM_OUTDIR_PATH%" (
        set __local_param_valid=0
        if "%BEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [ERROR\%~nx0][validate_parameters]: cannot find '%BEM_PARAM_OUTDIR_PATH%'.
    )
)

if "%AM_VARS_ENUM_PARAMS_VALID%"=="0" (
    set __local_param_valid=0
)

if "%__local_param_valid%" NEQ "1" (
   if "%BEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [ERROR\%~nx0][validate_parameters]: cannot find the parameters for the command to run.
   set __local_param_valid=
   set BEM_VARS_COMMAND_PARAMS_VALID=0
   exit /B 87
) else (
    set BEM_VARS_COMMAND_PARAMS_VALID=1
)

set __local_param_valid=

if "%BEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][validate_parameters][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:execute_commands
if "%BEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][execute_commands][begin]: %*

set /A __local_cmd_count=0

if !BEM_VARS_COMMAND_VALID! EQU 1 (
    if !BEM_VARS_COMMAND_PARAMS_VALID! EQU 1 (
        if "%BEM_CMD_HELP%"=="1" (set /A __local_cmd_count+=1 & call :print_help)
        if "%BEM_CMD_CLEAN%"=="1" (set /A __local_cmd_count+=1 & call :clean_targets)
        if "%BEM_CMD_PREBUILD%"=="1" (set /A __local_cmd_count+=1 & call :prebuild_targets)
        if "%BEM_CMD_POSTBUILD%"=="1" (set /A __local_cmd_count+=1 & call :postbuild_targets)
    ) else (
        if "%BEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [ERROR\%~nx0][execute_commands]: Command parameters are not valid.
    )
) else (
    if "%BEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [ERROR\%~nx0][execute_commands]: No valid command found.
)

if "!__local_cmd_count!" NEQ "1" (
   if "%BEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [ERROR\%~nx0][execute_commands]: No command found to execute. try "%~nx0 -help" for help.
   set __local_cmd_count=
   exit /B 22
)

set __local_cmd_count=

if "%BEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][execute_commands][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------
@REM ******************** [END] COMMAND MANAGEMENT **************************

@REM ******************** [BEGIN] COMMAND IMPLEMENTATION ********************
@REM ------------------------------------------------------------------------
:print_help
if "%BEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][print_help][begin]: %*

call ArgumentManager.bat /print_help

if "%BEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][print_help][end]: %*
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
:prebuild_targets
if "%BEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][prebuild_targets][begin]: %*

if /I "%BEM_PARAM_UPDATE_MODEL_SETTINGS%" EQU "Yes" (
    call :update_model_settings "%BEM_PARAM_SCRIPTS_DB_PATH%" "%BEM_PARAM_MODULE1_PATH%"
)
if /I "%BEM_PARAM_TARGET_RELEASE_IDENTIFIER%" NEQ "QA"  (
    call :update_target_release_identifier "%BEM_PARAM_TARGET_RELEASE_IDENTIFIER%"
)

if "%BEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][prebuild_targets][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:postbuild_targets
if "%BEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][postbuild_targets][begin]: %*

if /I "%BEM_PARAM_TARGET_SIGN_TYPE%" NEQ "None"  (call :run_sign_targets "%BEM_PARAM_TARGET_SIGN_TYPE%")

if "%BEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][postbuild_targets][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------
@REM ******************** [END] COMMAND IMPLEMENTATION **********************

@REM ******************** [BEGIN] UTILITY FUNCTIONS *************************

@REM ------------------------------------------------------------------------
:update_model_settings
if "%BEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][update_model_settings][begin]: %*
setlocal EnableDelayedExpansion

set _scripts_db_path=%~1
set _module1_path=%~2

pushd %_scripts_db_path%

@REM Begin updating model settings...

if "%BEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [INFO\%~nx0][update_model_settings]: updating version for models...
@REM run a batch/python/powershell or other script to update the version.
if "%BEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [INFO\%~nx0][update_model_settings]: updated version for models...

@REM End updating model settings...


popd

set _scripts_db_path=
set _module1_path=

endlocal
if "%BEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][update_model_settings][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:update_target_release_identifier
if "%BEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][update_target_release_identifier][begin]: %*
setlocal EnableDelayedExpansion

set _target_release_identifier=%~1

set _config_path=%BEM_PARAM_MODULE1_PATH%\config
set __regex=

if /I "%_target_release_identifier%" == "QA" (set __regex="s/#define DEV/#define QA/")
if /I "%_target_release_identifier%" == "STAGE" (set __regex="s/\/\/#define STAGE/#define STAGE/")
if /I "%_target_release_identifier%" == "PROD" (set __regex="s/#define QA/#define PROD/")

if NOT %__regex%=="" (
	if "%BEM_CMD_DEBUG_LEVEL%" GEQ "2" @echo [DEBUG\%~nx0][update_target_release_identifier]: Updating target build type to %_target_release_identifier%.
	PERL -pi.bak -pe %__regex% "%_config_path%\defines.h"
) else (
    if "%BEM_CMD_DEBUG_LEVEL%" GEQ "2" @echo [DEBUG\%~nx0][update_target_release_identifier]: Not updating target build type. '%_target_release_identifier%' is not supported.
)

set __regex=
set _config_path=

set _target_release_identifier=

endlocal
if "%BEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][update_target_release_identifier][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:run_sign_targets
if "%BEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][run_sign_targets][begin]: %*
setlocal EnableDelayedExpansion

set _target_sign_type=%~1

call :run_target_configurations "%BEM_PARAM_TARGET_CONFIGURATIONS%" "%BEM_PARAM_TARGET_ARCHITECTURES%" "sign_targets" "%_target_sign_type%"

set _target_sign_type=

endlocal
if "%BEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][run_sign_targets][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:run_target_configurations
if "%BEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][run_target_configurations][begin]: %*
setlocal EnableDelayedExpansion

set _target_configurations=%~1
set _target_architectures=%~2
for /f "tokens=1,2,*" %%a in (%*) do (set _custom_parameters=%%~c)

:iterate_target_configurations
@for /F "tokens=1,* delims=;" %%a in ("%_target_configurations%") do (
    if "%BEM_CMD_DEBUG_LEVEL%" GEQ "3" @echo [DEBUG\%~nx0][run_target_configurations]: configuration=%%a
    
    call :run_target_architectures "%%a" "%_target_architectures%" "%_custom_parameters%"
    
    set _target_configurations=%%b
    goto :iterate_target_configurations
)

set _custom_parameters=
set _target_architectures=
set _target_configurations=

endlocal
if "%BEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][run_target_configurations][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:run_target_architectures
if "%BEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][run_target_architectures][begin]: %*
setlocal EnableDelayedExpansion

set _target_configuration=%~1
set _target_architectures=%~2
for /f "tokens=1,2,*" %%a in (%*) do (set _custom_parameters=%%~c)

:iterate_target_architectures
@for /F "tokens=1,* delims=;" %%a in ("%_target_architectures%") do (
    if "%BEM_CMD_DEBUG_LEVEL%" GEQ "3" @echo [DEBUG\%~nx0][run_target_architectures]: configuration=%_target_configuration%, architecture=%%a
    
    call :run_target_command "%_target_configuration%" "%%a" "%_custom_parameters%"
    
    set _target_architectures=%%b
    goto :iterate_target_architectures
)

set _custom_parameters=
set _target_architectures=
set _target_configurations=

endlocal
if "%BEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][run_target_architectures][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:run_target_command
if "%BEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][run_target_command][begin]: %*
setlocal EnableDelayedExpansion

set _target_configuration=%~1
set _target_architecture=%~2
set _command=%~3
for /f "tokens=1,2,3,*" %%a in (%*) do (set _command_parameters=%%~d)

if /I "%_command%"=="sign_targets" (
    call :sign_targets "%_target_configuration%" "%_target_architecture%" "%_command_parameters%"
)

set _command_parameters=
set _command=
set _target_architecture=
set _target_configuration=

endlocal
if "%BEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][run_target_command][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:sign_targets
if "%BEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][sign_targets][begin]: %*
setlocal EnableDelayedExpansion

set _target_configuration=%~1
set _target_architecture=%~2
set _target_sign_type=%~3

if /I "%_target_sign_type%"=="LocalSign" (
    call :localsign_targets "%_target_configuration%" "%_target_architecture%"
)

if /I "%_target_sign_type%"=="ServerSign" (
    call :serversign_targets "%_target_configuration%" "%_target_architecture%"
)

set _target_sign_type=
set _target_architecture=
set _target_configuration=

endlocal
if "%BEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][sign_targets][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:localsign_targets
if "%BEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][localsign_targets][begin]: %*
setlocal EnableDelayedExpansion

set _target_configuration=%~1
set _target_architecture=%~2
set _target_bin_path=%BEM_PARAM_OUTDIR_PATH%\%_target_configuration%\%_target_architecture%

if "%CMD_DEBUG_LEVEL%" GEQ "2" @echo [DEBUG\%~nx0][localsign_targets]: Start signing binaries...

for %%a in (%_target_bin_path%\*.dll, %_target_bin_path%\*.exe) do (
    if "%CMD_DEBUG_LEVEL%" GEQ "2" @echo [DEBUG\%~nx0][localsign_targets]: signing %%a...
    "%BEM_PARAM_SIGNTOOL_FILEPATH%" sign /f "%BEM_PARAM_SIGNCERT_FILEPATH%" %%a
    if "%CMD_DEBUG_LEVEL%" GEQ "2" @echo [DEBUG\%~nx0][localsign_targets]: signed %%a...
)

if "%CMD_DEBUG_LEVEL%" GEQ "2" @echo [DEBUG\%~nx0][localsign_targets]: End signing binaries...

set _target_bin_path=
set _target_architecture=
set _target_configuration=

endlocal
if "%BEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][localsign_targets][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:serversign_targets
if "%BEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][serversign_targets][begin]: %*
setlocal EnableDelayedExpansion

set _target_configuration=%~1
set _target_architecture=%~2
set _target_bin_path=%BEM_PARAM_OUTDIR_PATH%\%_target_configuration%\%_target_architecture%

if "%CMD_DEBUG_LEVEL%" GEQ "2" @echo [DEBUG\%~nx0][serversign_targets]: Start signing binaries...

for %%a in (%_target_bin_path%\*.dll, %_target_bin_path%\*.exe) do (
    if "%CMD_DEBUG_LEVEL%" GEQ "2" @echo [DEBUG\%~nx0][localsign_targets]: signing %%a...
    "%BEM_PARAM_SIGNTOOL_FILEPATH%" sign /f "%BEM_PARAM_SIGNCERT_FILEPATH%" %%a
    if "%CMD_DEBUG_LEVEL%" GEQ "2" @echo [DEBUG\%~nx0][localsign_targets]: signed %%a...
)

if "%CMD_DEBUG_LEVEL%" GEQ "2" @echo [DEBUG\%~nx0][serversign_targets]: End signing binaries...

set _target_bin_path=
set _target_architecture=
set _target_configuration=

endlocal
if "%BEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][serversign_targets][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------
@REM ******************** [END] UTILITY FUNCTIONS ***************************