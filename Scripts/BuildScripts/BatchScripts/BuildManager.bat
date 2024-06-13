@ECHO OFF

@REM ******************** [BEGIN] MAIN **************************************
@REM ------------------------------------------------------------------------
:module
setlocal EnableDelayedExpansion

if not defined BM_CMD_DEBUG_LEVEL (set BM_CMD_DEBUG_LEVEL=%CMD_DEBUG_LEVEL%)
if not defined DO_NOT_RESET_ERRORLEVEL (set ERRORLEVEL=0)

call :main %*

set BM_CMD_DEBUG_LEVEL=

endlocal
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:main
if "%BM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][main][begin]: %*

call :initialize

if ERRORLEVEL 0 (call :parse_commandline_args %*)
if ERRORLEVEL 0 (call :validate_commands)
if ERRORLEVEL 0 (call :validate_parameters)
if ERRORLEVEL 0 (call :execute_commands)

call :uninitialize

if "%BM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][main][end]: result %ERRORLEVEL%
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:initialize
if "%BM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][initialize][begin]: %*

if "%CMD_DEBUG_LEVEL%" GEQ "4" @set

call :initialize_environment
call :initialize_enums
call :initialize_commands
call :initialize_parameters
call :initialize_variables

if "%BM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][initialize][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:uninitialize
if "%BM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][uninitialize][begin]: %*

if "%CMD_DEBUG_LEVEL%" GEQ "4" @set

call :uninitialize_variables
call :uninitialize_parameters
call :uninitialize_commands
call :uninitialize_enums
call :uninitialize_environment

if "%BM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][uninitialize][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:initialize_environment
if "%BM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][initialize_environment][begin]: %*

set THIS_WINDOW_CURRENT_TITLE=Command Prompt %~nx0
REM for /f "usebackq delims=" %%t in (`powershell -noprofile -c "[Console]::Title.Replace(' - '+[Environment]::CommandLine,'')"`) do set THIS_WINDOW_CURRENT_TITLE=%%t
@TITLE Build Manager

if "%BM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][initialize_environment][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:uninitialize_environment
if "%BM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][uninitialize_environment][begin]: %*

@TITLE %THIS_WINDOW_CURRENT_TITLE%
set THIS_WINDOW_CURRENT_TITLE=

if "%BM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][uninitialize_environment][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:initialize_enums
if "%BM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][initialize_enums][begin]: %*

REM NOOP

if "%BM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][initialize_enums][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:uninitialize_enums
if "%BM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][uninitialize_enums][begin]: %*

REM NOOP

if "%BM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][uninitialize_enums][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:initialize_commands
if "%BM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][initialize_commands][begin]: %*

set BM_CMD_HELP=0
set BM_CMD_CLEAN=0
set BM_CMD_BUILD=0
set BM_CMD_REBUILD=0

if "%BM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][initialize_commands][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:uninitialize_commands
if "%BM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][uninitialize_commands][begin]: %*

set BM_CMD_HELP=
set BM_CMD_CLEAN=
set BM_CMD_BUILD=
set BM_CMD_REBUILD=

if "%BM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][uninitialize_commands][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:initialize_parameters
if "%BM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][initialize_parameters][begin]: %*

set BM_PARAM_SOLUTION_FILEPATH=..\..\..\devops-examples.sln
set BM_PARAM_VERSION_FILEPATH=..\..\..\shared\common\version.h
set BM_PARAM_TARGET_CONFIGURATIONS=Release
set BM_PARAM_TARGET_ARCHITECTURES=x64

set BM_PARAM_VISUALSTUDIO_VERSION=latest

if "%BM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][initialize_parameters][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:uninitialize_parameters
if "%BM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][uninitialize_parameters][begin]: %*

set BM_PARAM_SOLUTION_FILEPATH=
set BM_PARAM_VERSION_FILEPATH=
set BM_PARAM_TARGET_CONFIGURATIONS=
set BM_PARAM_TARGET_ARCHITECTURES=

