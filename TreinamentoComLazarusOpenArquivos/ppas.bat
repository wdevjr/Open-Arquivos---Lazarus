@echo off
SET THEFILE=E:\ProjetoLazarus\TreinamentoComLazarusOpenArquivos\OpenArquivos.exe
echo Linking %THEFILE%
C:\lazarus\fpc\3.0.4\bin\i386-win32\ld.exe -b pei-i386 -m i386pe  --gc-sections   --subsystem windows --entry=_WinMainCRTStartup    -o E:\ProjetoLazarus\TreinamentoComLazarusOpenArquivos\OpenArquivos.exe E:\ProjetoLazarus\TreinamentoComLazarusOpenArquivos\link.res
if errorlevel 1 goto linkend
C:\lazarus\fpc\3.0.4\bin\i386-win32\postw32.exe --subsystem gui --input E:\ProjetoLazarus\TreinamentoComLazarusOpenArquivos\OpenArquivos.exe --stack 16777216
if errorlevel 1 goto linkend
goto end
:asmend
echo An error occurred while assembling %THEFILE%
goto end
:linkend
echo An error occurred while linking %THEFILE%
:end
