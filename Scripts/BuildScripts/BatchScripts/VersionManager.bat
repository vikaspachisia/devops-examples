@ECHO OFF

@REM ******************** [BEGIN] MAIN **************************************
@REM ------------------------------------------------------------------------
:module
setlocal EnableDelayedExpansion

if not defined VM_CMD_DEBUG_LEVEL (set VM_CMD_DEBUG_LEVEL=%CMD_DEBUG_LEVEL%)
if not defined DO_NOT_RESET_ERRORLEVEL (set ERRORLEVEL=0)

call :main %*

set VM_CMD_DEBUG_LEVEL=

endlocal
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:main
if "%VM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][main][begin]: %*

call :initialize

if ERRORLEVEL 0 (call :parse_commandline_args %*)
if ERRORLEVEL 0 (call :validate_commands)
if ERRORLEVEL 0 (call :validate_parameters)
if ERRORLEVEL 0 (call :execute_commands)

call :uninitialize

if "%VM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][main][end]: result %ERRORLEVEL%
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:initialize
if "%VM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][initialize][begin]: %*

if "%CMD_DEBUG_LEVEL%" GEQ "4" @set

call :initialize_environment
call :initialize_enums
call :initialize_commands
call :initialize_parameters
call :initialize_variables

if "%VM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][initialize][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:uninitialize
if "%VM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][uninitialize][begin]: %*

if "%CMD_DEBUG_LEVEL%" GEQ "4" @set

call :uninitialize_variables
call :uninitialize_parameters
call :uninitialize_commands
call :uninitialize_enums
call :uninitialize_environment

if "%VM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][uninitialize][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:initialize_environment
if "%VM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][initialize_environment][begin]: %*

set THIS_WINDOW_CURRENT_TITLE=Command Prompt %~nx0
REM for /f "usebackq delims=" %%t in (`powershell -noprofile -c "[Console]::Title.Replace(' - '+[Environment]::CommandLine,'')"`) do set THIS_WINDOW_CURRENT_TITLE=%%t
@TITLE Version Manager

if "%VM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][initialize_environment][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:uninitialize_environment
if "%VM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][uninitialize_environment][begin]: %*

@TITLE %THIS_WINDOW_CURRENT_TITLE%
set THIS_WINDOW_CURRENT_TITLE=

if "%VM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][uninitialize_environment][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:initialize_enums
if "%VM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][initialize_enums][begin]: %*

REM NOOP

if "%VM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][initialize_enums][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:uninitialize_enums
if "%VM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][uninitialize_enums][begin]: %*

REM NOOP

if "%VM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][uninitialize_enums][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:initialize_commands
if "%VM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][initialize_commands][begin]: %*

set VM_CMD_HELP=0
set VM_CMD_CLEAN=0
set VM_CMD_SET_VERSION=0
set VM_CMD_GET_VERSION=0
set VM_CMD_GET_VERSION_PARTS=0

if "%VM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][initialize_commands][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:uninitialize_commands
if "%VM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][uninitialize_commands][begin]: %*

set VM_CMD_HELP=
set VM_CMD_CLEAN=
set VM_CMD_SET_VERSION=
set VM_CMD_GET_VERSION=
set VM_CMD_GET_VERSION_PARTS=

if "%VM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][uninitialize_commands][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:initialize_parameters
if "%VM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][initialize_parameters][begin]: %*

set VM_PARAM_FILEPATH=
set VM_PARAM_VERSION_STRING=*.*.*.*

if "%VM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][initialize_parameters][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:uninitialize_parameters
if "%VM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][uninitialize_parameters][begin]: %*

set VM_PARAM_FILEPATH=
set VM_PARAM_VERSION_STRING=

if "%VM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][uninitialize_parameters][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:initialize_variables
if "%VM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][initialize_variables][begin]: %*

set VM_VARS_VERSION_STRING=*.*.*.*
set VM_VARS_VERSION_STRING_PARTS=* * * *

set VM_VARS_COMMAND_VALID=0
set VM_VARS_COMMAND_PARAMS_VALID=0
set VM_VARS_COMMAND_PARAMS_VERSION_VALID=0

