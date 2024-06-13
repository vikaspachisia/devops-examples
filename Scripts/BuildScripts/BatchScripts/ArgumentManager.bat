@ECHO OFF

@REM ******************** [BEGIN] MAIN **************************************
@REM ------------------------------------------------------------------------
:module
rem setlocal EnableDelayedExpansion

if not defined AM_CMD_DEBUG_LEVEL (set AM_CMD_DEBUG_LEVEL=%CMD_DEBUG_LEVEL%)
if not defined DO_NOT_RESET_ERRORLEVEL (set ERRORLEVEL=0)

call :main %*

set AM_CMD_DEBUG_LEVEL=

rem endlocal
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:main
if "%AM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][main][begin]: %*

call :initialize

if ERRORLEVEL 0 (call :parse_commandline_args %*)
if ERRORLEVEL 0 (call :validate_commands)
if ERRORLEVEL 0 (call :validate_parameters)
if ERRORLEVEL 0 (call :execute_commands)

call :uninitialize

if "%AM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][main][end]: result %ERRORLEVEL%
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:initialize
if "%AM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][initialize][begin]: %*

if "%CMD_DEBUG_LEVEL%" GEQ "4" @set

call :initialize_environment
call :initialize_enums
call :initialize_commands
call :initialize_parameters
call :initialize_variables

if "%AM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][initialize][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:uninitialize
if "%AM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][uninitialize][begin]: %*

if "%CMD_DEBUG_LEVEL%" GEQ "4" @set

call :uninitialize_variables
call :uninitialize_parameters
call :uninitialize_commands
call :uninitialize_enums
call :uninitialize_environment

if "%AM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][uninitialize][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:initialize_environment
if "%AM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][initialize_environment][begin]: %*

set THIS_WINDOW_CURRENT_TITLE=Command Prompt %~nx0
REM for /f "usebackq delims=" %%t in (`powershell -noprofile -c "[Console]::Title.Replace(' - '+[Environment]::CommandLine,'')"`) do set THIS_WINDOW_CURRENT_TITLE=%%t
@TITLE Argument Manager

if "%AM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][initialize_environment][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:uninitialize_environment
if "%AM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][uninitialize_environment][begin]: %*

@TITLE %THIS_WINDOW_CURRENT_TITLE%
set THIS_WINDOW_CURRENT_TITLE=

if "%AM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][uninitialize_environment][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:initialize_enums
if "%AM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][initialize_enums][begin]: %*

set AM_ENUM_SOURCE_ENVIRONMENTS=DEV;DEVOPS
set AM_ENUM_SOURCE_BUILD_HOSTS=IDE;CONSOLE

set AM_ENUM_TARGET_ENVIRONMENTS=DEV;STAGE;PROD
set AM_ENUM_TARGET_CONFIGURATIONS=Debug;Release
set AM_ENUM_TARGET_ARCHITECTURES=x86;x64
set AM_ENUM_TARGET_RELEASE_IDENTIFIERS=PRERELEASE;RELEASE
set AM_ENUM_TARGET_SIGN_TYPES=None;LocalSign;ServerSign

set AM_ENUM_QUALITY_ANALYSIS_TOOLS=Coverity
set AM_ENUM_QUALITY_TEST_TOOLS=CPPUnit;BullsEye

set AM_ENUM_YES_NO=Yes;No

if "%AM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][initialize_enums][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:uninitialize_enums
if "%AM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][uninitialize_enums][begin]: %*

set AM_ENUM_SOURCE_ENVIRONMENTS=
set AM_ENUM_SOURCE_BUILD_HOSTS=

set AM_ENUM_TARGET_ENVIRONMENTS=
set AM_ENUM_TARGET_CONFIGURATIONS=
set AM_ENUM_TARGET_ARCHITECTURES=
set AM_ENUM_TARGET_RELEASE_IDENTIFIERS=
set AM_ENUM_TARGET_SIGN_TYPES=

set AM_ENUM_QUALITY_ANALYSIS_TOOLS=
set AM_ENUM_QUALITY_TEST_TOOLS=

set AM_ENUM_YES_NO=

if "%AM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][uninitialize_enums][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:initialize_commands
if "%AM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][initialize_commands][begin]: %*

set AM_CMD_PRINT_HELP=0
set AM_CMD_SET_ENVIRONMENT=0
set AM_CMD_RESET_ENVIRONMENT=0

if "%AM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][initialize_commands][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:uninitialize_commands
if "%AM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][uninitialize_commands][begin]: %*

set AM_CMD_PRINT_HELP=
set AM_CMD_SET_ENVIRONMENT=
set AM_CMD_RESET_ENVIRONMENT=

if "%AM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][uninitialize_commands][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:initialize_parameters
if "%AM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][initialize_parameters][begin]: %*

set AM_PARAM_KV_WORKING_DIR_PATH=
set __am_param_kv_working_dir_canonical_path=%~dp0..\..\..\
for %%i in ("%__am_param_kv_working_dir_canonical_path%") do set "AM_PARAM_KV_WORKING_DIR_PATH=%%~fi"
call :remove_last_backslash AM_PARAM_KV_WORKING_DIR_PATH
set __am_param_kv_working_dir_canonical_path=

set AM_PARAM_KV_OUTPUTS_DIR_PATH=
set __am_param_kv_outputs_dir_canonical_path=%~dp0..\..\..\outputs
for %%i in ("%__am_param_kv_outputs_dir_canonical_path%") do set "AM_PARAM_KV_OUTPUTS_DIR_PATH=%%~fi"
call :remove_last_backslash AM_PARAM_KV_OUTPUTS_DIR_PATH
set __am_param_kv_outputs_dir_canonical_path=

set AM_PARAM_KV_SOURCE_ENVIRONMENT=DEVOPS
set AM_PARAM_KV_SOURCE_BUILD_HOST=CONSOLE
set AM_PARAM_KV_SOURCE_SOLUTION_FILENAME=devops-examples.sln
set AM_PARAM_KV_SOURCE_VERSION_FILENAMES=Version.h;Version.cs

set AM_PARAM_KV_TARGET_ENVIRONMENT=DEV
set AM_PARAM_KV_TARGET_CONFIGURATIONS=%AM_ENUM_TARGET_CONFIGURATIONS%
set AM_PARAM_KV_TARGET_ARCHITECTURES=%AM_ENUM_TARGET_ARCHITECTURES%
set AM_PARAM_KV_TARGET_RELEASE_IDENTIFIER=PRERELEASE
set AM_PARAM_KV_TARGET_SIGN_TYPE=LocalSign

set AM_PARAM_KV_QUALITY_ANALYSIS_TOOLS=%AM_ENUM_QUALITY_ANALYSIS_TOOLS%
set AM_PARAM_KV_QUALITY_TEST_TOOLS=%AM_ENUM_QUALITY_TEST_TOOLS%
set AM_PARAM_KV_QUALITY_COVERITY_FILENAME=devops-examples.cov
set AM_PARAM_KV_QUALITY_COVERITY_LOGFILENAME=%AM_PARAM_KV_QUALITY_COVERITY_FILENAME%.log

set AM_PARAM_KV_PRODUCT_NAME=DevopsExamples
set AM_PARAM_KV_PRODUCT_ID=1

set AM_PARAM_KV_SIGN_SERVER_HOSTNAME=sign-server
set AM_PARAM_KV_SIGN_TOOL_FILENAME=signtool.exe
set AM_PARAM_KV_SIGN_CERTIFICATE_FILENAME=devops_private_test_cert.pfx

