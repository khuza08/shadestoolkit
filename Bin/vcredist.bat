@echo off
cls
chcp 65001 >nul
fltmc >nul 2>&1 || (
    PowerShell Start -Verb RunAs '%0' 2> nul || (
        echo Right-click on the script and select "Run as administrator".
        pause & exit 1
    )
    exit 0
)
echo.
echo ► VCRedist is being installed. The window will automatically close when the installation is complete. Please Wait!
set "installer=VisualCppRedist_AIO_x86_x64.exe"
"%installer%" /ai /gm2
del VisualCppRedist_AIO_x86_x64.exe /S /Q /F >NUL
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "vcredist" /f >NUL
del "%~f0"
exit
