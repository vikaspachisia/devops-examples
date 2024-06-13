@ECHO OFF

@REM ******************** [BEGIN] MAIN **************************************
@REM ------------------------------------------------------------------------
:module
setlocal EnableDelayedExpansion

if not defined DM_CMD_DEBUG_LEVEL (set DM_CMD_DEBUG_LEVEL=%CMD_DEBUG_LEVEL%)
if not defined DO_NOT_RESET_ERRORLEVEL (set ERRORLEVEL=0)

call :main %*

set DM_CMD_DEBUG_LEVEL=

endlocal
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:main
if "%DM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][main][begin]: %*

call :initialize

if ERRORLEVEL 0 (call :parse_commandline_args %*)
if ERRORLEVEL 0 (call :validate_commands)
if ERRORLEVEL 0 (call :validate_parameters)
if ERRORLEVEL 0 (call :execute_commands)

call :uninitialize

if "%DM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][main][end]: result %ERRORLEVEL%
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:initialize
if "%DM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][initialize][begin]: %*

if "%CMD_DEBUG_LEVEL%" GEQ "4" @set

call :initialize_environment
call :initialize_enums
call :initialize_commands
call :initialize_parameters
call :initialize_variables

if "%DM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][initialize][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:uninitialize
if "%DM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][uninitialize][begin]: %*

if "%CMD_DEBUG_LEVEL%" GEQ "4" @set

call :uninitialize_variables
call :uninitialize_parameters
call :uninitialize_commands
call :uninitialize_enums
call :uninitialize_environment

if "%DM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][uninitialize][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:initialize_environment
if "%DM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][initialize_environment][begin]: %*

set THIS_WINDOW_CURRENT_TITLE=Command Prompt %~nx0
REM for /f "usebackq delims=" %%t in (`powershell -noprofile -c "[Console]::Title.Replace(' - '+[Environment]::CommandLine,'')"`) do set THIS_WINDOW_CURRENT_TITLE=%%t
@TITLE Distribution Manager

if "%DM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][initialize_environment][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:uninitialize_environment
if "%DM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][uninitialize_environment][begin]: %*

@TITLE %THIS_WINDOW_CURRENT_TITLE%
set THIS_WINDOW_CURRENT_TITLE=

if "%DM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][uninitialize_environment][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:initialize_enums
if "%DM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][initialize_enums][begin]: %*

REM NOOP

if "%DM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][initialize_enums][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:uninitialize_enums
if "%DM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][uninitialize_enums][begin]: %*

REM NOOP

if "%DM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][uninitialize_enums][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:initialize_commands
if "%DM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][initialize_commands][begin]: %*

set DM_CMD_HELP=0
set DM_CMD_CLEAN=0
set DM_CMD_BUILD=0
set DM_CMD_REBUILD=0

if "%DM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][initialize_commands][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:uninitialize_commands
if "%DM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][uninitialize_commands][begin]: %*

set DM_CMD_HELP=
set DM_CMD_CLEAN=
set DM_CMD_BUILD=
set DM_CMD_REBUILD=

if "%DM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][uninitialize_commands][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:initialize_parameters
if "%DM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][initialize_parameters][begin]: %*

set DM_PARAM_SOLUTION_FILEPATH=..\..\..\devops-examples.sln
set DM_PARAM_VERSION_FILEPATH=..\..\..\shared\common\version.h
set DM_PARAM_ZIPTOOLS_7ZIP_TOOL_PATH=..\..\..\tools\ziptools\7z2201-extra

set DM_PARAM_OUTDIR_PATH=..\..\outputs\builtfiles\bin

set DM_PARAM_BLDDIR_PATH=..\..\outputs\builtfiles
set DM_PARAM_STGDIR_PATH=..\..\outputs\stagefiles
set DM_PARAM_DSTDIR_PATH=..\..\outputs\distfiles

set DM_PARAM_TARGET_CONFIGURATIONS=Release
set DM_PARAM_TARGET_ARCHITECTURES=x64

if "%DM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][initialize_parameters][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:uninitialize_parameters
if "%DM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][uninitialize_parameters][begin]: %*