set AM_PARAM_KV_UPDATE_BINARIES=Yes
set AM_PARAM_KV_UPDATE_SETTINGS=Yes

set AM_PARAM_KV_VISUALSTUDIO_VERSION=17

set AM_PARAM_CMD_HELP=0

set AM_PARAM_CMD_PREBUILD=0
set AM_PARAM_CMD_POSTBUILD=0
set AM_PARAM_CMD_CLEAN=0
set AM_PARAM_CMD_BUILD=0
set AM_PARAM_CMD_REBUILD=0

set AM_PARAM_CMD_PREQUALITYCHECK=0
set AM_PARAM_CMD_POSTQUALITYCHECK=0
set AM_PARAM_CMD_ANALYZE=0
set AM_PARAM_CMD_TEST=0

if "%AM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][initialize_parameters][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:uninitialize_parameters
if "%AM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][uninitialize_parameters][begin]: %*

set AM_PARAM_KV_WORKING_DIR_PATH=
set AM_PARAM_KV_OUTPUTS_DIR_PATH=

set AM_PARAM_KV_SOURCE_ENVIRONMENT=
set AM_PARAM_KV_SOURCE_BUILD_HOST=
set AM_PARAM_KV_SOURCE_SOLUTION_FILENAME=
set AM_PARAM_KV_SOURCE_VERSION_FILENAME=

set AM_PARAM_KV_TARGET_ENVIRONMENT=
set AM_PARAM_KV_TARGET_CONFIGURATIONS=
set AM_PARAM_KV_TARGET_ARCHITECTURES=
set AM_PARAM_KV_TARGET_RELEASE_IDENTIFIER=
set AM_PARAM_KV_TARGET_SIGN_TYPE=

set AM_PARAM_KV_QUALITY_ANALYSIS_TOOLS=
set AM_PARAM_KV_QUALITY_TEST_TOOLS=
set AM_PARAM_KV_QUALITY_COVERITY_FILENAME=
set AM_PARAM_KV_QUALITY_COVERITY_LOGFILENAME=

set AM_PARAM_KV_PRODUCT_NAME=
set AM_PARAM_KV_PRODUCT_ID=

set AM_PARAM_KV_SIGN_SERVER_HOSTNAME=
set AM_PARAM_KV_SIGN_TOOL_FILENAME=
set AM_PARAM_KV_SIGN_CERTIFICATE_FILENAME=

set AM_PARAM_KV_UPDATE_BINARIES=
set AM_PARAM_KV_UPDATE_SETTINGS=

set AM_PARAM_KV_VISUALSTUDIO_VERSION=

set AM_PARAM_CMD_HELP=

set AM_PARAM_CMD_PREBUILD=
set AM_PARAM_CMD_POSTBUILD=
set AM_PARAM_CMD_CLEAN=
set AM_PARAM_CMD_BUILD=
set AM_PARAM_CMD_REBUILD=

set AM_PARAM_CMD_PREQUALITYCHECK=
set AM_PARAM_CMD_POSTQUALITYCHECK=
set AM_PARAM_CMD_ANALYZE=
set AM_PARAM_CMD_TEST=

if "%AM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][uninitialize_parameters][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:initialize_variables
if "%AM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][initialize_variables][begin]: %*

set AM_VARS_COMMAND_VALID=0
set AM_VARS_COMMAND_PARAMS_VALID=0
set AM_VARS_ENUM_PARAMS_VALID=0

if "%AM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][initialize_variables][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:uninitialize_variables
if "%AM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][uninitialize_variables][begin]: %*

set AM_VARS_COMMAND_VALID=
set AM_VARS_COMMAND_PARAMS_VALID=
set AM_VARS_ENUM_PARAMS_VALID=

if "%AM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][uninitialize_variables][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------
@REM ******************** [END] MAIN ****************************************


@REM ******************** [BEGIN] COMMAND MANAGEMENT ************************
@REM ------------------------------------------------------------------------
:parse_commandline_args
if "%AM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][parse_commandline_args][begin]: %*

set /A __local_parse_error_count=0

set "__CMDLINE_ARGS_LIST=%*"
:iterate_cmd_args_list
@for /F "tokens=1,* delims= " %%a in ("%__CMDLINE_ARGS_LIST%") do (
    if "%AM_CMD_DEBUG_LEVEL%" GEQ "3" @echo [DEBUG\%~nx0][parse_commandline_args]: current arg '%%a'
    @for /F "tokens=1,2 delims==" %%1 in ("%%a") do (
        if "%AM_CMD_DEBUG_LEVEL%" GEQ "3" @echo [DEBUG\%~nx0][parse_commandline_args]: current kv '%%1=%%2'
        call :parse_commandline_arg %%1 %%2
    )
    set "__CMDLINE_ARGS_LIST=%%b"
    goto :iterate_cmd_args_list
)
set "__CMDLINE_ARGS_LIST="

if "!__local_parse_error_count!" NEQ "0" (
   if "%AM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [ERROR\%~nx0][parse_commandline_args]: errorcount=!__local_parse_error_count!.
   set __local_parse_error_count=
   exit /B 22
)

set __local_parse_error_count=

if "%AM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][parse_commandline_args][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:parse_commandline_arg
if "%AM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][parse_commandline_arg][begin]: %*

if "%~2"=="" (
    if "%AM_CMD_DEBUG_LEVEL%" GEQ "2" @echo [DEBUG\%~nx0][parse_commandline_arg]: parse command... '%~1'
    call :parse_command %%1
    if "%AM_CMD_DEBUG_LEVEL%" GEQ "2" @echo [DEBUG\%~nx0][parse_commandline_arg]: parsed command... '%~1'
) else (
    if "%AM_CMD_DEBUG_LEVEL%" GEQ "2" @echo [DEBUG\%~nx0][parse_commandline_arg]: parse parameter... '%~1=%~2'
    call :parse_parameter %%1 %%2
    if "%AM_CMD_DEBUG_LEVEL%" GEQ "2" @echo [DEBUG\%~nx0][parse_commandline_arg]: parsed parameter... '%~1=%~2'
)

if "%AM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][parse_commandline_arg][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:parse_command
if "%AM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][parse_command][begin]: %*

set __local_arg_found=

@REM ## Commands processed by this module ##

@REM help requestes will be delegated to print_help in second invocation.
@REM -- /print_help --
if /I "%1"=="-print_help" (
    set "AM_CMD_PRINT_HELP=1"
    set "__local_arg_found=1"
)
if /I "%1"=="/print_help" (
    set "AM_CMD_PRINT_HELP=1"
    set "__local_arg_found=1"
)

@REM -- /set_environment --
if /I "%1"=="-set_environment" (
    set "AM_CMD_SET_ENVIRONMENT=1"
    set "__local_arg_found=1"
)
if /I "%1"=="/set_environment" (
    set "AM_CMD_SET_ENVIRONMENT=1"
    set "__local_arg_found=1"
)
@REM -- /reset_environment --
if /I "%1"=="-reset_environment" (
    set "AM_CMD_RESET_ENVIRONMENT=1"
    set "__local_arg_found=1"
)
if /I "%1"=="/reset_environment" (
    set "AM_CMD_RESET_ENVIRONMENT=1"
    set "__local_arg_found=1"
)

