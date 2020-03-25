@echo off
SET THEFILE=D:\TreinamentoComLazarusOpenArquivos\1\OpenArquivos.exe
echo Linking %THEFILE%
C:\lazarus\fpc\3.0.4\bin\i386-win32\ld.exe -b pei-i386 -m i386pe  --gc-sections  -s --subsystem windows --entry=_WinMainCRTStartup    -o D:\TreinamentoComLazarusOpenArquivos\1\OpenArquivos.exe D:\TreinamentoComLazarusOpenArquivos\1\link.res
if errorlevel 1 goto linkend
C:\lazarus\fpc\3.0.4\bin\i386-win32\postw32.exe --subsystem gui --input D:\TreinamentoComLazarusOpenArquivos\1\OpenArquivos.exe --stack 16777216
if errorlevel 1 goto linkend
goto end
:asmend
echo An error occurred while assembling %THEFILE%
goto end
:linkend
echo An error occurred while linking %THEFILE%
:end