set BM_PARAM_VISUALSTUDIO_VERSION=

if "%BM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][uninitialize_parameters][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:initialize_variables
if "%BM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][initialize_variables][begin]: %*

set BM_VARS_COMMAND_VALID=0
set BM_VARS_COMMAND_PARAMS_VALID=0

set BM_VARS_VERSION_STRING=*.*.*.0
set BM_VARS_VERSION_STRING_PARTS=* * * 0

if "%BM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][initialize_variables][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:uninitialize_variables
if "%BM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][uninitialize_variables][begin]: %*

set BM_VARS_COMMAND_VALID=
set BM_VARS_COMMAND_PARAMS_VALID=

set BM_VARS_VERSION_STRING=
set BM_VARS_VERSION_STRING_PARTS=

if "%BM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][uninitialize_variables][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------
@REM ******************** [END] MAIN ****************************************


@REM ******************** [BEGIN] COMMAND MANAGEMENT ************************
@REM ------------------------------------------------------------------------
:parse_commandline_args
if "%BM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][parse_commandline_args][begin]: %*

call ArgumentManager.bat /set_environment %*
call :parse_commandline_arg %*
call ArgumentManager.bat /reset_environment

if "%BM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][parse_commandline_args][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:parse_commandline_arg
if "%BM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][parse_commandline_arg][begin]: %*

call :parse_commands %*
call :parse_parameters %*
call :parse_variables %*

if "%BM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][parse_commandline_arg][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:parse_commands
if "%BM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][parse_commands][begin]: %*

set BM_CMD_HELP=%AM_ENV_CMD_HELP%
set BM_CMD_CLEAN=%AM_ENV_CMD_CLEAN%
set BM_CMD_BUILD=%AM_ENV_CMD_BUILD%
set BM_CMD_REBUILD=%AM_ENV_CMD_REBUILD%

if "%BM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][parse_commands][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:parse_parameters
if "%BM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][parse_parameters][begin]: %*

set BM_PARAM_SOLUTION_FILEPATH=%AM_ENV_SOURCES_PATH%\%AM_ENV_SOURCE_SOLUTION_FILENAME%
set BM_PARAM_VERSION_FILEPATH=%AM_ENV_SHARED_COMMON_PATH%\%AM_ENV_SOURCE_VERSION_FILENAME%
set BM_PARAM_TARGET_CONFIGURATIONS=%AM_ENV_TARGET_CONFIGURATIONS%
set BM_PARAM_TARGET_ARCHITECTURES=%AM_ENV_TARGET_ARCHITECTURES%

set BM_PARAM_VISUALSTUDIO_VERSION=%AM_ENV_VISUALSTUDIO_VERSION%

if "%BM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][parse_parameters][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:parse_variables
if "%BM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][parse_variables][begin]: %*

set __vm_cmd_debug_level=%VM_CMD_DEBUG_LEVEL%
set VM_CMD_DEBUG_LEVEL=0
for /f "useback delims=*" %%v in (`VersionManager /get_version /filepath^=%BM_PARAM_VERSION_FILEPATH%`) do (set BM_VARS_VERSION_STRING=%%v)
for /f "useback delims=*" %%v in (`VersionManager /get_version_parts /version^=%BM_VARS_VERSION_STRING%`) do (set BM_VARS_VERSION_STRING_PARTS=%%v)
set VM_CMD_DEBUG_LEVEL=%__vm_cmd_debug_level%

if "%BM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][parse_variables][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:validate_commands
if "%BM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][validate_commands][begin]: %*

set /A __local_cmd_count=0

if "%BM_CMD_HELP%"=="1" (set /A __local_cmd_count+=1)
if "%BM_CMD_CLEAN%"=="1" (set /A __local_cmd_count+=1)
if "%BM_CMD_BUILD%"=="1" (set /A __local_cmd_count+=1)
if "%BM_CMD_REBUILD%"=="1" (set /A __local_cmd_count+=1)

