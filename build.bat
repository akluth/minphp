@echo off
REM Ultra-aggressive build fuer maximale Geschwindigkeit
REM clang 22 + MSVC target - bestmoegliche Optimierungen

set SRC=minphp.c
set OUT=minphp.exe

echo Building fastest PHP PoC with clang...
"C:\Program Files\LLVM\bin\clang.exe" ^
    -O3 ^
    -march=native ^
    -mtune=native ^
    -flto ^
    -fomit-frame-pointer ^
    -fno-stack-protector ^
    -ffast-math ^
    -funroll-loops ^
    -fno-exceptions ^
    -fno-rtti ^
    -s ^
    %SRC% -o %OUT%

if errorlevel 1 (
    echo Clang build failed, trying gcc...
    "C:\tools\msys64\usr\bin\gcc.exe" ^
        -O3 -march=native -mtune=native -flto ^
        -fomit-frame-pointer -fno-stack-protector ^
        -ffast-math -funroll-loops -s ^
        %SRC% -o %OUT%
)

if exist %OUT% (
    echo.
    echo SUCCESS: %OUT% built.
    dir %OUT%
    echo.
    echo Now run with: .\%OUT% test.php
) else (
    echo Build failed.
)