set DM_PARAM_SOLUTION_FILEPATH=
set DM_PARAM_VERSION_FILEPATH=
set DM_PARAM_ZIPTOOLS_7ZIP_TOOL_PATH=

set DM_PARAM_OUTDIR_PATH=

set DM_PARAM_BLDDIR_PATH=
set DM_PARAM_STGDIR_PATH=
set DM_PARAM_DSTDIR_PATH=

set DM_PARAM_TARGET_CONFIGURATIONS=
set DM_PARAM_TARGET_ARCHITECTURES=

if "%DM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][uninitialize_parameters][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:initialize_variables
if "%DM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][initialize_variables][begin]: %*

set DM_VARS_COMMAND_VALID=0
set DM_VARS_COMMAND_PARAMS_VALID=0

set DM_VARS_VERSION_STRING=*.*.*.0
set DM_VARS_VERSION_STRING_PARTS=* * * 0

if "%DM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][initialize_variables][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:uninitialize_variables
if "%DM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][uninitialize_variables][begin]: %*

set DM_VARS_COMMAND_VALID=
set DM_VARS_COMMAND_PARAMS_VALID=

set DM_VARS_VERSION_STRING=
set DM_VARS_VERSION_STRING_PARTS=

if "%DM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][uninitialize_variables][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------
@REM ******************** [END] MAIN ****************************************


@REM ******************** [BEGIN] COMMAND MANAGEMENT ************************
@REM ------------------------------------------------------------------------
:parse_commandline_args
if "%DM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][parse_commandline_args][begin]: %*

call ArgumentManager.bat /set_environment %*
call :parse_commandline_arg %*
call ArgumentManager.bat /reset_environment

if "%DM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][parse_commandline_args][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:parse_commandline_arg
if "%DM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][parse_commandline_arg][begin]: %*

call :parse_commands %*
call :parse_parameters %*
call :parse_variables %*

if "%DM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][parse_commandline_arg][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:parse_commands
if "%DM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][parse_commands][begin]: %*

set DM_CMD_HELP=%AM_ENV_CMD_HELP%
set DM_CMD_CLEAN=%AM_ENV_CMD_CLEAN%
set DM_CMD_BUILD=%AM_ENV_CMD_BUILD%
set DM_CMD_REBUILD=%AM_ENV_CMD_REBUILD%

if "%DM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][parse_commands][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:parse_parameters
if "%DM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][parse_parameters][begin]: %*

set DM_PARAM_SOLUTION_FILEPATH=%AM_ENV_SOURCES_PATH%\%AM_ENV_SOURCE_SOLUTION_FILENAME%
set DM_PARAM_VERSION_FILEPATH=%AM_ENV_SHARED_COMMON_PATH%\%AM_ENV_SOURCE_VERSION_FILENAME%
set DM_PARAM_ZIPTOOLS_7ZIP_TOOL_PATH=%AM_ENV_TOOLS_ZIPTOOLS_7ZIP_TOOL_PATH%

set DM_PARAM_OUTDIR_PATH=%AM_ENV_OUTDIR_PATH%

set DM_PARAM_BLDDIR_PATH=%AM_ENV_BLDDIR_PATH%
set DM_PARAM_STGDIR_PATH=%AM_ENV_STGDIR_PATH%
set DM_PARAM_DSTDIR_PATH=%AM_ENV_DSTDIR_PATH%

set DM_PARAM_TARGET_CONFIGURATIONS=%AM_ENV_TARGET_CONFIGURATIONS%
set DM_PARAM_TARGET_ARCHITECTURES=%AM_ENV_TARGET_ARCHITECTURES%

if "%DM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][parse_parameters][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:parse_variables
if "%DM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][parse_variables][begin]: %*

set __vm_cmd_debug_level=%VM_CMD_DEBUG_LEVEL%
set VM_CMD_DEBUG_LEVEL=0
for /f "useback delims=*" %%v in (`VersionManager /get_version /filepath^=%DM_PARAM_VERSION_FILEPATH%`) do (set DM_VARS_VERSION_STRING=%%v)
for /f "useback delims=*" %%v in (`VersionManager /get_version_parts /version^=%DM_VARS_VERSION_STRING%`) do (set DM_VARS_VERSION_STRING_PARTS=%%v)
set VM_CMD_DEBUG_LEVEL=%__vm_cmd_debug_level%