if "%__local_cmd_count%" NEQ "1" (
   if "%BM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [ERROR\%~nx0][validate_commands]: cannot identify the command to run. command count=%__local_cmd_count%
   set __local_cmd_count=
   set BM_VARS_COMMAND_VALID=0
   exit /B 22
) else (
    set BM_VARS_COMMAND_VALID=1
)

set __local_cmd_count=

if "%BM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][validate_commands][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:validate_parameters
if "%BM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][validate_parameters][begin]: %*

set /A __local_param_valid=1
set /A __validate_solution_filepath=0

if "%BM_CMD_CLEAN%"=="1" (set __validate_solution_filepath=1)
if "%BM_CMD_BUILD%"=="1" (set __validate_solution_filepath=1)
if "%BM_CMD_REBUILD%"=="1" (set __validate_solution_filepath=1)

if "%__validate_solution_filepath%"=="1" (
     if not exist "%BM_PARAM_SOLUTION_FILEPATH%" (
        set __local_param_valid=0
        if "%BM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [ERROR\%~nx0][validate_parameters]: cannot find '%BM_PARAM_SOLUTION_FILEPATH%'.
    )
)

if "%AM_VARS_ENUM_PARAMS_VALID%"=="0" (
    set __local_param_valid=0
)

if "%__local_param_valid%" NEQ "1" (
   if "%BM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [ERROR\%~nx0][validate_parameters]: cannot find the parameters for the command to run.
   set __local_param_valid=
   set BM_VARS_COMMAND_PARAMS_VALID=0
   exit /B 87
) else (
    set BM_VARS_COMMAND_PARAMS_VALID=1
)

set __local_param_valid=

if "%BM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][validate_parameters][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:execute_commands
if "%BM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][execute_commands][begin]: %*

set /A __local_cmd_count=0

if !BM_VARS_COMMAND_VALID! EQU 1 (
    if !BM_VARS_COMMAND_PARAMS_VALID! EQU 1 (
        if "%BM_CMD_HELP%"=="1" (set /A __local_cmd_count+=1 & call :print_help)
        if "%BM_CMD_CLEAN%"=="1" (set /A __local_cmd_count+=1 & call :clean_targets)
        if "%BM_CMD_BUILD%"=="1" (set /A __local_cmd_count+=1 & call :build_targets)
        if "%BM_CMD_REBUILD%"=="1" (set /A __local_cmd_count+=1 & call :rebuild_targets)
    ) else (
        if "%BM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [ERROR\%~nx0][execute_commands]: Command parameters are not valid.
    )
) else (
    if "%BM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [ERROR\%~nx0][execute_commands]: No valid command found.
)

if "!__local_cmd_count!" NEQ "1" (
   if "%BM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [ERROR\%~nx0][execute_commands]: No command found to execute. try "%~nx0 -help" for help.
   set __local_cmd_count=
   exit /B 22
)

set __local_cmd_count=

if "%BM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][execute_commands][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------
@REM ******************** [END] COMMAND MANAGEMENT **************************

@REM ******************** [BEGIN] COMMAND IMPLEMENTATION ********************
@REM ------------------------------------------------------------------------
:print_help
if "%BM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][print_help][begin]: %*

call ArgumentManager.bat /print_help

if "%BM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][print_help][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:clean_targets
if "%BM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][clean_targets][begin]: %*

if "%BM_CMD_DEBUG_LEVEL%" GEQ "2" @echo [DEBUG\%~nx0][clean_targets]: cleaning %BM_PARAM_SOLUTION_FILEPATH%...

call :set_vs_build_environment "vsdevcmd"
call :run_target_configurations "%BM_PARAM_TARGET_CONFIGURATIONS%" "%BM_PARAM_TARGET_ARCHITECTURES%" "process_solution" "/clean"

if "%BM_CMD_DEBUG_LEVEL%" GEQ "2" @echo [DEBUG\%~nx0][clean_targets]: cleaned %BM_PARAM_SOLUTION_FILEPATH%.