@REM ## Commands processed by main modules ##

@REM -- /help -- command for main modules
if /I "%1"=="-help" (
    set "AM_PARAM_CMD_HELP=1"
    set "__local_arg_found=1"
)
if /I "%1"=="/help" (
    set "AM_PARAM_CMD_HELP=1"
    set "__local_arg_found=1"
)
if /I "%1"=="-?" (
    set "AM_PARAM_CMD_HELP=1"
    set "__local_arg_found=1"
)
if /I "%1"=="/?" (
    set "AM_PARAM_CMD_HELP=1"
    set "__local_arg_found=1"
)

@REM -- /prebuild --
if /I "%1"=="-prebuild" (
    set "AM_PARAM_CMD_PREBUILD=1"
    set "__local_arg_found=1"
)
if /I "%1"=="/prebuild" (
    set "AM_PARAM_CMD_PREBUILD=1"
    set "__local_arg_found=1"
)

@REM -- /postbuild --
if /I "%1"=="-postbuild" (
    set "AM_PARAM_CMD_POSTBUILD=1"
    set "__local_arg_found=1"
)
if /I "%1"=="/postbuild" (
    set "AM_PARAM_CMD_POSTBUILD=1"
    set "__local_arg_found=1"
)

@REM -- /clean --
if /I "%1"=="-clean" (
    set "AM_PARAM_CMD_CLEAN=1"
    set "__local_arg_found=1"
)
if /I "%1"=="/clean" (
    set "AM_PARAM_CMD_CLEAN=1"
    set "__local_arg_found=1"
)

@REM -- /build --
if /I "%1"=="-build" (
    set "AM_PARAM_CMD_BUILD=1"
    set "__local_arg_found=1"
)
if /I "%1"=="/build" (
    set "AM_PARAM_CMD_BUILD=1"
    set "__local_arg_found=1"
)

@REM -- /rebuild --
if /I "%1"=="-rebuild" (
    set "AM_PARAM_CMD_REBUILD=1"
    set "__local_arg_found=1"
)
if /I "%1"=="/rebuild" (
    set "AM_PARAM_CMD_REBUILD=1"
    set "__local_arg_found=1"
)

@REM -- /prequalitycheck --
if /I "%1"=="-prequalitycheck" (
    set "AM_PARAM_CMD_PREQUALITYCHECK=1"
    set "__local_arg_found=1"
)
if /I "%1"=="/prequalitycheck" (
    set "AM_PARAM_CMD_PREQUALITYCHECK=1"
    set "__local_arg_found=1"
)

@REM -- /postqualitycheck --
if /I "%1"=="-postqualitycheck" (
    set "AM_PARAM_CMD_POSTQUALITYCHECK=1"
    set "__local_arg_found=1"
)
if /I "%1"=="/postqualitycheck" (
    set "AM_PARAM_CMD_POSTQUALITYCHECK=1"
    set "__local_arg_found=1"
)

@REM -- /analyze --
if /I "%1"=="-analyze" (
    set "AM_PARAM_CMD_ANALYZE=1"
    set "__local_arg_found=1"
)
if /I "%1"=="/analyze" (
    set "AM_PARAM_CMD_ANALYZE=1"
    set "__local_arg_found=1"
)

@REM -- /test --
if /I "%1"=="-test" (
    set "AM_PARAM_CMD_TEST=1"
    set "__local_arg_found=1"
)
if /I "%1"=="/test" (
    set "AM_PARAM_CMD_TEST=1"
    set "__local_arg_found=1"
)

if "%__local_arg_found%" NEQ "1" (
   if "%AM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [ERROR\%~nx0][parse_command]: Could not find command: '%1'. Argument will be ignored.
   set /A __local_parse_error_count=__local_parse_error_count+1
   set __local_arg_found=
   exit /B 87
)

set __local_arg_found=

if "%AM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][parse_command][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:parse_parameter
if "%AM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][parse_parameter]: %*

set __local_arg_found=

@REM -- /working_dir --
if /I "%1"=="-working_dir" (
    set "AM_PARAM_KV_WORKING_DIR_PATH=%2"
    set "__local_arg_found=1"
)
if /I "%1"=="/working_dir" (
    set "AM_PARAM_KV_WORKING_DIR_PATH=%2"
    set "__local_arg_found=1"
)

@REM -- /outputs_dir --
if /I "%1"=="-outputs_dir" (
    set "AM_PARAM_KV_OUTPUTS_DIR_PATH=%2"
    set "__local_arg_found=1"
)
if /I "%1"=="/outputs_dir" (
    set "AM_PARAM_KV_OUTPUTS_DIR_PATH=%2"
    set "__local_arg_found=1"
)

@REM -- /source_environment --
if /I "%1"=="-source_environment" (
    set "AM_PARAM_KV_SOURCE_ENVIRONMENT=%2"
    set "__local_arg_found=1"
)
if /I "%1"=="/source_environment" (
    set "AM_PARAM_KV_SOURCE_ENVIRONMENT=%2"
    set "__local_arg_found=1"
)

@REM -- /source_build_host --
if /I "%1"=="-source_build_host" (
    set "AM_PARAM_KV_SOURCE_BUILD_HOST=%2"
    set "__local_arg_found=1"
)
if /I "%1"=="/source_build_host" (
    set "AM_PARAM_KV_SOURCE_BUILD_HOST=%2"
    set "__local_arg_found=1"
)

@REM -- /source_solution_filename --
if /I "%1"=="-source_solution_filename" (
    set "AM_PARAM_KV_SOURCE_SOLUTION_FILENAME=%2"
    set "__local_arg_found=1"
)
if /I "%1"=="/source_solution_filename" (
    set "AM_PARAM_KV_SOURCE_SOLUTION_FILENAME=%2"
    set "__local_arg_found=1"
)

@REM -- /source_version_filename --
if /I "%1"=="-source_version_filename" (
    set "AM_PARAM_KV_SOURCE_VERSION_FILENAME=%2"
    set "__local_arg_found=1"
)
if /I "%1"=="/source_version_filename" (
    set "AM_PARAM_KV_SOURCE_VERSION_FILENAME=%2"
    set "__local_arg_found=1"
)

@REM -- /target_environment --
if /I "%1"=="-target_environment" (
    set "AM_PARAM_KV_TARGET_ENVIRONMENT=%2"
    set "__local_arg_found=1"
)
if /I "%1"=="/target_environment" (
    set "AM_PARAM_KV_TARGET_ENVIRONMENT=%2"
    set "__local_arg_found=1"
)

@REM -- /target_configurations --
if /I "%1"=="-target_configurations" (
    set "AM_PARAM_KV_TARGET_CONFIGURATIONS=%2"
    call :normalize_list_items AM_PARAM_KV_TARGET_CONFIGURATIONS
    set "__local_arg_found=1"
)
if /I "%1"=="/target_configurations" (
    set "AM_PARAM_KV_TARGET_CONFIGURATIONS=%2"
    call :normalize_list_items AM_PARAM_KV_TARGET_CONFIGURATIONS
    set "__local_arg_found=1"
)

@REM -- /target_architectures --
if /I "%1"=="-target_architectures" (
    set "AM_PARAM_KV_TARGET_ARCHITECTURES=%2"
    call :normalize_list_items AM_PARAM_KV_TARGET_ARCHITECTURES
    set "__local_arg_found=1"
)
if /I "%1"=="/target_architectures" (
    set "AM_PARAM_KV_TARGET_ARCHITECTURES=%2"
    call :normalize_list_items AM_PARAM_KV_TARGET_ARCHITECTURES
    set "__local_arg_found=1"
)

