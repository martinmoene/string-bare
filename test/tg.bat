@echo off & setlocal enableextensions enabledelayedexpansion
::
:: tg.bat - compile & run tests (GNUC).
::

set      unit=string
set unit_file=string

:: if no std is given, use c++11

set std=c++2a
if NOT "%1" == "" set std=%1 & shift

set args=%1 %2 %3 %4 %5 %6 %7 %8 %9

set gpp=g++

call :CompilerVersion version
echo %gpp% %version%: %std% %args%

set unit_config=^
    -Dstring_STRING_HEADER=\"nonstd/string.hpp\" ^
    -Dstring_CONFIG_PROVIDE_REGEX=1

::string_CONFIG_SELECT_STRING_VIEW_INTERNAL
::string_CONFIG_SELECT_STRING_VIEW_NONSTD
::string_CONFIG_SELECT_STRING_VIEW_STD

rem -flto / -fwhole-program
set  optflags=-O2
set warnflags=-Wall -Wextra -Wpedantic -Wconversion -Wsign-conversion -Wshadow -Wno-padded -Wno-missing-noreturn -Wno-sign-conversion -Wno-conversion

%gpp% -std=%std% %optflags% %warnflags% %unit_config% -o %unit_file%-main.t.exe -isystem lest -I../include -Ics_string -I. %unit_file%-main.t.cpp %unit_file%.t.cpp && %unit_file%-main.t.exe

endlocal & goto :EOF

:: subroutines:

:CompilerVersion  version
echo off & setlocal enableextensions
set tmpprogram=_getcompilerversion.tmp
set tmpsource=%tmpprogram%.c

echo #include ^<stdio.h^>     > %tmpsource%
echo int main(){printf("%%d.%%d.%%d\n",__GNUC__,__GNUC_MINOR__,__GNUC_PATCHLEVEL__);} >> %tmpsource%

%gpp% -o %tmpprogram% %tmpsource% >nul
for /f %%x in ('%tmpprogram%') do set version=%%x
del %tmpprogram%.* >nul
endlocal & set %1=%version%& goto :EOF

:: toupper; makes use of the fact that string
:: replacement (via SET) is not case sensitive
:toupper
for %%L IN (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) DO SET %1=!%1:%%L=%%L!
goto :EOF
