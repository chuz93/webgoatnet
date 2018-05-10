@echo off
REM ###########################################################################
REM Script generated by HPE Security Fortify SCA Scan Wizard (c) 2011-2017 Hewlett Packard Enterprise Development LP
REM Created on 2017/09/13 11:56:33
REM ###########################################################################
REM Generated for the following languages:
REM 	C#.NET / VB.NET
REM 	HTML
REM 	Javascript
REM 	XML
REM ###########################################################################
REM DEBUG - if set to true, runs SCA in debug mode
REM SOURCEANALYZER - the name of the SCA executable
REM FPR - the name of analysis result file
REM BUILDID - the SCA build id
REM ARGFILE - the name of the argument file that's extracted and passed to SCA
REM BYTECODE_ARGFILE - the name of the argument file for Java Bytecode translation that's extracted and passed to SCA
REM MEMORY - the memory settings for SCA
REM LAUNCHERSWITCHES - the launcher settings that are used to invoke SCA
REM OLDFILENUMBER - this defines the file which contains the number of files within the project, it is automatically generated
REM FILENOMAXDIFF - this is the percentage of difference between the number of files which will trigger a warning by the script
REM ###########################################################################

set DEBUG=false
set SOURCEANALYZER=sourceanalyzer
set FPR="FortifyWebGoat.Net-master.fpr"
set BUILDID="WebGoat.Net-master"
set ARGFILE="FortifyWebGoat.Net-master.bat.args"
set BYTECODE_ARGFILE="FortifyWebGoat.Net-master.bat.bytecode.args"
set MEMORY=-Xmx14550M -Xms400M -Xss24M 
set LAUNCHERSWITCHES=""
set OLDFILENUMBER=FortifyWebGoat.Net-master.bat.fileno
set FILENOMAXDIFF=10
set ENABLE_BYTECODE=false

set PROJECTROOT0="C:\Users\rujesusg\Documents\WebGoat.Net\WebGoat.Net-master"
IF NOT EXIST %PROJECTROOT0% (
   ECHO  ERROR: This script is being run on a different machine than it was
   ECHO         generated on or the targeted project has been moved. This script is 
   ECHO         configured to locate files at
   ECHO            %PROJECTROOT0%
   ECHO         Please modify the %%PROJECTROOT0%% variable found
   ECHO         at the top of this script to point to the corresponding directory
   ECHO         located on this machine.
   GOTO :FINISHED
)

IF %DEBUG%==true set LAUNCHERSWITCHES=-debug %LAUNCHERSWITCHES%
echo Extracting Arguments File


echo. >%ARGFILE%
echo. >%BYTECODE_ARGFILE%
SETLOCAL ENABLEDELAYEDEXPANSION
IF EXIST %0 (
   set SCAScriptFile=%0
) ELSE (
  set SCAScriptFile=%0.bat
)

set PROJECTROOT0=%PROJECTROOT0:)=^)%
FOR /f "delims=" %%a IN ('findstr /B /C:"REM ARGS" %SCAScriptFile%' ) DO (
   set argVal=%%a
   set argVal=!argVal:PROJECTROOT0_MARKER=%PROJECTROOT0:~1,-1%!
   echo !argVal:~9! >> %ARGFILE%
)
set PROJECTROOT0=%PROJECTROOT0:)=^)%
FOR /f "delims=" %%a IN ('findstr /B /C:"REM BYTECODE_ARGS" %SCAScriptFile%' ) DO (
   set ENABLE_BYTECODE=true
   set argVal=%%a
   set argVal=!argVal:PROJECTROOT0_MARKER=%PROJECTROOT0:~1,-1%!
   echo !argVal:~18! >> %BYTECODE_ARGFILE%
)
ENDLOCAL && set ENABLE_BYTECODE=%ENABLE_BYTECODE%

REM ###########################################################################