@REM -- /target_release_identifier --
if /I "%1"=="-target_release_identifier" (
    set "AM_PARAM_KV_TARGET_RELEASE_IDENTIFIER=%2"
    set "__local_arg_found=1"
)
if /I "%1"=="/target_release_identifier" (
    set "AM_PARAM_KV_TARGET_RELEASE_IDENTIFIER=%2"
    set "__local_arg_found=1"
)

@REM -- /target_sign_type --
if /I "%1"=="-target_sign_type" (
    set "AM_PARAM_KV_TARGET_SIGN_TYPE=%2"
    set "__local_arg_found=1"
)
if /I "%1"=="/target_sign_type" (
    set "AM_PARAM_KV_TARGET_SIGN_TYPE=%2"
    set "__local_arg_found=1"
)

@REM -- /analysis_tools --
if /I "%1"=="-analysis_tools" (
    set "AM_PARAM_KV_QUALITY_ANALYSIS_TOOLS=%2"
    call :normalize_list_items AM_PARAM_KV_QUALITY_ANALYSIS_TOOLS
    set "__local_arg_found=1"
)
if /I "%1"=="/analysis_tools" (
    set "AM_PARAM_KV_QUALITY_ANALYSIS_TOOLS=%2"
    call :normalize_list_items AM_PARAM_KV_QUALITY_ANALYSIS_TOOLS
    set "__local_arg_found=1"
)

@REM -- /test_tools --
if /I "%1"=="-test_tools" (
    set "AM_PARAM_KV_QUALITY_TEST_TOOLS=%2"
    call :normalize_list_items AM_PARAM_KV_QUALITY_TEST_TOOLS
    set "__local_arg_found=1"
)
if /I "%1"=="/test_tools" (
    set "AM_PARAM_KV_QUALITY_TEST_TOOLS=%2"
    call :normalize_list_items AM_PARAM_KV_QUALITY_TEST_TOOLS
    set "__local_arg_found=1"
)

@REM -- /coverity_filename --
if /I "%1"=="-coverity_filename" (
    set "AM_PARAM_KV_QUALITY_COVERITY_FILENAME=%2"
    set "__local_arg_found=1"
)
if /I "%1"=="/coverity_filename" (
    set "AM_PARAM_KV_QUALITY_COVERITY_FILENAME=%2"
    set "__local_arg_found=1"
)
@REM -- /coverity_logfilename --
if /I "%1"=="-coverity_logfilename" (
    set "AM_PARAM_KV_QUALITY_COVERITY_LOGFILENAME=%2"
    set "__local_arg_found=1"
)
if /I "%1"=="/coverity_logfilename" (
    set "AM_PARAM_KV_QUALITY_COVERITY_LOGFILENAME=%2"
    set "__local_arg_found=1"
)

@REM -- /product_name --
if /I "%1"=="-product_name" (
    set "AM_PARAM_KV_PRODUCT_NAME=%2"
    set "__local_arg_found=1"
)
if /I "%1"=="/product_name" (
    set "AM_PARAM_KV_PRODUCT_NAME=%2"
    set "__local_arg_found=1"
)

@REM -- /product_id --
if /I "%1"=="-product_id" (
    set "AM_PARAM_KV_PRODUCT_ID=%2"
    set "__local_arg_found=1"
)
if /I "%1"=="/product_id" (
    set "AM_PARAM_KV_PRODUCT_ID=%2"
    set "__local_arg_found=1"
)

@REM -- /sign_server_hostname --
if /I "%1"=="-sign_server_hostname" (
    set "AM_PARAM_KV_SIGN_SERVER_HOSTNAME=%2"
    set "__local_arg_found=1"
)
if /I "%1"=="/sign_server_hostname" (
    set "AM_PARAM_KV_SIGN_SERVER_HOSTNAME=%2"
    set "__local_arg_found=1"
)

@REM -- /sign_tool_filename --
if /I "%1"=="-sign_tool_filename" (
    set "AM_PARAM_KV_SIGN_TOOL_FILENAME=%2"
    set "__local_arg_found=1"
)
if /I "%1"=="/sign_tool_filename" (
    set "AM_PARAM_KV_SIGN_TOOL_FILENAME=%2"
    set "__local_arg_found=1"
)

@REM -- /sign_certificate_filename --
if /I "%1"=="-sign_certificate_filename" (
    set "AM_PARAM_KV_SIGN_CERTIFICATE_FILENAME=%2"
    set "__local_arg_found=1"
)
if /I "%1"=="/sign_certificate_filename" (
    set "AM_PARAM_KV_SIGN_CERTIFICATE_FILENAME=%2"
    set "__local_arg_found=1"
)

@REM -- /update_model_binaries --
if /I "%1"=="-update_model_binaries" (
    set "AM_PARAM_KV_UPDATE_MODEL_BINARIES=%2"
    set "__local_arg_found=1"
)
if /I "%1"=="/update_model_binaries" (
    set "AM_PARAM_KV_UPDATE_MODEL_BINARIES=%2"
    set "__local_arg_found=1"
)

@REM -- /update_model_settings --
if /I "%1"=="-update_model_settings" (
    set "AM_PARAM_KV_UPDATE_MODEL_SETTINGS=%2"
    set "__local_arg_found=1"
)
if /I "%1"=="/update_model_settings" (
    set "AM_PARAM_KV_UPDATE_MODEL_SETTINGS=%2"
    set "__local_arg_found=1"
)

@REM -- /vs_version --
if /I "%1"=="-vs_version" (
    set "AM_PARAM_KV_VISUALSTUDIO_VERSION=%2"
    set "__local_arg_found=1"
)
if /I "%1"=="/vs_version" (
    set "AM_PARAM_KV_VISUALSTUDIO_VERSION=%2"
    set "__local_arg_found=1"
)

if "%__local_arg_found%" NEQ "1" (
   if "%AM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [ERROR\%~nx0][parse_parameter]: Could not find parameter: '%1'=='%2'. Argument will be ignored.
   set /A __local_parse_error_count=__local_parse_error_count+1
   set __local_arg_found=
   exit /B 87
)

set __local_arg_found=

if "%AM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][parse_parameter][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:validate_commands
if "%AM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][validate_commands][begin]: %*

set /A __local_cmd_count=0

if "%AM_CMD_PRINT_HELP%"=="1" (set /A __local_cmd_count+=1)
if "%AM_CMD_SET_ENVIRONMENT%"=="1" (set /A __local_cmd_count+=1)
if "%AM_CMD_RESET_ENVIRONMENT%"=="1" (set /A __local_cmd_count+=1)

if "%__local_cmd_count%" NEQ "1" (
   if "%AM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [ERROR\%~nx0][validate_commands]: cannot identify the command to run. command count=%__local_cmd_count%
   set __local_cmd_count=
   set AM_VARS_COMMAND_VALID=0
   exit /B 22
) else (
    set AM_VARS_COMMAND_VALID=1
)

set __local_cmd_count=

if "%AM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][validate_commands][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:validate_parameters
if "%AM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][validate_parameters][begin]: %*

set /A __local_param_valid=1
set /A __options_found_in_enum=1 