if "%VM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][initialize_variables][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:uninitialize_variables
if "%VM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][uninitialize_variables][begin]: %*

set VM_VARS_VERSION_STRING=
set VM_VARS_VERSION_STRING_PARTS=

set VM_VARS_COMMAND_VALID=
set VM_VARS_COMMAND_PARAMS_VALID=
set VM_VARS_COMMAND_PARAMS_VERSION_VALID=

if "%VM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][uninitialize_variables][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------
@REM ******************** [END] MAIN ****************************************


@REM ******************** [BEGIN] COMMAND MANAGEMENT ************************
@REM ------------------------------------------------------------------------
:parse_commandline_args
if "%VM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][parse_commandline_args][begin]: %*

set /A __local_parse_error_count=0

set "__CMDLINE_ARGS_LIST=%*"
:iterate_cmd_args_list
@for /F "tokens=1,* delims= " %%a in ("%__CMDLINE_ARGS_LIST%") do (
    if "%VM_CMD_DEBUG_LEVEL%" GEQ "3" @echo [DEBUG\%~nx0][parse_commandline_args]: current arg '%%a'
    @for /F "tokens=1,2 delims==" %%1 in ("%%a") do (
        if "%VM_CMD_DEBUG_LEVEL%" GEQ "3" @echo [DEBUG\%~nx0][parse_commandline_args]: current kv '%%1=%%2'
        call :parse_commandline_arg %%1 %%2
    )
    set "__CMDLINE_ARGS_LIST=%%b"
    goto :iterate_cmd_args_list
)
set "__CMDLINE_ARGS_LIST="

if "!__local_parse_error_count!" NEQ "0" (
   if "%VM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [ERROR\%~nx0][parse_commandline_args]: errorcount=!__local_parse_error_count!.
   set __local_parse_error_count=
   exit /B 22
)

set __local_parse_error_count=

if "%VM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][parse_commandline_args][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:parse_commandline_arg
if "%VM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][parse_commandline_arg][begin]: %*

if "%2"=="" (
    if "%VM_CMD_DEBUG_LEVEL%" GEQ "2" @echo [DEBUG\%~nx0][parse_commandline_arg]: parse command '%1'...
    call :parse_command %%1
    if "%VM_CMD_DEBUG_LEVEL%" GEQ "2" @echo [DEBUG\%~nx0][parse_commandline_arg]: parsed command '%1'...
) else (
    if "%VM_CMD_DEBUG_LEVEL%" GEQ "2" @echo [DEBUG\%~nx0][parse_commandline_arg]: parse parameter '%1=%2'...
    call :parse_parameter %%1 %%2
    if "%VM_CMD_DEBUG_LEVEL%" GEQ "2" @echo [DEBUG\%~nx0][parse_commandline_arg]: parsed parameter '%1=%2'...
)

if "%VM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][parse_commandline_arg][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:parse_command
if "%VM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][parse_command][begin]: %*

set __local_arg_found=

@REM -- /help --
if /I "%1"=="-help" (
    set "VM_CMD_HELP=1"
    set "__local_arg_found=1"
)
if /I "%1"=="/help" (
    set "VM_CMD_HELP=1"
    set "__local_arg_found=1"
)
if /I "%1"=="-?" (
    set "VM_CMD_HELP=1"
    set "__local_arg_found=1"
)
if /I "%1"=="/?" (
    set "VM_CMD_HELP=1"
    set "__local_arg_found=1"
)

@REM -- /clean --
if /I "%1"=="-clean" (
    set "VM_CMD_CLEAN=1"
    set "__local_arg_found=1"
)
if /I "%1"=="/clean" (
    set "VM_CMD_CLEAN=1"
    set "__local_arg_found=1"
)

@REM -- /set_version --
if /I "%1"=="-set_version" (
    set "VM_CMD_SET_VERSION=1"
    set "__local_arg_found=1"
)
if /I "%1"=="/set_version" (
    set "VM_CMD_SET_VERSION=1"
    set "__local_arg_found=1"
)