if "%BM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][clean_targets][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:build_targets
if "%BM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][build_targets][begin]: %*

if "%BM_CMD_DEBUG_LEVEL%" GEQ "2" @echo [DEBUG\%~nx0][build_targets]: building %BM_PARAM_SOLUTION_FILEPATH%...

call :set_vs_build_environment "vsdevcmd"
call :run_target_configurations "%BM_PARAM_TARGET_CONFIGURATIONS%" "%BM_PARAM_TARGET_ARCHITECTURES%" "process_solution" "/build"

if "%BM_CMD_DEBUG_LEVEL%" GEQ "2" @echo [DEBUG\%~nx0][build_targets]: built %BM_PARAM_SOLUTION_FILEPATH%.

if "%BM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][build_targets][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:rebuild_targets
if "%BM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][rebuild_targets][begin]: %*

if "%BM_CMD_DEBUG_LEVEL%" GEQ "2" @echo [DEBUG\%~nx0][rebuild_targets]: rebuilding %BM_PARAM_SOLUTION_FILEPATH%...

call :set_vs_build_environment "vsdevcmd"
call :run_target_configurations "%BM_PARAM_TARGET_CONFIGURATIONS%" "%BM_PARAM_TARGET_ARCHITECTURES%" "process_solution" "/rebuild"

if "%BM_CMD_DEBUG_LEVEL%" GEQ "2" @echo [DEBUG\%~nx0][rebuild_targets]: rebuilt %BM_PARAM_SOLUTION_FILEPATH%.

if "%BM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][rebuild_targets][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------
@REM ******************** [END] COMMAND IMPLEMENTATION **********************

@REM ******************** [BEGIN] UTILITY FUNCTIONS *************************
@REM ------------------------------------------------------------------------
:run_target_configurations
if "%BM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][run_target_configurations][begin]: %*
setlocal EnableDelayedExpansion

set _target_configurations=%~1
set _target_architectures=%~2
for /f "tokens=1,2,*" %%a in (%*) do (set _custom_parameters=%%~c)

:iterate_target_configurations
@for /F "tokens=1,* delims=;" %%a in ("%_target_configurations%") do (
    if "%BM_CMD_DEBUG_LEVEL%" GEQ "3" @echo [DEBUG\%~nx0][run_target_configurations]: configuration=%%a
    
    call :run_target_architectures "%%a" "%_target_architectures%" "%_custom_parameters%"
    
    set _target_configurations=%%b
    goto :iterate_target_configurations
)

set _custom_parameters=
set _target_architectures=
set _target_configurations=

endlocal
if "%BM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][run_target_configurations][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:run_target_architectures
if "%BM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][run_target_architectures][begin]: %*
setlocal EnableDelayedExpansion

set _target_configuration=%~1
set _target_architectures=%~2
for /f "tokens=1,2,*" %%a in (%*) do (set _custom_parameters=%%~c)

:iterate_target_architectures
@for /F "tokens=1,* delims=;" %%a in ("%_target_architectures%") do (
    if "%BM_CMD_DEBUG_LEVEL%" GEQ "3" @echo [DEBUG\%~nx0][run_target_architectures]: configuration=%_target_configuration%, architecture=%%a
    
    call :run_target_command "%_target_configuration%" "%%a" "%_custom_parameters%"
    
    set _target_architectures=%%b
    goto :iterate_target_architectures
)

set _custom_parameters=
set _target_architectures=
set _target_configurations=

endlocal
if "%BM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][run_target_architectures][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:run_target_command
if "%BM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][run_target_command][begin]: %*
setlocal EnableDelayedExpansion

set _target_configuration=%~1
set _target_architecture=%~2
set _command=%~3
for /f "tokens=1,2,3,*" %%a in (%*) do (set _command_parameters=%%~d)

