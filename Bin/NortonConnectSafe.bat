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
netsh interface ip set dns name="Ethernet" static 199.85.126.10 primary
netsh interface ip add dns name="Ethernet" 199.85.127.10 index=2
netsh interface ip set dns name="Wi-Fi" static 199.85.126.10 primary
netsh interface ip add dns name="Wi-Fi" 199.85.127.10 index=2
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "NortonConnectSafe" /f
del "%~f0"
exit