@REM -- /get_version --
if /I "%1"=="-get_version" (
    set "VM_CMD_GET_VERSION=1"
    set "__local_arg_found=1"
)
if /I "%1"=="/get_version" (
    set "VM_CMD_GET_VERSION=1"
    set "__local_arg_found=1"
)

@REM -- /get_version_parts --
if /I "%1"=="-get_version_parts" (
    set "VM_CMD_GET_VERSION_PARTS=1"
    set "__local_arg_found=1"
)
if /I "%1"=="/get_version_parts" (
    set "VM_CMD_GET_VERSION_PARTS=1"
    set "__local_arg_found=1"
)

if "%__local_arg_found%" NEQ "1" (
   if "%VM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [ERROR\%~nx0][parse_command]: Could not find command: '%1'. Argument will be ignored.
   set /A __local_parse_error_count=__local_parse_error_count+1
   set __local_arg_found=
   exit /B 87
)

set __local_arg_found=

if "%VM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][parse_command][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:parse_parameter
if "%VM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][parse_parameter][begin]: %*

set __local_arg_found=

@REM -- /filepath --
if /I "%1"=="-filepath" (
    set "VM_PARAM_FILEPATH=%2"
    set "__local_arg_found=1"
)
if /I "%1"=="/filepath" (
    set "VM_PARAM_FILEPATH=%2"
    set "__local_arg_found=1"
)

@REM -- /version --
if /I "%1"=="-version" (
    set "VM_PARAM_VERSION_STRING=%2"
    set "__local_arg_found=1"
)
if /I "%1"=="/version" (
    set "VM_PARAM_VERSION_STRING=%2"
    set "__local_arg_found=1"
)

if "%__local_arg_found%" NEQ "1" (
   if "%VM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [ERROR\%~nx0][parse_parameter]: Could not find parameter: '%1'=='%2'. Argument will be ignored.
   set /A __local_parse_error_count=__local_parse_error_count+1
   set __local_arg_found=
   exit /B 87
)

set __local_arg_found=

if "%VM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][parse_parameter][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:validate_commands
if "%VM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][validate_commands][begin]: %*

set /A __local_cmd_count=0

if "%VM_CMD_HELP%"=="1" (set /A __local_cmd_count+=1)
if "%VM_CMD_CLEAN%"=="1" (set /A __local_cmd_count+=1)
if "%VM_CMD_SET_VERSION%"=="1" (set /A __local_cmd_count+=1)
if "%VM_CMD_GET_VERSION%"=="1" (set /A __local_cmd_count+=1)
if "%VM_CMD_GET_VERSION_PARTS%"=="1" (set /A __local_cmd_count+=1)

if "%__local_cmd_count%" NEQ "1" (
   if "%VM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [ERROR\%~nx0][validate_commands]: cannot identify the command to run. command count=%__local_cmd_count%
   set __local_cmd_count=
   set VM_VARS_COMMAND_VALID=0
   exit /B 22
) else (
    set VM_VARS_COMMAND_VALID=1
)

set __local_cmd_count=

if "%VM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][validate_commands][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:validate_parameters
if "%VM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][validate_parameters][begin]: %*

set /A __local_param_valid=1

@REM Validate parameter availability only. The parameter content validation should be taken care of by the respective command.
if "%VM_CMD_SET_VERSION%"=="1" (
    if "%VM_PARAM_FILEPATH%" == "" (set __local_param_valid=0)
    if "%VM_PARAM_VERSION_STRING%" == "" (set __local_param_valid=0)
)

if "%VM_CMD_GET_VERSION%"=="1" (
    if "%VM_PARAM_FILEPATH%" == "" (set __local_param_valid=0)
)

if "%VM_CMD_GET_VERSION_PARTS%"=="1" (
     if "%VM_PARAM_VERSION_STRING%" == "" (set __local_param_valid=0)
)

if "%__local_param_valid%" NEQ "1" (
   if "%VM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [ERROR\%~nx0][validate_parameters]: cannot find the parameters for the command to run.
   set __local_param_valid=
   set VM_VARS_COMMAND_PARAMS_VALID=0
   exit /B 87
) else (
    set VM_VARS_COMMAND_PARAMS_VALID=1
)

