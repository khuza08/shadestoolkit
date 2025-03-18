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
netsh interface ip set dns name="Ethernet" static 94.140.14.14 primary
netsh interface ip add dns name="Ethernet" 94.140.15.15 index=2
netsh interface ip set dns name="Wi-Fi" static 94.140.14.14 primary
netsh interface ip add dns name="Wi-Fi" 94.140.15.15 index=2
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "AdGuardDNS" /f
del "%~f0"
exit