if /I "%_command%"=="process_solution" (
    call :process_solution "%_target_configuration%" "%_target_architecture%" "%_command_parameters%"
)

set _command_parameters=
set _command=
set _target_architecture=
set _target_configuration=

endlocal
if "%BM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][run_target_command][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:process_solution
if "%BM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][process_solution][begin]: %*
setlocal EnableDelayedExpansion

set _target_configuration=%~1
set _target_architecture=%~2
set _process_command=%~3

if /I "%_target_architecture%"=="x86" (set _target_architecture_bitness=32)
if /I "%_target_architecture%"=="x64" (set _target_architecture_bitness=64)
set _version_string=%BM_VARS_VERSION_STRING%
set _solution_filepath=%BM_PARAM_SOLUTION_FILEPATH%

if "%BM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [INFO\%~nx0][process_solution]: devenv.com "%_solution_filepath%" %_process_command% "%_target_configuration%|%_target_architecture%"
devenv.com "%_solution_filepath%" %_process_command% "%_target_configuration%|%_target_architecture%"

set _target_configuration=
set _target_architecture=
set _process_command=

set _target_architecture_bitness=
set _version_string=
set _solution_filepath=

endlocal
if "%BM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][process_solution][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:set_vs_build_environment
if "%BM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][set_vs_build_environment][begin]: %*

set _vs_build_env_type=%~1
if "%BM_CMD_DEBUG_LEVEL%" GEQ "2" @echo [DEBUG\%~nx0][set_vs_build_environment]: setting envrionment as !_vs_build_env_type!
if /I "%_vs_build_env_type%"=="vsdevcmd" (
    set _vs_build_env_relative_path=Common7\Tools\vsdevcmd.bat
) else (
    set _vs_build_env_relative_path=VC\Auxiliary\Build\vcvarsall.bat
)
if "%BM_CMD_DEBUG_LEVEL%" GEQ "2" @echo [DEBUG\%~nx0][set_vs_build_environment]: set envrionment as !_vs_build_env_type!


set _vs_version=%BM_PARAM_VISUALSTUDIO_VERSION%
if "%BM_CMD_DEBUG_LEVEL%" GEQ "2" @echo [DEBUG\%~nx0][set_vs_build_environment]: setting version as !_vs_version!
if /I "%_vs_version%"=="latest" (
    set _version_search=-latest
) else (
    set _version_search=-version %_vs_version%
)
if "%BM_CMD_DEBUG_LEVEL%" GEQ "2" @echo [DEBUG\%~nx0][set_vs_build_environment]: set version as !_vs_version!

@REM If vswhere.exe is not found we skip this section as it doesn't effect operation.
if NOT EXIST "%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe" (
    if "%BM_CMD_DEBUG_LEVEL%" GEQ "2" @echo [DEBUG:%~nx0] "%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe" not found.
    set __vscmd_vswhere_path=
) else (
    set "__vscmd_vswhere_path=%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\"
)

if not "!__vscmd_vswhere_path!"=="" (
    if "%BM_CMD_DEBUG_LEVEL%" GEQ "2" @echo [DEBUG\%~nx0][set_vs_build_environment]: will search for version !_version_search! using !__vscmd_vswhere_path!

    pushd "!__vscmd_vswhere_path!"
    for /f "usebackq delims=" %%i in (`vswhere.exe !_version_search! -property installationPath`) do (

    if "%BM_CMD_DEBUG_LEVEL%" GEQ "2" @echo [DEBUG\%~nx0][set_vs_build_environment]: set environment as %%i\!_vs_build_env_relative_path!
        if exist "%%i\!_vs_build_env_relative_path!" (
            "%%i\!_vs_build_env_relative_path!"
            set __vscmd_vswhere_path=
        )
    )
    popd
)

set _vs_build_env_type=
set _vs_build_env_relative_path=
set _vs_version=
set _version_search=

if "%BM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][set_vs_build_environment][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------
@REM ******************** [END] UTILITY FUNCTIONS ***************************