if "%DM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][parse_variables][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:validate_commands
if "%DM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][validate_commands][begin]: %*

set /A __local_cmd_count=0

if "%DM_CMD_HELP%"=="1" (set /A __local_cmd_count+=1)
if "%DM_CMD_CLEAN%"=="1" (set /A __local_cmd_count+=1)
if "%DM_CMD_BUILD%"=="1" (set /A __local_cmd_count+=1)
if "%DM_CMD_REBUILD%"=="1" (set /A __local_cmd_count+=1)

if "%__local_cmd_count%" NEQ "1" (
   if "%DM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [ERROR\%~nx0][validate_commands]: cannot identify the command to run. command count=%__local_cmd_count%
   set __local_cmd_count=
   set DM_VARS_COMMAND_VALID=0
   exit /B 22
) else (
    set DM_VARS_COMMAND_VALID=1
)

set __local_cmd_count=

if "%DM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][validate_commands][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:validate_parameters
if "%DM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][validate_parameters][begin]: %*

set /A __local_param_valid=1
set /A __validate_dstdir_path=0
set /A __validate_stgdir_path=0

if "%BM_CMD_CLEAN%"=="1" (set __validate_dstdir_path=1)
if "%BM_CMD_BUILD%"=="1" (set __validate_stgdir_path=1)
if "%BM_CMD_REBUILD%"=="1" (set __validate_stgdir_path=1)

if "%__validate_dstdir_path%"=="1" (
     if not exist "%DM_PARAM_DSTDIR_PATH%" (
        set __local_param_valid=0
        if "%DM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [ERROR\%~nx0][validate_parameters]: cannot find '%DM_PARAM_DSTDIR_PATH%'.
    )
)

if "%__validate_stgdir_path%"=="1" (
    if not exist "%DM_PARAM_STGDIR_PATH%" (
        set __local_param_valid=0
        if "%DM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [ERROR\%~nx0][validate_parameters]: cannot find '%DM_PARAM_STGDIR_PATH%'.
    )
)

if "%AM_VARS_ENUM_PARAMS_VALID%"=="0" (
    set __local_param_valid=0
)

if "%__local_param_valid%" NEQ "1" (
   if "%DM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [ERROR\%~nx0][validate_parameters]: cannot find the parameters for the command to run.
   set __local_param_valid=
   set __validate_dstdir_path=
   set __validate_stgdir_path=
   set DM_VARS_COMMAND_PARAMS_VALID=0
   exit /B 87
) else (
    set DM_VARS_COMMAND_PARAMS_VALID=1
)

set __local_param_valid=
set __validate_dstdir_path=
set __validate_stgdir_path=

if "%DM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][validate_parameters][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:execute_commands
if "%DM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][execute_commands][begin]: %*

set /A __local_cmd_count=0

if !DM_VARS_COMMAND_VALID! EQU 1 (
    if !DM_VARS_COMMAND_PARAMS_VALID! EQU 1 (
        if "%DM_CMD_HELP%"=="1" (set /A __local_cmd_count+=1 & call :print_help)
        if "%DM_CMD_CLEAN%"=="1" (set /A __local_cmd_count+=1 & call :clean_targets)
        if "%DM_CMD_BUILD%"=="1" (set /A __local_cmd_count+=1 & call :build_targets)
        if "%DM_CMD_REBUILD%"=="1" (set /A __local_cmd_count+=1 & call :rebuild_targets)
    ) else (
        if "%DM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [ERROR\%~nx0][execute_commands]: Command parameters are not valid.
    )
) else (
    if "%DM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [ERROR\%~nx0][execute_commands]: No valid command found.
)

if "!__local_cmd_count!" NEQ "1" (
   if "%DM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [ERROR\%~nx0][execute_commands]: No command found to execute. try "%~nx0 -help" for help.
   set __local_cmd_count=
   exit /B 22
)

set __local_cmd_count=

if "%DM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][execute_commands][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------
@REM ******************** [END] COMMAND MANAGEMENT **************************

@REM ******************** [BEGIN] COMMAND IMPLEMENTATION ********************
@REM ------------------------------------------------------------------------
:print_help
if "%DM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][print_help][begin]: %*

