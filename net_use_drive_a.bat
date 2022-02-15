@echo off
cls
color 0A
setlocal enableextensions enabledelayedexpansion

::--------------------------------------------------------
:: 
::--------------------------------------------------------


net use a: /delete
set /a I=1

:pingtarget
:: Loop until sd2dav.1und1.de is available.
echo Debug: passing the PingTarget( sd2dav.1und1.de ) %I% times
echo.
ping sd2dav.1und1.de >nul
set /a RC=%ERRORLEVEL%

if %RC% EQU 0 goto netuse
if %RC% GTR 0 color 0C

echo Errorlevel: %ERRORLEVEL%

set /a I=%I%+1

:: Wait 10 seconds before the next try.
ping /n 10 localhost >nul
cls
goto pingtarget



:netuse
color
echo NetUse( A: , PERSISTENT:NO , sd2dav.1und1.de , user , password )
echo.
net use A: /PERSISTENT:NO \\sd2dav.1und1.de@SSL\DavWWWRoot /USER:XXXX-XXX@online.de "Secure Password"
set /a RC=%ERRORLEVEL%


:: https://ss64.com/nt/robocopy-exit.html

if %RC% EQU 0 goto end
if %RC% GTR 0 color 0C & pause

echo Errorlevel: %ERRORLEVEL%

pause




:end
echo 
ping /n 10 localhost >nul
color
goto :eof