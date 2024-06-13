@ECHO OFF

@REM ******************** [BEGIN] MAIN **************************************
@REM ------------------------------------------------------------------------
:module
setlocal EnableDelayedExpansion

if not defined DEM_CMD_DEBUG_LEVEL (set DEM_CMD_DEBUG_LEVEL=%CMD_DEBUG_LEVEL%)
if not defined DO_NOT_RESET_ERRORLEVEL (set ERRORLEVEL=0)

call :main %*

set DEM_CMD_DEBUG_LEVEL=

endlocal
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:main
if "%DEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][main][begin]: %*

call :initialize

if ERRORLEVEL 0 (call :parse_commandline_args %*)
if ERRORLEVEL 0 (call :validate_commands)
if ERRORLEVEL 0 (call :validate_parameters)
if ERRORLEVEL 0 (call :execute_commands)

call :uninitialize

if "%DEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][main][end]: result %ERRORLEVEL%
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:initialize
if "%DEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][initialize][begin]: %*

if "%CMD_DEBUG_LEVEL%" GEQ "4" @set

call :initialize_environment
call :initialize_enums
call :initialize_commands
call :initialize_parameters
call :initialize_variables

if "%DEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][initialize][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:uninitialize
if "%DEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][uninitialize][begin]: %*

if "%CMD_DEBUG_LEVEL%" GEQ "4" @set

call :uninitialize_variables
call :uninitialize_parameters
call :uninitialize_commands
call :uninitialize_enums
call :uninitialize_environment

if "%DEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][uninitialize][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:initialize_environment
if "%DEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][initialize_environment][begin]: %*

set THIS_WINDOW_CURRENT_TITLE=Command Prompt %~nx0
REM for /f "usebackq delims=" %%t in (`powershell -noprofile -c "[Console]::Title.Replace(' - '+[Environment]::CommandLine,'')"`) do set THIS_WINDOW_CURRENT_TITLE=%%t
@TITLE Distribution Event Manager

if "%DEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][initialize_environment][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:uninitialize_environment
if "%DEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][uninitialize_environment][begin]: %*

@TITLE %THIS_WINDOW_CURRENT_TITLE%
set THIS_WINDOW_CURRENT_TITLE=

if "%DEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][uninitialize_environment][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:initialize_enums
if "%DEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][initialize_enums][begin]: %*

REM NOOP

if "%DEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][initialize_enums][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:uninitialize_enums
if "%DEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][uninitialize_enums][begin]: %*

REM NOOP

if "%DEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][uninitialize_enums][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:initialize_commands
if "%DEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][initialize_commands][begin]: %*

set DEM_CMD_HELP=0
set DEM_CMD_CLEAN=0
set DEM_CMD_PREBUILD=0
set DEM_CMD_POSTBUILD=0

if "%DEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][initialize_commands][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:uninitialize_commands
if "%DEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][uninitialize_commands][begin]: %*

set DEM_CMD_HELP=
set DEM_CMD_CLEAN=
set DEM_CMD_PREBUILD=
set DEM_CMD_POSTBUILD=

if "%DEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][uninitialize_commands][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:initialize_parameters
if "%DEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][initialize_parameters][begin]: %*

set DEM_PARAM_SOLUTION_FILEPATH=..\..\..\devops-examples.sln
set DEM_PARAM_VERSION_FILEPATH=..\..\..\shared\common\version.h
set DEM_PARAM_MODULE1_PATH=..\..\..\source\module1
set DEM_PARAM_SCRIPTS_DB_PATH=..\..\..\scripts\db

set DEM_PARAM_DOCS_PATH=..\..\..\docs

set DEM_PARAM_SHARED_COMMON_PATH=..\..\..\shared\common\
set DEM_PARAM_SHARED_PUBLIC_PATH=..\..\..\shared\public\
set DEM_PARAM_SHARED_CONFIG_PATH=..\..\..\shared\config\
set DEM_PARAM_SHARED_CONFIG_MANIFESTS_PATH=..\..\..\shared\config\ManifestFiles

