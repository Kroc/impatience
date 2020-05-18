@ECHO OFF
CLS & TITLE Building Because...
CD %~dp0
ECHO:

SET WLA_GB80="bin\wla-dx\wla-gb.exe"    -x -I "src"
SET WLA_LINK="bin\wla-dx\wlalink.exe"   -A -S
SET BGB="bin\bgb\bgb.exe"

%WLA_GB80% -v ^
    -o "build\because.o" ^
       "because.wla"

IF ERRORLEVEL 1 EXIT /B 1

%WLA_LINK% -v ^
    "link.ini" ^
    "build\because.gb"

IF ERRORLEVEL 1 EXIT /B 1

START "" %BGB% "build\because.gb"