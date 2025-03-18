@echo off
chcp 65001 >nul

REM Set the path to the installation folder
set "InstallFolder=C:\Programlar"

REM Install the programs
for %%i in ("%InstallFolder%\*.exe") do (
    start /wait "%%~ni" "%%i" /S
)

REM Cleanup the installation files
rd /s /q "%InstallFolder%"
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "StartBat" /f
exit