set DEM_PARAM_TESTS_CPPUNITTEST_PATH=..\..\tests\cppunittest
set DEM_PARAM_TESTS_BULLSEYE_PATH=..\..\tests\bullseye

set DEM_PARAM_OUTDIR_PATH=..\..\outputs\builtfiles\bin
set DEM_PARAM_DEVOPS_PATH=..\..\scripts\devops

set DEM_PARAM_BLDDIR_PATH=..\..\outputs\builtfiles
set DEM_PARAM_STGDIR_PATH=..\..\outputs\stagefiles
set DEM_PARAM_DSTDIR_PATH=..\..\outputs\distfiles

set DEM_PARAM_TARGET_CONFIGURATIONS=Release
set DEM_PARAM_TARGET_ARCHITECTURES=x64

if "%DEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][initialize_parameters][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:uninitialize_parameters
if "%DEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][uninitialize_parameters][begin]: %*

set DEM_PARAM_SOLUTION_FILEPATH=
set DEM_PARAM_VERSION_FILEPATH=
set DEM_PARAM_RAPTORSDK_PATH=
set DEM_PARAM_SCRIPTS_DB_PATH=

set DEM_PARAM_DOCS_PATH=

set DEM_PARAM_SHARED_COMMON_PATH=
set DEM_PARAM_SHARED_PUBLIC_PATH=
set DEM_PARAM_SHARED_CONFIG_PATH=
set DEM_PARAM_SHARED_CONFIG_MANIFESTS_PATH=

set DEM_PARAM_TESTS_CPPUNITTEST_PATH=
set DEM_PARAM_TESTS_BULLSEYE_PATH=

set DEM_PARAM_OUTDIR_PATH=
set DEM_PARAM_DEVOPS_PATH=

set DEM_PARAM_BLDDIR_PATH=
set DEM_PARAM_STGDIR_PATH=
set DEM_PARAM_DSTDIR_PATH=

set DEM_PARAM_TARGET_CONFIGURATIONS=
set DEM_PARAM_TARGET_ARCHITECTURES=

if "%DEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][uninitialize_parameters][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:initialize_variables
if "%DEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][initialize_variables][begin]: %*

set DEM_VARS_COMMAND_VALID=0
set DEM_VARS_COMMAND_PARAMS_VALID=0

set DEM_VARS_VERSION_STRING=*.*.*.0
set DEM_VARS_VERSION_STRING_PARTS=* * * 0

if "%DEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][initialize_variables][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:uninitialize_variables
if "%DEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][uninitialize_variables][begin]: %*

set DEM_VARS_COMMAND_VALID=
set DEM_VARS_COMMAND_PARAMS_VALID=

set DEM_VARS_VERSION_STRING=
set DEM_VARS_VERSION_STRING_PARTS=

if "%DEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][uninitialize_variables][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------
@REM ******************** [END] MAIN ****************************************


@REM ******************** [BEGIN] COMMAND MANAGEMENT ************************
@REM ------------------------------------------------------------------------
:parse_commandline_args
if "%DEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][parse_commandline_args][begin]: %*

call ArgumentManager.bat /set_environment %*
call :parse_commandline_arg %*
call ArgumentManager.bat /reset_environment

if "%DEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][parse_commandline_args][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:parse_commandline_arg
if "%DEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][parse_commandline_arg][begin]: %*

call :parse_commands %*
call :parse_parameters %*
call :parse_variables %*

if "%DEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][parse_commandline_arg][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:parse_commands
if "%DEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][parse_command][begin]: %*

set DEM_CMD_HELP=%AM_ENV_CMD_HELP%
set DEM_CMD_CLEAN=%AM_ENV_CMD_CLEAN%
set DEM_CMD_PREBUILD=%AM_ENV_CMD_PREBUILD%
set DEM_CMD_POSTBUILD=%AM_ENV_CMD_POSTBUILD%