set __local_param_valid=

if "%VM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][validate_parameters][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:execute_commands
if "%VM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][execute_commands][begin]: %*

set /A __local_cmd_count=0

if !VM_VARS_COMMAND_VALID! EQU 1 (
    if !VM_VARS_COMMAND_PARAMS_VALID! EQU 1 (
        if "%VM_CMD_HELP%"=="1" (set /A __local_cmd_count+=1 & call :print_help)
        if "%VM_CMD_CLEAN%"=="1" (set /A __local_cmd_count+=1 & call :clean_environment)
        if "%VM_CMD_SET_VERSION%"=="1" (set /A __local_cmd_count+=1 & call :set_version %VM_PARAM_FILEPATH% %VM_PARAM_VERSION_STRING%)
        if "%VM_CMD_GET_VERSION%"=="1" (set /A __local_cmd_count+=1 & call :get_version %VM_PARAM_FILEPATH% VM_VARS_VERSION_STRING)
        if "%VM_CMD_GET_VERSION_PARTS%"=="1" (set /A __local_cmd_count+=1 & call :get_version_parts %VM_PARAM_VERSION_STRING% VM_VARS_VERSION_STRING_PARTS)
        
        @REM Currently sending results is delegated to another function. But it could have been inline also.
        call :send_results
    ) else (
        if "%VM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [ERROR\%~nx0][execute_commands]: Command parameters are not valid.
    )
) else (
    if "%VM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [ERROR\%~nx0][execute_commands]: No valid command found.
)

if "!__local_cmd_count!" NEQ "1" (
   if "%VM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [ERROR\%~nx0][execute_commands]: No command found to execute. try "%~nx0 -help" for help.
   set __local_cmd_count=
   exit /B 22
)

set __local_cmd_count=

if "%VM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][execute_commands][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:send_results
if "%VM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][send_results][begin]: %*

if !VM_VARS_COMMAND_VALID! EQU 1 (
    if !VM_VARS_COMMAND_PARAMS_VALID! EQU 1 (
        if "%VM_CMD_HELP%"=="1" (@echo.)
        if "%VM_CMD_CLEAN%"=="1" (@echo.)
        if "%VM_CMD_SET_VERSION%"=="1" (@echo.)
        if "%VM_CMD_GET_VERSION%"=="1" (@echo !VM_VARS_VERSION_STRING!)
        if "%VM_CMD_GET_VERSION_PARTS%"=="1" (@echo !VM_VARS_VERSION_STRING_PARTS[0]! !VM_VARS_VERSION_STRING_PARTS[1]! !VM_VARS_VERSION_STRING_PARTS[2]! !VM_VARS_VERSION_STRING_PARTS[3]!)
    ) else (
        if "%VM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [ERROR\%~nx0][execute_commands]: Could not compute results as no command was processed.
    )
) else (
    if "%VM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [ERROR\%~nx0][execute_commands]: Could not compute results as input was not valid.
)

if "%VM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][send_results][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------
@REM ******************** [END] COMMAND MANAGEMENT **************************

@REM ******************** [BEGIN] COMMAND IMPLEMENTATION ********************
@REM ------------------------------------------------------------------------
:print_help
if "%VM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][print_help][begin]: %*

@echo .
@echo ** Version Manager **
@echo .
@echo Syntax: %~nx0 [command] [parameters]
@echo.

@echo [command] :
@echo     -help : Prints this help message
@echo     -clean : Cleans the environment variables generated by this module.
@echo     -set_version : Sets the version in the file specificed by '-filepath' as per the version specified by '-version'.
@echo     -get_version : Gets the version from the file specificed by '-filepath'.
@echo     -get_version_parts : Gets the parts of the version specified by '-version'.
@echo.

@echo [parameters] :
@echo     -filepath=<path_to_file> : Path to the file that contains the version string. Used for reading or writing.
@echo     -version=<version_string> : Can be a 3 or 4 part dotted version string. Missing parts will not be updated.
@echo            ## *.*.*.* [default]: '*' represents no change in the part where it appears.
@echo            ## +.+.+.+ : '+' represents increment by 1 in the part where it appears.
@echo            ## 1.2.3.4 : sets version to specific value as defined by the part.