echo Searching .NET Framework Version...
IF EXIST "C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.6.2" (
set LAUNCHERSWITCHES=-dotnet-version 4.6.2 %LAUNCHERSWITCHES%
echo Found .NET Framework Version 4.6.2
GOTO DOTNETSELECTED
)
IF EXIST "C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.6.1" (
set LAUNCHERSWITCHES=-dotnet-version 4.6.1 %LAUNCHERSWITCHES%
echo Found .NET Framework Version 4.6.1
GOTO DOTNETSELECTED
)
IF EXIST "C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.6" (
set LAUNCHERSWITCHES=-dotnet-version 4.6 %LAUNCHERSWITCHES%
echo Found .NET Framework Version 4.6
GOTO DOTNETSELECTED
)
IF EXIST "C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.5.2" (
set LAUNCHERSWITCHES=-dotnet-version 4.5.2 %LAUNCHERSWITCHES%
echo Found .NET Framework Version 4.5.2
GOTO DOTNETSELECTED
)
IF EXIST "C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.5.1" (
set LAUNCHERSWITCHES=-dotnet-version 4.5.1 %LAUNCHERSWITCHES%
echo Found .NET Framework Version 4.5.1
GOTO DOTNETSELECTED
)
IF EXIST "C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.5" (
set LAUNCHERSWITCHES=-dotnet-version 4.5 %LAUNCHERSWITCHES%
echo Found .NET Framework Version 4.5
GOTO DOTNETSELECTED
)
IF EXIST "C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v4.0" (
set LAUNCHERSWITCHES=-dotnet-version 4.0 %LAUNCHERSWITCHES%
echo Found .NET Framework Version 4.0
GOTO DOTNETSELECTED
)
IF EXIST "C:\Program Files (x86)\Reference Assemblies\Microsoft\Framework\.NETFramework\v3.5" (
set LAUNCHERSWITCHES=-dotnet-version 3.5 %LAUNCHERSWITCHES%
echo Found .NET Framework Version 3.5
GOTO DOTNETSELECTED
)
reg QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.0" /v Install 2>NUL >NUL
IF %ERRORLEVEL%==0 (
set LAUNCHERSWITCHES=-dotnet-version 3.0 %LAUNCHERSWITCHES%
echo Found .NET Framework Version 3.0
GOTO DOTNETSELECTED
)
reg QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727" /v Install 2>NUL >NUL
IF %ERRORLEVEL%==0 (
set LAUNCHERSWITCHES=-dotnet-version 2.0 %LAUNCHERSWITCHES%
echo Found .NET Framework Version 2.0
GOTO DOTNETSELECTED
)
:DOTNETSELECTED
REM ###########################################################################
echo Cleaning previous scan artifacts
%SOURCEANALYZER% %MEMORY% %LAUNCHERSWITCHES% -b %BUILDID% -clean 
IF %ERRORLEVEL%==1 (
echo Sourceanalyzer failed, exiting
GOTO :FINISHED
)
REM ###########################################################################
echo Translating files
%SOURCEANALYZER% %MEMORY% %LAUNCHERSWITCHES% -b %BUILDID% @%ARGFILE%
IF %ERRORLEVEL%==1 (
echo Sourceanalyzer failed, exiting
GOTO :FINISHED
)
REM ###########################################################################
IF %ENABLE_BYTECODE%==true (
echo Translating Java bytecode files
%SOURCEANALYZER% %MEMORY% %LAUNCHERSWITCHES% -b %BUILDID% @%BYTECODE_ARGFILE% devenv %PROJECTROOT0% + "/MyProject.sln" /REBUILD debug

IF %ERRORLEVEL%==1 (
echo Sourceanalyzer failed, exiting
GOTO :FINISHED
)
)
REM ###########################################################################
echo Testing Difference between Translations
SETLOCAL
FOR /F "delims=" %%A in ('%SOURCEANALYZER% -b %BUILDID% -show-files ^| findstr /R /N "^" ^| find /C ":" ') DO SET FILENUMBER=%%A
IF NOT EXIST %OLDFILENUMBER% (
	ECHO It appears to be the first time running this script, setting %OLDFILENUMBER% to %FILENUMBER%
	ECHO %FILENUMBER% > %OLDFILENUMBER%
	GOTO TESTENDED
)

