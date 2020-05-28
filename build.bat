@ECHO OFF
CLS & TITLE Building Because...
CD %~dp0
ECHO:

REM # convert the graphics to native format;
REM # we use "rgbfix" from the RGBDS assembler,
REM # even though we won't be using RGBDS to assemble
SET RGBGFX="bin\rgbds\rgbgfx.exe"

%RGBGFX% -v ^
    -o "build\tiles_even.2bpp" ^
       "src\gfx\tiles_even.png"

IF ERRORLEVEL 1 EXIT /B 1

%RGBGFX% -v ^
    -o "build\tiles_odd.2bpp" ^
       "src\gfx\tiles_odd.png"

IF ERRORLEVEL 1 EXIT /B 1

REM # the assembler and linker is WLA-DX
SET WLA_GB80="bin\wla-dx\wla-gb.exe"    -x -I "src"
SET WLA_LINK="bin\wla-dx\wlalink.exe"   -A -S

%WLA_GB80% -v ^
    -o "build\because.o" ^
       "because.wla"

IF ERRORLEVEL 1 EXIT /B 1

%WLA_LINK% -v ^
    "link.ini" ^
    "build\because.gb"

IF ERRORLEVEL 1 EXIT /B 1

REM # start the emulator
SET BGB="bin\bgb\bgb.exe"
START "" %BGB% "build\because.gb"