if "%VM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][print_help][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:clean_environment
if "%VM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][clean_environment][begin]: %*

@REM NOOP

if "%VM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][clean_environment][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:set_version
if "%VM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][set_version][begin]: %*

set "_filepath=%1"
set "_version_string=%2"
set _version_parts=0 0 0 0

call :validate_filepath %_filepath%
if "!ERRORLEVEL!" == "0" (
    if "%VM_CMD_DEBUG_LEVEL%" GEQ "2" @echo [DEBUG\%~nx0][set_version]: validating version %2...
    call :validate_version_string %_version_string%
    if "%VM_CMD_DEBUG_LEVEL%" GEQ "2" @echo [DEBUG\%~nx0][set_version]: validated version %2.
    
    if "!VM_VARS_COMMAND_PARAMS_VERSION_VALID!" == "0" (
        if "%VM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [ERROR\%~nx0][set_version]: version '%2' is not valid.
    ) else (
        if "%VM_CMD_DEBUG_LEVEL%" GEQ "2" @echo [DEBUG\%~nx0][set_version]: extracting version parts from %2...
        call :get_version_parts %_version_string% _version_parts
        if "%VM_CMD_DEBUG_LEVEL%" GEQ "2" @echo [DEBUG\%~nx0][set_version]: extracted version parts from %2.
        if "%VM_CMD_DEBUG_LEVEL%" GEQ "3" (
            @echo [DEBUG\%~nx0][set_version]: Version parts from %2:
            @echo [DEBUG\%~nx0][set_version]: version_parts[0]=!_version_parts[0]!
            @echo [DEBUG\%~nx0][set_version]: version_parts[1]=!_version_parts[1]!
            @echo [DEBUG\%~nx0][set_version]: version_parts[2]=!_version_parts[2]!
            @echo [DEBUG\%~nx0][set_version]: version_parts[3]=!_version_parts[3]!
        )
        if "%VM_CMD_DEBUG_LEVEL%" GEQ "2" @echo [INFO\%~nx0][set_version]: updating version in %1...
		@REM use any command, program, script to process the version. E.g. perl command with regex:
        @REM @PERL -pi.BAK -e "s/(\d+[,.]\d+[,.]\d+[,.])\d+/${1}!_version_parts[3]!/g;" %1
        if "%VM_CMD_DEBUG_LEVEL%" GEQ "2" @echo [INFO\%~nx0][set_version]: updated version in %1.
    )
) else (
    if "%VM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [ERROR\%~nx0][set_version]: file '%1' is not valid.
)

set _filepath=
set _version_string=
set _version_parts=

if "%VM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][set_version][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:get_version
if "%VM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][get_version][begin]: %*

set "_filepath=%1"
set "_version_string=%2"
call set "_version_string_content=%%%_version_string%%%"

if "%VM_CMD_DEBUG_LEVEL%" GEQ "3" @echo [DEBUG\%~nx0][get_version]: fallback version = %_version_string_content%

call :validate_filepath %_filepath%
if "!ERRORLEVEL!" == "0" (
    if "%VM_CMD_DEBUG_LEVEL%" GEQ "2" @echo [INFO\%~nx0][get_version]: getting version from %1...
    for /F "usebackq tokens=*" %%i IN (`PERL -n -e "print $& and exit if(/\d+\.\d+\.\d+\.\d+/);" %1`) do (
        set _version_string_content=%%i
    )
    if "%VM_CMD_DEBUG_LEVEL%" GEQ "2" @echo [INFO\%~nx0][get_version]: got version from %1.
) else (
    if "%VM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [ERROR\%~nx0][get_version]: file '%1' is not valid.
)

if "%VM_CMD_DEBUG_LEVEL%" GEQ "3" @echo [DEBUG\%~nx0][get_version]: final version = !_version_string_content!

set %~2=!_version_string_content!