call ArgumentManager.bat /print_help

if "%DM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][print_help][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:clean_targets
if "%DM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][clean_targets][begin]: %*

if "%DM_CMD_DEBUG_LEVEL%" GEQ "2" @echo [DEBUG\%~nx0][clean_targets]: removing %DM_PARAM_DSTDIR_PATH%...

@echo rmdir /s /q "%DM_PARAM_DSTDIR_PATH%"

if "%DM_CMD_DEBUG_LEVEL%" GEQ "2" @echo [DEBUG\%~nx0][clean_targets]: removed %DM_PARAM_DSTDIR_PATH%.

if "%DM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][clean_targets][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:build_targets
if "%DM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][build_targets][begin]: %*

call :run_distribute_files

if "%DM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][build_targets][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:rebuild_targets
if "%DM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][rebuild_targets][begin]: %*

call :clean_targets
call :build_targets

if "%DM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][rebuild_targets][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------
@REM ******************** [END] COMMAND IMPLEMENTATION **********************

@REM ******************** [BEGIN] UTILITY FUNCTIONS *************************
@REM ------------------------------------------------------------------------
:run_distribute_files
if "%DM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][run_distribute_files][begin]: %*
setlocal EnableDelayedExpansion

call :run_target_configurations "%DM_PARAM_TARGET_CONFIGURATIONS%" "%DM_PARAM_TARGET_ARCHITECTURES%" "distribute_files"

endlocal
if "%DM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][run_distribute_files][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:run_target_configurations
if "%DM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][run_target_configurations][begin]: %*
setlocal EnableDelayedExpansion

set _target_configurations=%~1
set _target_architectures=%~2
for /f "tokens=1,2,*" %%a in (%*) do (set _custom_parameters=%%~c)

:iterate_target_configurations
@for /F "tokens=1,* delims=;" %%a in ("%_target_configurations%") do (
    if "%DM_CMD_DEBUG_LEVEL%" GEQ "3" @echo [DEBUG\%~nx0][run_target_configurations]: configuration=%%a
    
    call :run_target_architectures "%%a" "%_target_architectures%" "%_custom_parameters%"
    
    set _target_configurations=%%b
    goto :iterate_target_configurations
)

set _custom_parameters=
set _target_architectures=
set _target_configurations=

endlocal
if "%DM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][run_target_configurations][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:run_target_architectures
if "%DM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][run_target_architectures][begin]: %*
setlocal EnableDelayedExpansion

set _target_configuration=%~1
set _target_architectures=%~2
for /f "tokens=1,2,*" %%a in (%*) do (set _custom_parameters=%%~c)

:iterate_target_architectures
@for /F "tokens=1,* delims=;" %%a in ("%_target_architectures%") do (
    if "%DM_CMD_DEBUG_LEVEL%" GEQ "3" @echo [DEBUG\%~nx0][run_target_architectures]: configuration=%_target_configuration%, architecture=%%a
    
    call :run_target_command "%_target_configuration%" "%%a" "%_custom_parameters%"
    
    set _target_architectures=%%b
    goto :iterate_target_architectures
)

set _custom_parameters=
set _target_architectures=
set _target_configurations=

endlocal
if "%DM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][run_target_architectures][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:run_target_command
if "%DM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][run_target_command][begin]: %*
setlocal EnableDelayedExpansion

set _target_configuration=%~1
set _target_architecture=%~2
set _command=%~3
for /f "tokens=1,2,3,*" %%a in (%*) do (set _command_parameters=%%~d)

if /I "%_command%"=="distribute_files" (
    call :distribute_files "%_target_configuration%" "%_target_architecture%" "%_command_parameters%"
)

set _command_parameters=
set _command=
set _target_architecture=
set _target_configuration=

endlocal
if "%DM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][run_target_command][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:create_component_list
if "%DM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][create_component_list][begin]: %*

set _components[0].name=Module1
set _components[0].category=sdk
set _components[1].name=Module2
set _components[1].category=sdk

set _components_count=2

if "%DM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][create_component_list][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:exception_list
if "%DM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][exception_list][begin]: %*

set _exception_package[Module2]=true