if "%DEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][parse_command][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:parse_parameters
if "%DEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][parse_parameter][begin]: %*

set DEM_PARAM_SOLUTION_FILEPATH=%AM_ENV_SOURCES_PATH%\%AM_ENV_SOURCE_SOLUTION_FILENAME%
set DEM_PARAM_VERSION_FILEPATH=%AM_ENV_SHARED_COMMON_PATH%\%AM_ENV_SOURCE_VERSION_FILENAME%
set DEM_PARAM_RAPTORSDK_PATH=%AM_ENV_SDK_RAPTORSDK_PATH%
set DEM_PARAM_SCRIPTS_DB_PATH=%AM_ENV_SCRIPTS_DB_PATH%

set DEM_PARAM_DOCS_PATH=%AM_ENV_DOCS_PATH%

set DEM_PARAM_SHARED_COMMON_PATH=%AM_ENV_SHARED_COMMON_PATH%
set DEM_PARAM_SHARED_PUBLIC_PATH=%AM_ENV_SHARED_PUBLIC_PATH%
set DEM_PARAM_SHARED_CONFIG_PATH=%AM_ENV_SHARED_CONFIG_PATH%
set DEM_PARAM_SHARED_CONFIG_MANIFEST_PATH=%AM_ENV_SHARED_MANIFEST_PATH%

set DEM_PARAM_TESTS_CPPUNITTEST_PATH=%AM_ENV_TESTS_CPPUNITTEST_PATH%
set DEM_PARAM_TESTS_BULLSEYE_PATH=%AM_ENV_TESTS_BULLSEYE_PATH%

set DEM_PARAM_OUTDIR_PATH=%AM_ENV_OUTDIR_PATH%

set DEM_PARAM_BLDDIR_PATH=%AM_ENV_BLDDIR_PATH%
set DEM_PARAM_STGDIR_PATH=%AM_ENV_STGDIR_PATH%
set DEM_PARAM_DSTDIR_PATH=%AM_ENV_DSTDIR_PATH%

set DEM_PARAM_TARGET_CONFIGURATIONS=%AM_ENV_TARGET_CONFIGURATIONS%
set DEM_PARAM_TARGET_ARCHITECTURES=%AM_ENV_TARGET_ARCHITECTURES%

if "%DEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][parse_parameter][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:parse_variables
if "%DEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][parse_variables][begin]: %*

set __vm_cmd_debug_level=%VM_CMD_DEBUG_LEVEL%
set VM_CMD_DEBUG_LEVEL=0
for /f "useback delims=*" %%v in (`VersionManager /get_version /filepath^=%DEM_PARAM_VERSION_FILEPATH%`) do (set DEM_VARS_VERSION_STRING=%%v)
for /f "useback delims=*" %%v in (`VersionManager /get_version_parts /version^=%DEM_VARS_VERSION_STRING%`) do (set DEM_VARS_VERSION_STRING_PARTS=%%v)
set VM_CMD_DEBUG_LEVEL=%__vm_cmd_debug_level%

if "%DEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][parse_variables][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:validate_commands
if "%DEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][validate_commands][begin]: %*

set /A __local_cmd_count=0

if "%DEM_CMD_HELP%"=="1" (set /A __local_cmd_count+=1)
if "%DEM_CMD_CLEAN%"=="1" (set /A __local_cmd_count+=1)
if "%DEM_CMD_PREBUILD%"=="1" (set /A __local_cmd_count+=1)
if "%DEM_CMD_POSTBUILD%"=="1" (set /A __local_cmd_count+=1)

if "%__local_cmd_count%" NEQ "1" (
   if "%DEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [ERROR\%~nx0][validate_commands]: cannot identify the command to run. command count=%__local_cmd_count%
   set __local_cmd_count=
   set DEM_VARS_COMMAND_VALID=0
   exit /B 22
) else (
    set DEM_VARS_COMMAND_VALID=1
)

