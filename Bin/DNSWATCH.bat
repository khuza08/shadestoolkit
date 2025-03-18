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
netsh interface ip set dns name="Ethernet" static 82.200.69.80 primary
netsh interface ip add dns name="Ethernet" 84.200.70.40 index=2
netsh interface ip set dns name="Wi-Fi" static 82.200.69.80 primary
netsh interface ip add dns name="Wi-Fi" 84.200.70.40 index=2 
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "DNSWATCH" /f
del "%~f0"
exit