@REM Validate enum parameters so that chosen options are one among the supported options.
call :validate_options_in_enum "%AM_PARAM_KV_SOURCE_ENVIRONMENT%" AM_ENUM_SOURCE_ENVIRONMENTS
if "!__options_found_in_enum!"=="0" (set "__local_param_valid=0" & set "AM_VARS_ENUM_PARAMS_VALID=0")
call :validate_options_in_enum "%AM_PARAM_KV_SOURCE_BUILD_HOST%" AM_ENUM_SOURCE_BUILD_HOSTS
if "!__options_found_in_enum!"=="0" (set "__local_param_valid=0" & set "AM_VARS_ENUM_PARAMS_VALID=0")
call :validate_options_in_enum "%AM_PARAM_KV_TARGET_ENVIRONMENT%" AM_ENUM_TARGET_ENVIRONMENTS
if "!__options_found_in_enum!"=="0" (set "__local_param_valid=0" & set "AM_VARS_ENUM_PARAMS_VALID=0")
call :validate_options_in_enum "%AM_PARAM_KV_TARGET_CONFIGURATIONS%" AM_ENUM_TARGET_CONFIGURATIONS
if "!__options_found_in_enum!"=="0" (set "__local_param_valid=0" & set "AM_VARS_ENUM_PARAMS_VALID=0")
call :validate_options_in_enum "%AM_PARAM_KV_TARGET_ARCHITECTURES%" AM_ENUM_TARGET_ARCHITECTURES
if "!__options_found_in_enum!"=="0" (set "__local_param_valid=0" & set "AM_VARS_ENUM_PARAMS_VALID=0")
call :validate_options_in_enum "%AM_PARAM_KV_TARGET_RELEASE_IDENTIFIER%" AM_ENUM_TARGET_RELEASE_IDENTIFIERS
if "!__options_found_in_enum!"=="0" (set "__local_param_valid=0" & set "AM_VARS_ENUM_PARAMS_VALID=0")
call :validate_options_in_enum "%AM_PARAM_KV_TARGET_SIGN_TYPE%" AM_ENUM_TARGET_SIGN_TYPES
if "!__options_found_in_enum!"=="0" (set "__local_param_valid=0" & set "AM_VARS_ENUM_PARAMS_VALID=0")
call :validate_options_in_enum "%AM_PARAM_KV_QUALITY_ANALYSIS_TOOLS%" AM_ENUM_QUALITY_ANALYSIS_TOOLS
if "!__options_found_in_enum!"=="0" (set "__local_param_valid=0" & set "AM_VARS_ENUM_PARAMS_VALID=0")
call :validate_options_in_enum "%AM_PARAM_KV_QUALITY_TEST_TOOLS%" AM_ENUM_QUALITY_TEST_TOOLS
if "!__options_found_in_enum!"=="0" (set "__local_param_valid=0" & set "AM_VARS_ENUM_PARAMS_VALID=0")
call :validate_options_in_enum "%AM_PARAM_KV_UPDATE_MODEL_BINARIES%" AM_ENUM_YES_NO
if "!__options_found_in_enum!"=="0" (set "__local_param_valid=0" & set "AM_VARS_ENUM_PARAMS_VALID=0")
call :validate_options_in_enum "%AM_PARAM_KV_UPDATE_MODEL_SETTINGS%" AM_ENUM_YES_NO
if "!__options_found_in_enum!"=="0" (set "__local_param_valid=0" & set "AM_VARS_ENUM_PARAMS_VALID=0")

if "%__local_param_valid%" NEQ "1" (
   if "%AM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [ERROR\%~nx0][validate_parameters]: cannot find the parameters for the command to run.
   set __local_param_valid=
   set AM_VARS_COMMAND_PARAMS_VALID=0
   exit /B 87
) else (
    set AM_VARS_COMMAND_PARAMS_VALID=1
)

set __options_found_in_enum=
set __local_param_valid=

if "%AM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][validate_parameters][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:execute_commands
if "%AM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][execute_commands][begin]: %*

set /A __local_cmd_count=0

if !AM_VARS_COMMAND_VALID! EQU 1 (
    if !AM_VARS_COMMAND_PARAMS_VALID! EQU 1 (
        if "%AM_CMD_PRINT_HELP%"=="1" (set /A __local_cmd_count+=1 & call :print_help)
        if "%AM_CMD_SET_ENVIRONMENT%"=="1" (set /A __local_cmd_count+=1 & call :set_environment)
        if "%AM_CMD_RESET_ENVIRONMENT%"=="1" (set /A __local_cmd_count+=1 & call :reset_environment)
    ) else (
        if "%AM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [ERROR\%~nx0][execute_commands]: Command parameters are not valid.
    )
) else (
    if "%AM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [ERROR\%~nx0][execute_commands]: No valid command found.
)

if "!__local_cmd_count!" NEQ "1" (
   if "%AM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [ERROR\%~nx0][execute_commands]: No command found to execute. try "%~nx0 -print_help" for help.
   set __local_cmd_count=
   exit /B 22
)

set __local_cmd_count=

if "%AM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][execute_commands][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------
@REM ******************** [END] COMMAND MANAGEMENT **************************

@REM ******************** [BEGIN] COMMAND IMPLEMENTATION ********************
@REM ------------------------------------------------------------------------
:print_help
if "%AM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][print_help][begin]: %*

@echo .
@echo ** Command and Argument Manager **
@echo .
@echo Syntax: [module] [command] [arguments]

@echo.
@echo [module] :
@echo     -BuildEventManager  		: Clean, Prebuild, or Postbuild the source code.
@echo     -BuildManager        		: Clean, Build, or Rebuild the source code.
@echo     -QualityManager      		: Run quality tools on the binaries or distribution. e.g. CPPUnit, BullsEye, Coverity etc.
@echo     -DistributionEventManager : Clean, Prebuild, or Postbuild the stage or distribution. e.g. devops-examples etc.
@echo     -DistributionManager      : Clean, Build, or Rebuild the distribution. e.g. devops-examples etc.

@echo.
@echo [command] :
@echo     -help       : Prints this help message.
@echo     -clean      : Runs clean action on the source (soultion file), distribution package etc.
@echo     -prebuild   : Runs prebuild action on the source, distribution package etc.
@echo     -build      : Runs build action on the source (soultion file), distribution package etc.
@echo     -rebuild    : Runs rebuild action on the source (soultion file), distribution package etc. 
@echo                   Can perform additional steps as pre and post events.
@echo     -postbuild  : Runs postbuild action on the binaries, distribution packages etc.
@echo     -analyze    : Runs quality tools to analyze the code quality and identify issues if any. e.g. Coverity
@echo     -test       : Runs quality tools to test the code and identify issues if any. e.g. CPPUnit