set __local_cmd_count=
if "%DEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][validate_commands][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:validate_parameters
if "%DEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][validate_parameters][begin]: %*

set /A __local_param_valid=1
set /A __validate_inp_file_paths=0
set /A __validate_out_file_paths=0

if "%DEM_CMD_PREBUILD%"=="1" (
    if not exist "%DEM_PARAM_SOLUTION_FILEPATH%" (
        set __local_param_valid=0
        if "%DEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [ERROR\%~nx0][validate_parameters]: cannot find '%DEM_PARAM_SOLUTION_FILEPATH%'.
    )
    if not exist "%DEM_PARAM_VERSION_FILEPATH%" (
        set __local_param_valid=0
        if "%DEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [ERROR\%~nx0][validate_parameters]: cannot find '%DEM_PARAM_VERSION_FILEPATH%'.
    )
    if not exist "%DEM_PARAM_MODULE1_PATH%" (
        set __local_param_valid=0
        if "%DEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [ERROR\%~nx0][validate_parameters]: cannot find '%DEM_PARAM_MODULE1_PATH%'.
    )
    if not exist "%DEM_PARAM_SCRIPTS_DB_PATH%" (
        set __local_param_valid=0
        if "%DEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [ERROR\%~nx0][validate_parameters]: cannot find '%DEM_PARAM_SCRIPTS_DB_PATH%'.
    )
    if not exist "%DEM_PARAM_SHARED_COMMON_PATH%" (
        set __local_param_valid=0
        if "%DEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [ERROR\%~nx0][validate_parameters]: cannot find '%DEM_PARAM_SHARED_COMMON_PATH%'.
    )
    if not exist "%DEM_PARAM_SHARED_PUBLIC_PATH%" (
        set __local_param_valid=0
        if "%DEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [ERROR\%~nx0][validate_parameters]: cannot find '%DEM_PARAM_SHARED_PUBLIC_PATH%'.
    )
    if not exist "%DEM_PARAM_SHARED_CONFIG_PATH%" (
        set __local_param_valid=0
        if "%DEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [ERROR\%~nx0][validate_parameters]: cannot find '%DEM_PARAM_SHARED_CONFIG_PATH%'.
    )
    if not exist "%DEM_PARAM_SHARED_CONFIG_MANIFESTS_PATH%" (
        set __local_param_valid=0
        if "%DEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [ERROR\%~nx0][validate_parameters]: cannot find '%DEM_PARAM_SHARED_CONFIG_MANIFESTS_PATH%'.
    )
)

if "%DEM_CMD_POSTBUILD%"=="1" (
    if not exist "%DEM_PARAM_OUTDIR_PATH%" (
        set __local_param_valid=0
        if "%DEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [ERROR\%~nx0][validate_parameters]: cannot find '%DEM_PARAM_OUTDIR_PATH%'.
    )

    if not exist "%DEM_PARAM_BLDDIR_PATH%" (
        set __local_param_valid=0
        if "%DEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [ERROR\%~nx0][validate_parameters]: cannot find '%DEM_PARAM_BLDDIR_PATH%'.
    )
)

if "%AM_VARS_ENUM_PARAMS_VALID%"=="0" (
    set __local_param_valid=0
)

if "%__local_param_valid%" NEQ "1" (
   if "%DEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [ERROR\%~nx0][validate_parameters]: cannot find the parameters for the command to run.
   set __local_param_valid=
   set DEM_VARS_COMMAND_PARAMS_VALID=0
   exit /B 87
) else (
    set DEM_VARS_COMMAND_PARAMS_VALID=1
)

set __local_param_valid=

if "%DEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][validate_parameters][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:execute_commands
if "%DEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][execute_commands][begin]: %*

set /A __local_cmd_count=0

