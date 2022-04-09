remo @echo off

rem :DOTNET_FIND
rem set DOTNET=%SystemRoot%\Microsoft.NET\Framework\v4.0.30319
rem if exist "%DOTNET%\MSBuild.exe" goto BUILD
rem set DOTNET=%SystemRoot%\Microsoft.NET\Framework\v3.5
rem if exist "%DOTNET%\MSBuild.exe" goto BUILD

rem :DOTNET_NOT_FOUND
rem echo .NET Framework not found. Build failed!
rem goto END

rem One wouldn't need to worry about the MSBuild path is running from developer command line
rem Visual studio 2022 --> Toos --> Command Line --> Developer command prompt

rem :BUILD
echo Using MSBuild found in %DOTNET%
rem set PATH=%DOTNET%;%PATH%
MSBuild "Kernel\BusmasterKernel.sln" /property:Configuration=Release /p:VisualStudioVersion=17.1
MSBuild "BUSMASTER\BUSMASTER.sln" /property:Configuration=Release /p:VisualStudioVersion=17.1

REM CAN PEAK USB.
rem MSBuild "BUSMASTER\CAN_PEAK_USB\CAN_PEAK_USB.vcxproj" /p:VisualStudioVersion=17.0 /property:Configuration=Release  

MSBuild "BUSMASTER\Language Dlls\Language Dlls.sln" /property:Configuration=Release /p:VisualStudioVersion=17.0 
MSBuild "BUSMASTER\LDFEditor\LDFEditor.sln" /property:Configuration=Release /p:VisualStudioVersion=17.0 
MSBuild "BUSMASTER\LDFViewer\LDFViewer.sln" /property:Configuration=Release /p:VisualStudioVersion=17.0

REM Asc Log
cd ..\Tools\flex 
"flex.exe" -i -L -o"..\..\Sources\BUSMASTER\Format Converter\AscLogConverter\Asc_Log_Lexer.c" "..\..\Sources\BUSMASTER\Format Converter\AscLogConverter\Asc_Log_Lexer.l"
cd ..\bison
"bison.exe" -d -l -o"..\..\Sources\BUSMASTER\Format Converter\AscLogConverter\Asc_Log_Parser.c" "..\..\Sources\BUSMASTER\Format Converter\AscLogConverter\Asc_Log_Parser.y"

REM Log Asc
cd ..\flex 
"flex.exe" -i -L -o"..\..\Sources\BUSMASTER\Format Converter\LogAscConverter\Log_Asc_Lexer.c" "..\..\Sources\BUSMASTER\Format Converter\LogAscConverter\Log_Asc_Lexer.l"
cd ..\bison
"bison.exe" -d -l -o"..\..\Sources\BUSMASTER\Format Converter\LogAscConverter\Log_Asc_Parser.c" "..\..\Sources\BUSMASTER\Format Converter\LogAscConverter\Log_Asc_Parser.y"

cd ..\..\Sources
MSBuild "BUSMASTER\Format Converter\FormatConverter.sln" /property:Configuration=Release /p:VisualStudioVersion=17.0 
rem :END