FOR /F "delims=" %%i IN (%OLDFILENUMBER%) DO SET OLDFILENO=%%i
set /a DIFF=%OLDFILENO% * %FILENOMAXDIFF%
set /a DIFF /=  100
set /a MAX=%OLDFILENO% + %DIFF%
set /a MIN=%OLDFILENO% - %DIFF%

IF %FILENUMBER% LSS %MIN% set SHOWWARNING=true
IF %FILENUMBER% GTR %MAX% set SHOWWARNING=true

IF DEFINED SHOWWARNING (
	ECHO WARNING: The number of files has changed by over %FILENOMAXDIFF%%%, it is recommended 
	ECHO          that this script is regenerated with the ScanWizard
)
:TESTENDED
ENDLOCAL

REM ###########################################################################
echo Starting scan
%SOURCEANALYZER% %MEMORY% %LAUNCHERSWITCHES% -b %BUILDID% -scan -f %FPR%
IF %ERRORLEVEL%==1 (
echo Sourceanalyzer failed, exiting
GOTO :FINISHED
)
REM ###########################################################################
echo Finished
:FINISHED
REM ARGS "-libdirs"
REM ARGS "PROJECTROOT0_MARKER\Infrastructure\bin\Debug\EntityFramework.dll;PROJECTROOT0_MARKER\Infrastructure\bin\Debug\EntityFramework.SqlServer.dll;PROJECTROOT0_MARKER\Infrastructure\bin\Debug\System.Data.DataSetExtensions.dll;PROJECTROOT0_MARKER\packages\AntiXSS.4.3.0\lib\net20\AntiXssLibrary.dll;PROJECTROOT0_MARKER\packages\AntiXSS.4.3.0\lib\net35\AntiXssLibrary.dll"
REM ARGS "-libdirs"
REM ARGS "PROJECTROOT0_MARKER\packages\AntiXSS.4.3.0\lib\net35\HtmlSanitizationLibrary.dll;PROJECTROOT0_MARKER\packages\AntiXSS.4.3.0\lib\net40\AntiXssLibrary.dll;PROJECTROOT0_MARKER\packages\AntiXSS.4.3.0\lib\net40\HtmlSanitizationLibrary.dll;PROJECTROOT0_MARKER\packages\EntityFramework.6.1.3\lib\net40\EntityFramework.dll;PROJECTROOT0_MARKER\packages\EntityFramework.6.1.3\lib\net40\EntityFramework.SqlServer.dll"
REM ARGS "-libdirs"
REM ARGS "PROJECTROOT0_MARKER\packages\EntityFramework.6.1.3\lib\net45\EntityFramework.dll;PROJECTROOT0_MARKER\packages\EntityFramework.6.1.3\lib\net45\EntityFramework.SqlServer.dll;PROJECTROOT0_MARKER\packages\EntityFramework.6.1.3\tools\EntityFramework.PowerShell.dll;PROJECTROOT0_MARKER\packages\EntityFramework.6.1.3\tools\EntityFramework.PowerShell.Utility.dll;PROJECTROOT0_MARKER\ThirdPartyTools\Recaptcha.dll"
REM ARGS "-libdirs"
REM ARGS "PROJECTROOT0_MARKER\WebSite\bin\AntiXssLibrary.dll;PROJECTROOT0_MARKER\WebSite\bin\EntityFramework.dll;PROJECTROOT0_MARKER\WebSite\bin\EntityFramework.SqlServer.dll;PROJECTROOT0_MARKER\WebSite\bin\HtmlSanitizationLibrary.dll;PROJECTROOT0_MARKER\WebSite\bin\Oracle.DataAccess.dll"
REM ARGS "-libdirs"
REM ARGS "PROJECTROOT0_MARKER\WebSite\bin\Recaptcha.dll"
REM ARGS "PROJECTROOT0_MARKER"