@echo.
@echo [parameters] :
@echo     -source_environment=[choose environment] : Build process may vary based on the environment in which it is being built.
@echo            ## DEVOPS [default]: Some processes may change. e.g. by default use production signing instead of test signing. 
@echo            ## DEV : Some processes may change. e.g. skip pre and post event as meta changes might not be required.
@echo     -source_build_host=[choose build host] : Build process may vary based on the hosting app.
@echo            ## CONSOLE [default]: Some processes may change. e.g. perform silent build or fail. 
@echo            ## IDE : Some processes may change. e.g. perform interactive build and continue.
@echo     -source_solution_filename=[solution filename] : The solution name that will be compiled.
@echo            ## devops-examples.sln [default] : Main solution that will build devops-examples and more.
@echo     -source_version_filename=[version filename] : The version filename that will be used for version extraction.
@echo            ## Version.h [default] : main file that will then supply the version information to other components.
@echo     -target_environment=[choose target environment] : The environment in which the code will be run.
@echo            ## DEV [default] : environment for developers such as local dev machine.
@echo            ## STAGE : environment for intermediate deployment.
@echo            ## PROD : environment for final deployment and that will be used by customers.
@echo     -target_configurations=[choose target configurations] : Semicolon seperated list of configurations to generate binaries.
@echo            ## Release [default]
@echo            ## Debug [default]
@echo     -target_architectures=[choose target architectures] : Semicolon seperated list of architectures to generate binaries.
@echo            ## x86 [default]
@echo            ## x64 [default]
@echo     -target_release_identifier=[choose release type] : For whom or what is the release being created.
@echo            ## QA [default]  	: Build for QA. Release to QA for initial verification.
@echo            ## STAGE			: Build for staging. Release to QA and other stake holders.
@echo            ## PROD    		: Build for customers. Release to world.
@echo     -target_sign_type=[choose target sign type] : What signtool, framework must be used for signing.
@echo            ## None [default]  : Do not sign. Someone else is taking care of it or signing is not required.
@echo            ## LocalSign       : Use local signtool and certificates for signing.
@echo            ## ServerSign      : Use server signtool and certificates for signing.
@echo     -analysis_tools=[choose analysis tools] : Semicolon seperated list of tools.
@echo            ## Coverity : Perform static analysis using coverity tool.
@echo     -test_tools=[choose test tools] : Semicolon seperated list of tools.
@echo            ## CPPUnit  : Perform unit tests using CPP Unit test tool.
@echo            ## BullsEye : Perform component tests using Bullseye test framework.
@echo     -product_name=[product name] : The product name that may be used for things like naming distribution package, folders etc.
@echo     -product_id=[product id] : The product id that may be used for things like naming distribution package, folders etc.
@echo     -sign_server_hostname=[hostname] : The server on which distribution packages will be signed.
@echo     -sign_certificate_filename=[certificate filename] : The certificate that can be used for signing. This file must be present in tools folder.
@echo     -update_model_binaries=[choose yes/no] : Should model binaries be updated. The model can be an AI model or a software component.
@echo            ## Yes [default]  : Generate bin files for models.
@echo            ## No : Use the existing bin files. Skip generating new files.
@echo     -update_model_settings=[choose yes/no] : Should model settings be updated. The model can be an AI model or a software component.
@echo            ## Yes [default]  : Update settings in sources.
@echo            ## No : Use the existing settings. Skip generating new settings.

@echo.
@echo     Note: make sure to invoke %~nx0 with delayed expansion.
@echo           That is let the caller execute "setlocal EnableDelayedExpansion" before calling %~nx0.

if "%AM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][print_help][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:set_environment
if "%AM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][set_environment][begin]: %*

@REM set supplied parameters as environment variables
set AM_ENV_WORKING_DIR_PATH=%AM_PARAM_KV_WORKING_DIR_PATH%
set AM_ENV_OUTPUTSDIR_PATH=%AM_PARAM_KV_OUTPUTS_DIR_PATH%

set AM_ENV_SOURCE_ENVIRONMENT=%AM_PARAM_KV_SOURCE_ENVIRONMENT%
set AM_ENV_SOURCE_BUILD_HOST=%AM_PARAM_KV_SOURCE_BUILD_HOST%
set AM_ENV_SOURCE_SOLUTION_FILENAME=%AM_PARAM_KV_SOURCE_SOLUTION_FILENAME%
set AM_ENV_SOURCE_VERSION_FILENAME=%AM_PARAM_KV_SOURCE_VERSION_FILENAME%

set AM_ENV_TARGET_ENVIRONMENT=%AM_PARAM_KV_TARGET_ENVIRONMENT%
set AM_ENV_TARGET_CONFIGURATIONS=%AM_PARAM_KV_TARGET_CONFIGURATIONS%
set AM_ENV_TARGET_ARCHITECTURES=%AM_PARAM_KV_TARGET_ARCHITECTURES%
set AM_ENV_TARGET_RELEASE_IDENTIFIER=%AM_PARAM_KV_TARGET_RELEASE_IDENTIFIER%
set AM_ENV_TARGET_SIGN_TYPE=%AM_PARAM_KV_TARGET_SIGN_TYPE%

set AM_ENV_QUALITY_ANALYSIS_TOOLS=%AM_PARAM_KV_QUALITY_ANALYSIS_TOOLS%
set AM_ENV_QUALITY_TEST_TOOLS=%AM_PARAM_KV_QUALITY_TEST_TOOLS%
set AM_ENV_QUALITY_COVERITY_FILENAME=%AM_PARAM_KV_QUALITY_COVERITY_FILENAME%
set AM_ENV_QUALITY_COVERITY_LOGFILENAME=%AM_PARAM_KV_QUALITY_COVERITY_LOGFILENAME%

set AM_ENV_PRODUCT_NAME=%AM_PARAM_KV_PRODUCT_NAME%
set AM_ENV_PRODUCT_ID=%AM_PARAM_KV_PRODUCT_ID%

set AM_ENV_SIGN_SERVER_HOSTNAME=%AM_PARAM_KV_SIGN_SERVER_HOSTNAME%
set AM_ENV_SIGN_TOOL_FILENAME=%AM_PARAM_KV_SIGN_TOOL_FILENAME%
set AM_ENV_SIGN_CERTIFICATE_FILENAME=%AM_PARAM_KV_SIGN_CERTIFICATE_FILENAME%

set AM_ENV_UPDATE_MODEL_BINARIES=%AM_PARAM_KV_UPDATE_MODEL_BINARIES%
set AM_ENV_UPDATE_MODEL_SETTINGS=%AM_PARAM_KV_UPDATE_MODEL_SETTINGS%

set AM_ENV_VISUALSTUDIO_VERSION=%AM_PARAM_KV_VISUALSTUDIO_VERSION%

set AM_ENV_CMD_HELP=%AM_PARAM_CMD_HELP%

set AM_ENV_CMD_PREBUILD=%AM_PARAM_CMD_PREBUILD%
set AM_ENV_CMD_POSTBUILD=%AM_PARAM_CMD_POSTBUILD%
set AM_ENV_CMD_CLEAN=%AM_PARAM_CMD_CLEAN%
set AM_ENV_CMD_BUILD=%AM_PARAM_CMD_BUILD%
set AM_ENV_CMD_REBUILD=%AM_PARAM_CMD_REBUILD%

set AM_ENV_CMD_PREQUALITYCHECK=%AM_PARAM_CMD_PREQUALITYCHECK%
set AM_ENV_CMD_POSTQUALITYCHECK=%AM_PARAM_CMD_POSTQUALITYCHECK%
set AM_ENV_CMD_ANALYZE=%AM_PARAM_CMD_ANALYZE%
set AM_ENV_CMD_TEST=%AM_PARAM_CMD_TEST%

@REM set derived variables as environment variables
set AM_ENV_COMMAND_VALID=AM_VARS_COMMAND_VALID
set AM_ENV_COMMAND_PARAMS_VALID=AM_VARS_COMMAND_PARAMS_VALID
set AM_ENV_ENUM_PARAMS_VALID=AM_VARS_ENUM_PARAMS_VALID