if !DEM_VARS_COMMAND_VALID! EQU 1 (
    if !DEM_VARS_COMMAND_PARAMS_VALID! EQU 1 (
        if "%DEM_CMD_HELP%"=="1" (set /A __local_cmd_count+=1 & call :print_help)
        if "%DEM_CMD_CLEAN%"=="1" (set /A __local_cmd_count+=1 & call :clean_targets)
        if "%DEM_CMD_PREBUILD%"=="1" (set /A __local_cmd_count+=1 & call :prebuild_targets)
        if "%DEM_CMD_POSTBUILD%"=="1" (set /A __local_cmd_count+=1 & call :postbuild_targets)
    ) else (
        if "%DEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [ERROR\%~nx0][execute_commands]: Command parameters are not valid.
    )
) else (
    if "%DEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [ERROR\%~nx0][execute_commands]: No valid command found.
)

if "!__local_cmd_count!" NEQ "1" (
   if "%DEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [ERROR\%~nx0][execute_commands]: No command found to execute. try "%~nx0 -help" for help.
   set __local_cmd_count=
   exit /B 22
)

set __local_cmd_count=

if "%DEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][execute_commands][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------
@REM ******************** [END] COMMAND MANAGEMENT **************************

@REM ******************** [BEGIN] COMMAND IMPLEMENTATION ********************
@REM ------------------------------------------------------------------------
:print_help
if "%DEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][print_help][begin]: %*

call ArgumentManager.bat /print_help

if "%DEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][print_help][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:clean_targets
if "%DEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][clean_targets][begin]: %*

if "%DEM_CMD_DEBUG_LEVEL%" GEQ "2" @echo [DEBUG\%~nx0][clean_targets]: removing %DEM_PARAM_STGDIR_PATH%...

rmdir /s /q "%DEM_PARAM_STGDIR_PATH%"

if "%DEM_CMD_DEBUG_LEVEL%" GEQ "2" @echo [DEBUG\%~nx0][clean_targets]: removed %DEM_PARAM_STGDIR_PATH%.

if "%DEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][clean_targets][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:prebuild_targets
if "%DEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][prebuild_targets][begin]: %*

call :run_stage_files

if "%DEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][prebuild_targets][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:postbuild_targets
if "%DEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][postbuild_targets][begin]: %*

call :run_create_dat_files

if "%DEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][postbuild_targets][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------
@REM ******************** [END] COMMAND IMPLEMENTATION **********************

@REM ******************** [BEGIN] UTILITY FUNCTIONS *************************
@REM ------------------------------------------------------------------------
:run_stage_files
if "%DEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][run_stage_files][begin]: %*
setlocal EnableDelayedExpansion

call :run_target_configurations "%DEM_PARAM_TARGET_CONFIGURATIONS%" "%DEM_PARAM_TARGET_ARCHITECTURES%" "stage_files"

endlocal
if "%DEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][run_stage_files][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:run_create_dat_files
if "%DEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][run_create_dat_files][begin]: %*
setlocal EnableDelayedExpansion

call :run_target_configurations "%DEM_PARAM_TARGET_CONFIGURATIONS%" "%DEM_PARAM_TARGET_ARCHITECTURES%" "create_dat_files"

endlocal
if "%DEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][run_create_dat_files][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:run_target_configurations
if "%DEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][run_target_configurations][begin]: %*
setlocal EnableDelayedExpansion

set _target_configurations=%~1
set _target_architectures=%~2
for /f "tokens=1,2,*" %%a in (%*) do (set _custom_parameters=%%~c)

:iterate_target_configurations
@for /F "tokens=1,* delims=;" %%a in ("%_target_configurations%") do (
    if "%DEM_CMD_DEBUG_LEVEL%" GEQ "3" @echo [DEBUG\%~nx0][run_target_configurations]: configuration=%%a

    call :run_target_architectures "%%a" "%_target_architectures%" "%_custom_parameters%"

    set _target_configurations=%%b
    goto :iterate_target_configurations
)

set _custom_parameters=
set _target_architectures=
set _target_configurations=