set _filepath=
set _version_string=
set _version_string_content=

if "%VM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][get_version][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:get_version_parts
if "%VM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][get_version_parts][begin]: %*

set "_version_string_full=%1"
set "_vars_version_parts=%2"

call set "_local_version_parts[0]=%%%_vars_version_parts[0]%%%"
call set "_local_version_parts[1]=%%%_vars_version_parts[1]%%%"
call set "_local_version_parts[2]=%%%_vars_version_parts[2]%%%"
call set "_local_version_parts[3]=%%%_vars_version_parts[3]%%%"

if "%VM_CMD_DEBUG_LEVEL%" GEQ "2" @echo [DEBUG\%~nx0][get_version_parts]: validating version %1...
call :validate_version_string %_version_string_full%
if "%VM_CMD_DEBUG_LEVEL%" GEQ "2" @echo [DEBUG\%~nx0][get_version_parts]: validated version %1.

if "!VM_VARS_COMMAND_PARAMS_VERSION_VALID!" == "0" (
    if "%VM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [ERROR\%~nx0][get_version_parts]: version '%1' is not valid.
) else (
    if "%VM_CMD_DEBUG_LEVEL%" GEQ "2" @echo [DEBUG\%~nx0][get_version_parts]: parsing version %1...
    set /A i=0
    :parse_version_parts
    for /F "tokens=1,* delims=." %%v in ("!_version_string_full!") do (
        if "%VM_CMD_DEBUG_LEVEL%" GEQ "3" @echo [DEBUG\%~nx0][get_version_parts]: version[!i!]=%%v, next_token=%%w
        set _local_version_parts[!i!]=%%v
        set /A i+=1
        set "_version_string_full=%%w"
        goto :parse_version_parts
    )
    set i=
    if "%VM_CMD_DEBUG_LEVEL%" GEQ "2" @echo [DEBUG\%~nx0][get_version_parts]: parsed version %1.
)

if "%VM_CMD_DEBUG_LEVEL%" GEQ "3" (
    @echo [DEBUG\%~nx0][get_version_parts]: found version parts from %1:
    @echo [DEBUG\%~nx0][get_version_parts]: version_parts[0]=!_local_version_parts[0]!
    @echo [DEBUG\%~nx0][get_version_parts]: version_parts[1]=!_local_version_parts[1]!
    @echo [DEBUG\%~nx0][get_version_parts]: version_parts[2]=!_local_version_parts[2]!
    @echo [DEBUG\%~nx0][get_version_parts]: version_parts[3]=!_local_version_parts[3]!
)

set "%~2[0]=!_local_version_parts[0]!"
set "%~2[1]=!_local_version_parts[1]!"
set "%~2[2]=!_local_version_parts[2]!"
set "%~2[3]=!_local_version_parts[3]!"

set _version_string_full=
set _vars_version_parts=

set _local_version_parts[0]=
set _local_version_parts[1]=
set _local_version_parts[2]=
set _local_version_parts[3]=

if "%VM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][get_version_parts][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------
@REM ******************** [END] COMMAND IMPLEMENTATION **********************

@REM ******************** [BEGIN] UTILITY FUNCTIONS *************************
@REM ------------------------------------------------------------------------
:validate_version_string
if "%VM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][validate_version_string][begin]: %*

set "_version_string=%1"
set "_version_string_valid=1"

if "%VM_CMD_DEBUG_LEVEL%" GEQ "2" @echo [DEBUG\%~nx0][validate_version_string]: parsing version %1...
set /A i=0
:parse_version
for /F "tokens=1,* delims=." %%v in ("!_version_string!") do (
    if "%VM_CMD_DEBUG_LEVEL%" GEQ "3" @echo [DEBUG\%~nx0][validate_version_string]: version[!i!]=%%v, next_token=%%w
    call :validate_version_string_part !i! %%v
    if not ERRORLEVEL 0 (set _version_string_valid=0) 
    set /A i+=1
    set "_version_string=%%w"
    goto :parse_version
)
if "%VM_CMD_DEBUG_LEVEL%" GEQ "2" @echo [DEBUG\%~nx0][validate_version_string]: parsed version %1.