set AM_ENV_DOCS_PATH=%AM_ENV_WORKING_DIR_PATH%\docs
set AM_ENV_PACKAGES_PATH=%AM_ENV_WORKING_DIR_PATH%\packages
set AM_ENV_SOURCES_PATH=%AM_ENV_WORKING_DIR_PATH%\sources
set AM_ENV_TOOLS_PATH=%AM_ENV_WORKING_DIR_PATH%\tools

set AM_ENV_SOURCES_APPS_PATH=%AM_ENV_SOURCES_PATH%\apps
set AM_ENV_SOURCES_SCRIPTS_PATH=%AM_ENV_SOURCES_PATH%\scripts
set AM_ENV_SOURCES_SDK_PATH=%AM_ENV_SOURCES_PATH%\sdk
set AM_ENV_SOURCES_SERVICES_PATH=%AM_ENV_SOURCES_PATH%\services
set AM_ENV_SOURCES_SHARED_PATH=%AM_ENV_SOURCES_PATH%\shared
set AM_ENV_SOURCES_TESTS_PATH=%AM_ENV_SOURCES_PATH%\tests

set AM_ENV_TOOLS_SIGNTOOLS_PATH=%AM_ENV_TOOLS_PATH%\SignTools
set AM_ENV_TOOLS_ZIPTOOLS_PATH=%AM_ENV_TOOLS_PATH%\ZipTools
set AM_ENV_TOOLS_ZIPTOOLS_7ZIP_TOOL_PATH=%AM_ENV_TOOLS_PATH%\ZipTools\7z2201-extra

set AM_ENV_SCRIPTS_DB_PATH=%AM_ENV_SOURCES_SCRIPTS_PATH%\DB
set AM_ENV_SCRIPTS_DEVOPS_PATH=%AM_ENV_SOURCES_SCRIPTS_PATH%\Devops

set AM_ENV_SDK_MODULE1_PATH=%AM_ENV_SOURCES_SDK_PATH%\module1
set AM_ENV_SDK_MODULE2_PATH=%AM_ENV_SOURCES_SDK_PATH%\module2
set AM_ENV_SDK_MODULE3_PATH=%AM_ENV_SOURCES_SDK_PATH%\module3
set AM_ENV_SDK_MODULE4_PATH=%AM_ENV_SOURCES_SDK_PATH%\module4

set AM_ENV_SHARED_COMMON_PATH=%AM_ENV_SOURCES_SHARED_PATH%\common
set AM_ENV_SHARED_PUBLIC_PATH=%AM_ENV_SOURCES_SHARED_PATH%\public
set AM_ENV_SHARED_CONFIG_PATH=%AM_ENV_SOURCES_SHARED_PATH%\config
set AM_ENV_SHARED_MANIFEST_PATH=%AM_ENV_SHARED_CONFIG_PATH%\ManifestFiles

set AM_ENV_TESTS_CPPUNITTEST_PATH=%AM_ENV_SOURCES_TESTS_PATH%\CppUnitTest
set AM_ENV_TESTS_BULLSEYE_PATH=%AM_ENV_SOURCES_TESTS_PATH%\BullsEye

set AM_ENV_OUTPUTS_PATH=%AM_ENV_SOURCES_PATH%\outputs
set AM_ENV_BUILTFILES_PATH=%AM_ENV_OUTPUTS_PATH%\builtfiles
set AM_ENV_BUILTFILES_INC_PATH=%AM_ENV_BUILTFILES_PATH%\include
set AM_ENV_BUILTFILES_BIN_PATH=%AM_ENV_BUILTFILES_PATH%\bin
set AM_ENV_BUILTFILES_INT_PATH=%AM_ENV_BUILTFILES_PATH%\int
set AM_ENV_STAGEFILES_PATH=%AM_ENV_OUTPUTS_PATH%\stagefiles
set AM_ENV_DISTFILES_PATH=%AM_ENV_OUTPUTS_PATH%\distfiles
set AM_ENV_REPORTFILES_PATH=%AM_ENV_OUTPUTS_PATH%\reportfiles

set AM_ENV_INTDIR_PATH=%AM_ENV_BUILTFILES_INT_PATH%
set AM_ENV_OUTDIR_PATH=%AM_ENV_BUILTFILES_BIN_PATH%

set AM_ENV_BLDDIR_PATH=%AM_ENV_BUILTFILES_PATH%
set AM_ENV_STGDIR_PATH=%AM_ENV_STAGEFILES_PATH%
set AM_ENV_DSTDIR_PATH=%AM_ENV_DISTFILES_PATH%
set AM_ENV_RPTDIR_PATH=%AM_ENV_REPORTFILES_PATH%

if "%AM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][set_environment][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:reset_environment
if "%AM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][reset_environment][begin]: %*

@REM reset supplied parameters and remove environment variables
set AM_ENV_WORKING_DIR_PATH=

set AM_ENV_SOURCE_ENVIRONMENT=
set AM_ENV_SOURCE_BUILD_HOST=
set AM_ENV_SOURCE_SOLUTION_FILENAME=
set AM_ENV_SOURCE_VERSION_FILENAME=

set AM_ENV_TARGET_ENVIRONMENT=
set AM_ENV_TARGET_CONFIGURATIONS=
set AM_ENV_TARGET_ARCHITECTURES=
set AM_ENV_TARGET_RELEASE_IDENTIFIER=

set AM_ENV_QUALITY_ANALYSIS_TOOLS=
set AM_ENV_QUALITY_TEST_TOOLS=

set AM_ENV_PRODUCT_NAME=
set AM_ENV_PRODUCT_ID=

set AM_ENV_SIGN_SERVER_HOSTNAME=
set AM_ENV_SIGN_CERTIFICATE_FILENAME=

set AM_ENV_ENABLE_PRE_EVENT=
set AM_ENV_ENABLE_POST_EVENT=

set AM_ENV_UPDATE_MODEL_BINARIES=
set AM_ENV_UPDATE_MODEL_SETTINGS=

set AM_ENV_VISUALSTUDIO_VERSION=

set AM_ENV_CMD_HELP=
set AM_ENV_CMD_CLEAN=
set AM_ENV_CMD_BUILD=
set AM_ENV_CMD_REBUILD=
set AM_ENV_CMD_ANALYZE=
set AM_ENV_CMD_TEST=

@REM reset derived variable and remove environment variables
set AM_ENV_COMMAND_VALID=
set AM_ENV_COMMAND_PARAMS_VALID=
set AM_ENV_ENUM_PARAMS_VALID=

set AM_ENV_DOCS_PATH=
set AM_ENV_PACKAGES_PATH=
set AM_ENV_SOURCES_PATH=
set AM_ENV_TOOLS_PATH=

set AM_ENV_SOURCES_APPS_PATH=
set AM_ENV_SOURCES_SCRIPTS_PATH=
set AM_ENV_SOURCES_SDK_PATH=
set AM_ENV_SOURCES_SERVICES_PATH=
set AM_ENV_SOURCES_SHARED_PATH=
set AM_ENV_SOURCES_TESTS_PATH=

set AM_ENV_TOOLS_SIGNTOOLS_PATH=
set AM_ENV_TOOLS_ZIPTOOLS_PATH=
set AM_ENV_TOOLS_ZIPTOOLS_7ZIP_TOOL_PATH=