endlocal
if "%DEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][run_target_configurations][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:run_target_architectures
if "%DEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][run_target_architectures][begin]: %*
setlocal EnableDelayedExpansion

set _target_configuration=%~1
set _target_architectures=%~2
for /f "tokens=1,2,*" %%a in (%*) do (set _custom_parameters=%%~c)

:iterate_target_architectures
@for /F "tokens=1,* delims=;" %%a in ("%_target_architectures%") do (
    if "%DEM_CMD_DEBUG_LEVEL%" GEQ "3" @echo [DEBUG\%~nx0][run_target_architectures]: configuration=%_target_configuration%, architecture=%%a

    call :run_target_command "%_target_configuration%" "%%a" "%_custom_parameters%"

    set _target_architectures=%%b
    goto :iterate_target_architectures
)

set _custom_parameters=
set _target_architectures=
set _target_configurations=

endlocal
if "%DEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][run_target_architectures][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:run_target_command
if "%DEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][run_target_command][begin]: %*
setlocal EnableDelayedExpansion

set _target_configuration=%~1
set _target_architecture=%~2
set _command=%~3
for /f "tokens=1,2,3,*" %%a in (%*) do (set _command_parameters=%%~d)

if /I "%_command%"=="stage_files" (
    call :stage_files "%_target_configuration%" "%_target_architecture%" "%_command_parameters%"
)

if /I "%_command%"=="create_dat_files" (
    call :create_dat_files "%_target_configuration%" "%_target_architecture%" "%_command_parameters%"
)

set _command_parameters=
set _command=
set _target_architecture=
set _target_configuration=

endlocal
if "%DEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][run_target_command][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:create_component_list
if "%DEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][create_component_list][begin]: %*

set _components[0].name=Module1
set _components[0].despatch=:stage_module1_files
set _components[1].name=Module2
set _components[1].despatch=:stage_module2_files

set _components_count=2

if "%DEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][create_component_list][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:destroy_component_list
if "%DEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][destroy_component_list][begin]: %*

set _components=
set _components_count=

if "%DEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][destroy_component_list][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:stage_files
if "%DEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][stage_files][begin]: %*
setlocal EnableDelayedExpansion

set _target_configuration=%~1
set _target_architecture=%~2

call :create_component_list
set /A _components_last_index=%_components_count% - 1
if "%DEM_CMD_DEBUG_LEVEL%" GEQ "2" @echo [DEBUG\%~nx0][stage_files]: staging %_components_count% components(last componentid=%_components_last_index%)...

for /l %%i in (0,1,%_components_last_index%) do (
    call set _despatch_method=%%_components[%%i].despatch%%
    call set _component_name=%%_components[%%i].name%%
    call  !_despatch_method! "%_target_configuration%" "%_target_architecture%" "!_component_name!"
    call set _despatch_method=
    call set _component_name=
)

if "%DEM_CMD_DEBUG_LEVEL%" GEQ "2" @echo [DEBUG\%~nx0][stage_files]: staged %_components_count% components(last componentid=%_components_last_index%).
set _components_last_index=
call :destroy_component_list

set _target_architecture=
set _target_configuration=

endlocal
if "%DEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][stage_files][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:stage_module1_files
if "%DEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][stage_module1_files][begin]: %*
setlocal EnableDelayedExpansion

set _target_configuration=%~1
set _target_architecture=%~2
set _component_name=%~3

set _outdir_bin_path=%DEM_PARAM_OUTDIR_PATH%\%_target_configuration%\%_target_architecture%
set _stgdir_bin_path=%DEM_PARAM_STGDIR_PATH%\%_component_name%\%_target_configuration%\%_target_architecture%
set _stgdir_bin_pdb_path=%DEM_PARAM_STGDIR_PATH%\"%_component_name%_pdb"\%_target_configuration%\%_target_architecture%

set _shared_common_path=%DEM_PARAM_SHARED_COMMON_PATH%
set _shared_public_path=%DEM_PARAM_SHARED_PUBLIC_PATH%