if "%DM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][exception_list][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:destroy_component_list
if "%DM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][destroy_component_list][begin]: %*

set _components=
set _components_count=

if "%DM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][destroy_component_list][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:destroy_exception_list
if "%DM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][destroy_exception_list][begin]: %*

set _exception_package=

if "%DM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][destroy_exception_list][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:distribute_files
if "%DM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][distribute_files][begin]: %*
setlocal EnableDelayedExpansion

set _target_configuration=%~1
set _target_architecture=%~2
if /I "%_target_architecture%"=="x86" (set _target_architecture_bitness=32)
if /I "%_target_architecture%"=="x64" (set _target_architecture_bitness=64)
set _version_string=%DM_VARS_VERSION_STRING%

set _dstdir_root_path=%DM_PARAM_DSTDIR_PATH%
set _zip_tool_filepath=%DM_PARAM_ZIPTOOLS_7ZIP_TOOL_PATH%\x64\7za.exe

if not exist "%_dstdir_root_path%" (
    if "%DM_CMD_DEBUG_LEVEL%" GEQ "2" @echo [DEBUG\%~nx0][distribute_files]: creating %_dstdir_root_path%...
    @mkdir "%_dstdir_root_path%"
    if "%DM_CMD_DEBUG_LEVEL%" GEQ "2" @echo [DEBUG\%~nx0][distribute_files]: created %_dstdir_root_path%.
)

call :create_component_list
call :exception_list
set /A _components_last_index=%_components_count% - 1
for /l %%i in (0,1,%_components_last_index%) do (
    call set _component_name=%%_components[%%i].name%%
    call set _package_exclusion=%%_exception_package[!_component_name!]%%
    set _package_exclusion_flag=!_package_exclusion!

        if defined _package_exclusion_flag (
            set _component_archive_name=!_component_name!.zip
            set _component_archive_pdb_name=!_component_name!_pdb.zip
        ) else (
            set _component_archive_name=!_component_name!%_target_architecture_bitness%_%_version_string%.zip
            set _component_archive_pdb_name=!_component_name!_pdb%_target_architecture_bitness%_%_version_string%.zip
        )

        set _component_stgdir_path=%DM_PARAM_STGDIR_PATH%\!_component_name!

        set _component_stgdir_bin_path=!_component_stgdir_path!\%_target_configuration%\%_target_architecture%
        set _component_stgdir_bin_pdb_path=!_component_stgdir_path!_pdb\%_target_configuration%\%_target_architecture%
        set _component_dstdir_path=%DM_PARAM_DSTDIR_PATH%\
        set _component_dst_archive_name=!_component_dstdir_path!\!_component_archive_name!
        set _component_dst_archive_pdb_name=!_component_dstdir_path!\!_component_archive_pdb_name!
    	echo "checking", !_component_stgdir_pdb_path!, !_component_stgdir_bin_pdb_paths!

        if "%DM_CMD_DEBUG_LEVEL%" GEQ "2" @echo [DEBUG\%~nx0][distribute_files]: zipping !_component_stgdir_path! as !_component_archive_name!...
        "%_zip_tool_filepath%" a -tzip -w"!_component_dstdir_path!" "!_component_dst_archive_name!" "!_component_stgdir_bin_path!\*"
        "%_zip_tool_filepath%" a -tzip -w"!_component_dstdir_path!" "!_component_dst_archive_pdb_name!" "!_component_stgdir_bin_pdb_path!\*"
        if "%DM_CMD_DEBUG_LEVEL%" GEQ "3" @echo [DEBUG\%~nx0][distribute_files]: zipped !_component_stgdir_path! as !_component_archive_name!.

    set _component_name=
    set _component_archive_name=
    set _component_stgdir_path=
    set _component_dstdir_path=
    set _component_dst_archive_name=
    set _package_exclusion=
    set _package_exclusion_flag=
)
set _components_last_index=
call :destroy_component_list
call :destroy_exception_list

set _target_configuration=
set _target_architecture=
set _target_architecture_bitness=
set _version_string=

set _dstdir_root_path=
set _zip_tool_filepath=

endlocal
if "%DM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][distribute_files][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------
@REM ******************** [END] UTILITY FUNCTIONS ***************************