set AM_ENV_SCRIPTS_DB_PATH=
set AM_ENV_SCRIPTS_DEVOPS_PATH=

set AM_ENV_SDK_MODULE1_PATH=
set AM_ENV_SDK_MODULE2_PATH=
set AM_ENV_SDK_MODULE3_PATH=
set AM_ENV_SDK_MODULE4_PATH=

set AM_ENV_SHARED_COMMON_PATH=
set AM_ENV_SHARED_PUBLIC_PATH=
set AM_ENV_SHARED_CONFIG_PATH=
set AM_ENV_SHARED_MANIFEST_PATH=

set AM_ENV_TESTS_CPPUNITTEST_PATH=
set AM_ENV_TESTS_BULLSEYE_PATH=

set AM_ENV_OUTPUTS_PATH=
set AM_ENV_BUILTFILES_PATH=
set AM_ENV_BUILTFILES_INC_PATH=
set AM_ENV_BUILTFILES_BIN_PATH=
set AM_ENV_BUILTFILES_INT_PATH=
set AM_ENV_STAGEFILES_PATH=
set AM_ENV_DISTFILES_PATH=
set AM_ENV_REPORTFILES_PATH=

set AM_ENV_INTDIR_PATH=
set AM_ENV_OUTDIR_PATH=

set AM_ENV_BLDDIR_PATH=
set AM_ENV_STGDIR_PATH=
set AM_ENV_DSTDIR_PATH=
set AM_ENV_RPTDIR_PATH=

if "%AM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][reset_environment][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ******************** [END] COMMAND IMPLEMENTATION **********************

@REM ******************** [BEGIN] UTILITY FUNCTIONS *************************
@REM ------------------------------------------------------------------------
@REM call :normalize_list_items <list name>
@REM Removes trailing semi-colons from semi-colon separated list variable
:normalize_list_items
if "%AM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][normalize_list_items][begin]: %*

set "__NORMALIZE_VAR=%1"
call set "__NORMALIZE_VAR_CONTENT=%%%__NORMALIZE_VAR%%%"

if "%__NORMALIZE_VAR_CONTENT:~-1%"==";" (
    set "%__NORMALIZE_VAR%=%__NORMALIZE_VAR_CONTENT:~0,-1%"
)

set "__NORMALIZE_VAR="
set "__NORMALIZE_VAR_CONTENT="

if "%AM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][normalize_list_items][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
@REM call :remove_last_backslash <path>
@REM Removes trailing backslash from path
:remove_last_backslash
if "%AM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][remove_last_backslash][begin]: %*

set "__NORMALIZE_VAR=%1"
call set "__NORMALIZE_VAR_CONTENT=%%%__NORMALIZE_VAR%%%"

if "%__NORMALIZE_VAR_CONTENT:~-1%"=="\" (
    set "%__NORMALIZE_VAR%=%__NORMALIZE_VAR_CONTENT:~0,-1%"
)

set "__NORMALIZE_VAR="
set "__NORMALIZE_VAR_CONTENT="

if "%AM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][remove_last_backslash][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
@REM call :validate_options_in_enum <options_to_check> <allowed_options_in_enum>
@REM Tests if the options chosen for the argument is valid or not.
@REM Checks against the list of allowed options defined in enum.
:validate_options_in_enum
if "%AM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][validate_options_in_enum][begin]: %*

set /A __local_options_found_in_enum=1
set /A __option_found_in_enum=1

set "_options_to_validate=%~1"
set "_enum_options_var=%2"
call set "_enum_options_content=%%%_enum_options_var%%%"

if "%AM_CMD_DEBUG_LEVEL%" GEQ "3" (
    @echo [DEBUG\%~nx0][validate_options_in_enum]: _options_to_validate=%_options_to_validate%
    @echo [DEBUG\%~nx0][validate_options_in_enum]: _enum_options_var=%_enum_options_var%
    @echo [DEBUG\%~nx0][validate_options_in_enum]: _enum_options_content=%_enum_options_content%
)

:iterate_options_in_param
@for /F "tokens=1,* delims=;" %%a in ("%_options_to_validate%") do (
    if "%AM_CMD_DEBUG_LEVEL%" GEQ "3" @echo [DEBUG\%~nx0][validate_options_in_enum]: current token: '%%a'
    call :validate_option_in_enum %%a %2
    if "!__option_found_in_enum!"=="1" (
        if "%AM_CMD_DEBUG_LEVEL%" GEQ "3" @echo [DEBUG\%~nx0][validate_options_in_enum]: token %%a matched.
    ) else (
        if "%AM_CMD_DEBUG_LEVEL%" GEQ "3" @echo [DEBUG\%~nx0][validate_options_in_enum]: token %%a did not match. Error in input.
        set /A __local_options_found_in_enum=0
    )
    set "_options_to_validate=%%b"
    goto :iterate_options_in_param
)

if "%__local_options_found_in_enum%"=="0" (
    if "%AM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [ERROR\%~nx0][validate_options_in_enum]: Invalid command argument options found: '%~1'.
)
set /A __options_found_in_enum=%__local_options_found_in_enum%

set __option_found_in_enum=
set __local_options_found_in_enum=
set _options_to_validate=
set _enum_options_var=
set _enum_options_content=

if "%AM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][validate_options_in_enum][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
@REM call :validate_option_in_enum <option_to_check> <allowed_options_in_enum>
@REM Tests if the option chosen for the argument is valid or not.
@REM Checks against the list of allowed options defined in enum.
:validate_option_in_enum
if "%AM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][validate_option_in_enum][begin]: %*
set /A __local_option_found_in_enum=0

set "_option_to_validate=%1"
set "_enum_options_var=%2"
call set "_enum_options_content=%%%_enum_options_var%%%"

if "%AM_CMD_DEBUG_LEVEL%" GEQ "3" (
    @echo [DEBUG\%~nx0][validate_option_in_enum]: _option_to_validate=%_option_to_validate%
    @echo [DEBUG\%~nx0][validate_option_in_enum]: _enum_options_var=%_enum_options_var%
    @echo [DEBUG\%~nx0][validate_option_in_enum]: _enum_options_content=%_enum_options_content%
)

:iterate_options_in_enum
@for /F "tokens=1,* delims=;" %%a in ("%_enum_options_content%") do (
    if "%AM_CMD_DEBUG_LEVEL%" GEQ "3" @echo [DEBUG\%~nx0][validate_option_in_enum]: current token: '%%a'
    if /I "%_option_to_validate%"=="%%a" (
        set /A __local_option_found_in_enum=1
        if "%AM_CMD_DEBUG_LEVEL%" GEQ "3" @echo [DEBUG\%~nx0][validate_option_in_enum]: token %%a matched.
    ) else (
        set "_enum_options_content=%%b"
        if "%AM_CMD_DEBUG_LEVEL%" GEQ "3" @echo [DEBUG\%~nx0][validate_option_in_enum]: token %%a did not match. Check next token.
        goto :iterate_options_in_enum
    )
)

if "%__local_option_found_in_enum%"=="0" (
   if "%AM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [ERROR\%~nx0][validate_option_in_enum]: Invalid command argument option found: '%_option_to_validate%'.
   set /A __option_found_in_enum=0
)

set __local_option_found_in_enum=
set _option_to_validate=
set _enum_options_var=
set _enum_options_content=

if "%AM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][validate_option_in_enum][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------
@REM ******************** [END] UTILITY FUNCTIONS ***************************