set _scripts_db_path=%DEM_PARAM_SCRIPTS_DB_PATH%
set _docs_path=%DEM_PARAM_DOCS_PATH%

if not exist "%_stgdir_bin_path%" (
    if "%DEM_CMD_DEBUG_LEVEL%" GEQ "2" @echo [DEBUG\%~nx0][stage_module1_files]: creating %_stgdir_bin_path%...
    @mkdir "%_stgdir_bin_path%"
    @mkdir "%_stgdir_bin_pdb_path%"
    if "%DEM_CMD_DEBUG_LEVEL%" GEQ "2" @echo [DEBUG\%~nx0][stage_module1_files]: created %_stgdir_bin_path%.
)

for %%a in (dll, exe) do (
    if exist "%_outdir_bin_path%\module1.%%a" (xcopy /y "%_outdir_bin_path%\module1.%%a" "%_stgdir_bin_path%\")
    if exist "%_outdir_bin_path%\module1_ext.%%a" (xcopy /y "%_outdir_bin_path%\module1_ext.%%a" "%_stgdir_bin_path%\")
)
if exist "%_outdir_bin_path%\module1.pdb" (xcopy /y "%_outdir_bin_path%\module1.pdb" "%_stgdir_bin_pdb_path%\")
if exist "%_outdir_bin_path%\module1_ext.pdb" (xcopy /y "%_outdir_bin_path%\module1_ext.pdb" "%_stgdir_bin_pdb_path%\")

if exist "%_outdir_bin_path%\Module1Config.dat" (xcopy /y "%_outdir_bin_path%\Module1Config.dat" "%_stgdir_bin_path%\")

if exist "%_shared_public_path%\*.h" (xcopy /y "%_shared_public_path%\*.h" "%_stgdir_bin_path%\")
if exist "%_scripts_db_path%\module1.db" (xcopy /y "%_scripts_db_path%\module1.db" "%_stgdir_bin_path%\")

if exist "%_docs_path%\license.txt" (xcopy /y "%_docs_path%\license.txt" "%_stgdir_bin_path%\")
if exist "%_docs_path%\module1.pdf" (xcopy /y "%_docs_path%\module1.pdf" "%_stgdir_bin_path%\")
if exist "%_docs_path%\module1.docx" (xcopy /y "%_docs_path%\module1.docx" "%_stgdir_bin_path%\")

set _target_configuration=
set _target_architecture=
set _component_name=

set _outdir_bin_path=
set _stgdir_bin_path=

set _shared_common_path=
set _shared_public_path=
set _scripts_db_path=
set _docs_path=

endlocal
if "%DEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][stage_module1_files][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:stage_module2_files
if "%DEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][stage_module2_files][begin]: %*
setlocal EnableDelayedExpansion

set _target_configuration=%~1
set _target_architecture=%~2
set _component_name=%~3

@REM call other specific functions or do whatever has to be done here.

set _target_configuration=
set _target_architecture=
set _component_name=

endlocal
if "%DEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][stage_module2_files][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------


@REM ------------------------------------------------------------------------
:file_transfer
if "%DEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][file_transfer][begin]: %*
setlocal EnableDelayedExpansion

set _source_file="%~1"
set _destination_files=%*

if exist %_source_file% (
    for %%d in (%_destination_files%) do (
        set _destination_path=%%d
        set _destination_path=!_destination_path:"=!
        if %%d NEQ %_source_file% (
            xcopy /y %_source_file% "!_destination_path!\"
        )
    )
    set _destination_path=
)

set _source_file=
set _destination_files=

endlocal
if "%DEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][file_transfer][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:unquote
if "%DEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][unquote][begin]: %*
setlocal EnableDelayedExpansion

for /f "delims=" %%A in ('echo %%%1%%') do set %1=%%~A

endlocal
if "%DEM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][unquote][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ******************** [END] UTILITY FUNCTIONS ***************************