if "%VM_CMD_DEBUG_LEVEL%" GEQ "2" @echo [DEBUG\%~nx0][validate_version_string]: check minimum no. of parts in %1...
if "!i!" LSS "3" (
    if "%VM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [ERROR\%~nx0][validate_version_string]: too less parts [!i!] specified in the version string.
    set _version_string_valid=0
) else (
    if "%VM_CMD_DEBUG_LEVEL%" GEQ "3" @echo [INFO\%~nx0][validate_version_string]: version string has minimum parts.
)
if "%VM_CMD_DEBUG_LEVEL%" GEQ "2" @echo [DEBUG\%~nx0][validate_version_string]: checked minimum no. of parts in %1.

if "%VM_CMD_DEBUG_LEVEL%" GEQ "2" @echo [DEBUG\%~nx0][validate_version_string]: check maximum no. of parts in %1...
if "!i!" GTR "4" (
    if "%VM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [ERROR\%~nx0][validate_version_string]: too many parts [!i!] specified in the version string.
    set _version_string_valid=0
) else (
    if "%VM_CMD_DEBUG_LEVEL%" GEQ "3" @echo [INFO\%~nx0][validate_version_string]: version string is within maximum parts.
)
if "%VM_CMD_DEBUG_LEVEL%" GEQ "2" @echo [DEBUG\%~nx0][validate_version_string]: checked maximum no. of parts in %1.
set i=

set VM_VARS_COMMAND_PARAMS_VERSION_VALID="!_version_string_valid!"
if "!_version_string_valid!" == "0" (
    if "%VM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [ERROR\%~nx0][validate_version_string]: %1 is not valid.
    set _version_string=
    set _version_string_valid=
    exit /B 87
)

set _version_string=
set _version_string_valid=

if "%VM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][validate_version_string][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:validate_version_string_part
if "%VM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][validate_version_string_part][begin]: %*

set "_version_string_part_index=%1"
set "_version_string_part_value=%2"
set "_version_string_part_valid=1"

if "%2" NEQ "*" (
    if "%2" NEQ "+" (
        SET "var="&for /f "delims=0123456789" %%a in ("%2") do (set "var=%%a")
        if defined var (
            if "%VM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [ERROR\%~nx0][validate_version_string_part]:version[%1]=%2 is not valid
            set _version_string_part_valid=0
        ) else (
            if "%VM_CMD_DEBUG_LEVEL%" GEQ "3" @echo [DEBUG\%~nx0][validate_version_string_part]:version[%1]=%2 is valid
        )
    ) else (
        if "%VM_CMD_DEBUG_LEVEL%" GEQ "3" @echo [DEBUG\%~nx0][validate_version_string_part]:version[%1]=%2 is valid
    )
) else (
    if "%VM_CMD_DEBUG_LEVEL%" GEQ "3" @echo [DEBUG\%~nx0][validate_version_string_part]:version[%1]=%2 is valid
)

if "%_version_string_part_valid%" == "0" (
    if "%VM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [ERROR\%~nx0][validate_version_string_part]: %2 is not valid.
    set _version_string_part_index=
    set _version_string_part_value=
    set _version_string_part_valid=
    exit /B 87
)

set _version_string_part_index=
set _version_string_part_value=
set _version_string_part_valid=

if "%VM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][validate_version_string_part][end]: %*
exit /B ERRORLEVEL
@REM ------------------------------------------------------------------------

@REM ------------------------------------------------------------------------
:validate_filepath
if "%VM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][validate_filepath][begin]: %*

set "_filepath=%~1"

if not exist %_filepath% (
    if "%VM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [ERROR\%~nx0][validate_filepath]: %_filepath% is not valid.
    set _filepath=
    exit /B 87
)

set _filepath=

if "%VM_CMD_DEBUG_LEVEL%" GEQ "1" @echo [DEBUG\%~nx0][validate_filepath][end]: %*
exit /B 0
@REM ------------------------------------------------------------------------
@REM ******************** [END] UTILITY FUNCTIONS ***************************