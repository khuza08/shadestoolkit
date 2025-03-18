:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: ► This script currently modified by huza (khuza08)
:: ► The original source are owned by shadesofdeath
:: ► https://github.com/shadesofdeath/ShadesToolkit 
:: ► Donate to shadesofdeath : https://www.buymeacoffee.com/berkayay
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@echo off
setlocal enabledelayedexpansion
set ver=v 2 . 3
set "color=[38;2;27;188;155m"
title ShadesToolkit %ver% Remake By huza (khuza08)
chcp 65001 >nul
mode con cols=100 lines=35
fltmc >nul 2>&1 || (
    PowerShell Start -Verb RunAs '%0' 2> nul || (
        echo Right-click on the script and select "Run as administrator".
        pause & exit 1
    )
    exit 0
)

:: Konum bilgisi
cd /d "%~dp0"
for /f %%a in ('"cd"') do set Location=%%a
set INSTALL=%Location%\Mount\Install
set InstallWim=%Location%\Extracted\sources\install.wim
:: Yüklü mount yollarını alır ve remount işlemi yapar. Bunun uygulanması olası hataları önlemektedir.
FOR /F "tokens=4" %%a in ('dism /get-mountedwiminfo ^| FIND "Mount Dir"') do (
	FOR /F "delims=\\? tokens=*" %%b in ('echo %%a') do (
		Dism /Remount-Image /MountDir:"%%b" > NUL 2>&1
		cls
	)
)
cls
:: silme
DEL /F /Q /A "%Location%\Temp\app_list.txt" > NUL 2>&1
DEL /F /Q /A "%Location%\Temp\app_list2.txt" > NUL 2>&1

:CleanUp
set CLEAR=N
dir /b /s %INSTALL%\Windows\Regedit.exe > NUL 2>&1
	if %errorlevel% EQU 0 (set CLEAR=Y&goto CONTINUE)

dir /b /s %INSTALL%\* > NUL 2>&1
	if %errorlevel% NEQ 0 (RD /S /Q "%Location%\Mount" > NUL 2>&1
						   MD %INSTALL% > NUL 2>&1)

:CONTINUE
if "%CLEAR%"=="Y" (
    echo.
    choice /C YN /M "► Do you want to continue from your previous work? (Y=yes, N=no)"
    cls
    if errorlevel 2 (
        goto menu
    )
    REM Kullanıcı "Y" seçeneğini seçtiğinde, belirtilen etikete gidilecek.
    goto menu
) else (
    REM Kullanıcı "N" seçeneğini seçtiğinde, "Dismount" işlemi yapılacak.
    Dism /Unmount-image /MountDir:%INSTALL% /Discard
)

:menu
set choice=NT
mode con cols=100 lines=35
cls
echo.      
echo  %color%╭──────────────────────────────────────╮
echo  %color%│  S h a d e s  T o o l k i t  %ver% │
echo  %color%╰──────────────────────────────────────╯
echo.
echo   [1] Source
echo.
echo   [2] Integrate
echo.
echo   [3] Debaloat
echo.
echo   [4] Windows Features
echo.
echo   [5] Customize
echo.
echo   [6] Fine Tuning
echo.
echo   [7] Windows Services
echo.
echo   [8] Apply Changes
echo.
echo   [9] Other
echo.
echo.
echo   [D] Give Support      [X] Exit
echo  %color%──────────────────────────────────────
set /p choice= Please choose an option : 
if "%choice%" == "1" goto source
if "%choice%" == "2" goto entegre
if "%choice%" == "3" goto debloat
if "%choice%" == "4" goto etkin_devredısı
if "%choice%" == "5" goto customize
if "%choice%" == "6" goto ince_ayarlar
if "%choice%" == "7" goto windows_services
if "%choice%" == "8" goto dismount_commit
if "%choice%" == "9" goto wim_menu
if "%choice%" == "d" goto DESTEK
if "%choice%" == "D" goto DESTEK
if "%choice%" == "x" goto end
if "%choice%" == "X" goto end
goto menu

:DESTEK
start "" "Bin\Thanx.html"
cls
goto menu

:windows_services
if exist "Mount\Install\Windows\regedit.exe" (
  cls
  goto :windows_services_start
) else (
  cls
echo %color%────────────────────────────────────────────────────
echo ► Uyarı : Please perform the mount process first!
echo %color%────────────────────────────────────────────────────
  pause
  cls
  goto menu
)
:windows_services_start
cls
set choice=NT
mode con cols=140 lines=37
echo.      
echo  %color%╭──────────────────────────────────────╮
echo  %color%│  S h a d e s  T o o l k i t  %ver% │
echo  %color%╰──────────────────────────────────────╯
echo.
echo  [1] Sysmain Disable
echo  [2] Print Spooler Disable
echo  [3] Error Reporting Service Disable
echo  [4] Fax Service Disable
echo  [5] Phone Service Disable
echo  [6] Remote Desktop Service Disable
echo  [7] Windows Backup Service Disable
echo  [8] Windows Defender Service Disable
echo  [9] Windows Defender Firewall Disable
echo  [10] Windows Insider Service Disable
echo  [11] Windows Search Disable
echo  [12] Windows Update Service Disable
echo  [13] Windows Update Health Service Disable
echo  [14] Application Layer Gateway Service Disable
echo  [15] Application Management Service Disable
echo  [16] Bluetooth Audio Gateway Service Disable
echo  [17] Bluetooth Support Service Disable
echo  [18] Capture Service Disable
echo  [19] Certificate Propagation Disable
echo  [20] Device Management Wireless Application Protocol Disable
echo  [21] Downloaded Maps Manager Disable
echo  [22] Geolocation Service Disable
echo  [23] Internet Connection Sharing (ICS) Disable
echo  [24] IP Helper (IPv6 Translation) Disable
echo  [25] IP Translation Configuration Service (IPv6 Translation) Disable
echo  [26] Disable All Services

echo.            
echo  %color%────────────────────────────────────────────────
echo.        [Z] Back                   [X] Exit
echo  %color%────────────────────────────────────────────────
echo.
set /p choice= Please choose an option : 
if %choice% EQU 1 (Call :Settings_Regedit "Disable_Sysmain")
if %choice% EQU 2 (Call :Settings_Regedit "Diable_PrintSpooler")
if %choice% EQU 3 (Call :Settings_Regedit "Disabe_ErrorReportingService")
if %choice% EQU 4 (Call :Settings_Regedit "Disable_Faks")
if %choice% EQU 5 (Call :Settings_Regedit "Disable_TelefonHizmeti")
if %choice% EQU 6 (Call :Settings_Regedit "Disable_Uzak Masaüstü Hizmetleri")
if %choice% EQU 7 (Call :Settings_Regedit "Disable_WindowsBackup")
if %choice% EQU 8 (Call :Settings_Regedit "Disable_WindowsDefender")
if %choice% EQU 9 (Call :Settings_Regedit "Disable_WindowsDefenderGüvenlikDuvarı")
if %choice% EQU 10 (Call :Settings_Regedit "Disable_WindowsInsiderHizmeti")
if %choice% EQU 11 (Call :Settings_Regedit "Disable_WindowsSearch")
if %choice% EQU 12 (Call :Settings_Regedit "Disable_WindowsUpdate")
if %choice% EQU 13 (Call :Settings_Regedit "Diable_MicrosoftUpdateHealthService")
if %choice% EQU 14 (Call :Settings_Regedit "ALG")
if %choice% EQU 15 (Call :Settings_Regedit "AppMgmt")
if %choice% EQU 16 (Call :Settings_Regedit "BTAGService")
if %choice% EQU 17 (Call :Settings_Regedit "bthserv")
if %choice% EQU 18 (Call :Settings_Regedit "CaptureService")
if %choice% EQU 19 (Call :Settings_Regedit "CertPropSvc")
if %choice% EQU 20 (Call :Settings_Regedit "dmwappushsvc")
if %choice% EQU 21 (Call :Settings_Regedit "MapsBroker")
if %choice% EQU 22 (Call :Settings_Regedit "lfsvc")
if %choice% EQU 23 (Call :Settings_Regedit "SharedAccess")
if %choice% EQU 24 (Call :Settings_Regedit "iphlpsvc")
if %choice% EQU 25 (Call :Settings_Regedit "IpxlatCfgSvc")
if %choice% EQU 26 goto DisableAllSerevices
if "%choice%" == "z" goto :menu
if "%choice%" == "Z" goto :menu
if "%choice%" == "x" goto :end
if "%choice%" == "X" goto :end
goto :windows_services

:DisableAllSerevices
Call :Settings_Regedit "Disable_Sysmain")
Call :Settings_Regedit "Diable_PrintSpooler")
Call :Settings_Regedit "Disabe_ErrorReportingService")
Call :Settings_Regedit "Disable_Faks")
Call :Settings_Regedit "Disable_TelefonHizmeti")
Call :Settings_Regedit "Disable_Uzak Masaüstü Hizmetleri")
Call :Settings_Regedit "Disable_WindowsBackup")
Call :Settings_Regedit "Disable_WindowsDefender")
Call :Settings_Regedit "Disable_WindowsDefenderGüvenlikDuvarı")
Call :Settings_Regedit "Disable_WindowsInsiderHizmeti")
Call :Settings_Regedit "Disable_WindowsSearch")
Call :Settings_Regedit "Disable_WindowsUpdate")
Call :Settings_Regedit "Diable_MicrosoftUpdateHealthService")
Call :Settings_Regedit "ALG")
Call :Settings_Regedit "AppMgmt")
Call :Settings_Regedit "BTAGService")
Call :Settings_Regedit "bthserv")
Call :Settings_Regedit "CaptureService")
Call :Settings_Regedit "CertPropSvc")
Call :Settings_Regedit "dmwappushsvc")
Call :Settings_Regedit "MapsBroker")
Call :Settings_Regedit "lfsvc")
Call :Settings_Regedit "SharedAccess")
Call :Settings_Regedit "iphlpsvc")
Call :Settings_Regedit "IpxlatCfgSvc")
echo.
echo Disabled All Services..
pause
goto windows_services

:etkin_devredısı
if exist "Mount\Install\Windows\regedit.exe" (
  cls
  goto :etkin_devredısı_start
) else (
  cls
echo %color%────────────────────────────────────────────────────
echo ► Uyarı : Please perform the mount process first!
echo %color%────────────────────────────────────────────────────
  pause
  cls
  goto menu
)
:etkin_devredısı_start
set choice=NT
cls
echo.      
echo  %color%╭──────────────────────────────────────╮
echo  %color%│  S h a d e s  T o o l k i t  %ver% │
echo  %color%╰──────────────────────────────────────╯
echo.
echo   [1] Enable Windows Features
echo   [2] Disable Windows Features
echo.
echo   [Z] Back                [X] Exit
echo  %color%──────────────────────────────────────
echo.
set /p choice= Please choose an option : 
if "%choice%" == "1" goto özellik_etkinlestir
if "%choice%" == "2" goto özellik_devredısı
if "%choice%" == "z" goto menu
if "%choice%" == "Z" goto menu
if "%choice%" == "x" goto end
if "%choice%" == "X" goto end
goto etkin_devredısı

:özellik_etkinlestir
mode con cols=125 lines=50
cls
set choice=NT
echo.      
echo  %color%╭──────────────────────────────────────╮
echo  %color%│  S h a d e s  T o o l k i t  %ver% │
echo  %color%╰──────────────────────────────────────╯
echo.
echo  [1] DirectPlay
echo  [2] Microsoft Windows Subsystem for Linux
echo  [3] .NET Framework 3.5
echo  [4] Print to PDF feature
echo  [5] XPS Services feature
echo  [6] Search Engine Client Pack
echo  [7] Telnet Client
echo  [8] Legacy Components
echo  [9] WorkFolders Client
echo  [10] Printing Essentials
echo  [11] Internet Printing Client
echo  [12] Microsoft Remote Desktop Infrastructure
echo  [13] Virtual Machine Platform
echo  [14] Simple TCP
echo  [15] .NET Framework 4 Advanced Services
echo  [16] Microsoft Hyper-V
echo  [17] Windows Media Player
echo  [18] SMB1 Protocol
echo.
echo  [Z] Back                [X] Exit
echo  %color%──────────────────────────────────────
echo.
set /p choice= Please choose an option : 
if "%choice%" == "1" goto DirectPlay
if "%choice%" == "2" (Call :EnableFeature Microsoft-Windows-Subsystem-Linux)
if "%choice%" == "3" (Call :EnableFeature NetFx3)
if "%choice%" == "4" (Call :EnableFeature Printing-PrintToPDFServices-Features)
if "%choice%" == "5" (Call :EnableFeature Printing-XPSServices-Features)
if "%choice%" == "6" (Call :EnableFeature SearchEngine-Client-Package)
if "%choice%" == "7" (Call :EnableFeature TelnetClient)
if "%choice%" == "8" (Call :EnableFeature LegacyComponents)
if "%choice%" == "9" (Call :EnableFeature WorkFolders-Client)
if "%choice%" == "10" (Call :EnableFeature Printing-Foundation-Features)
if "%choice%" == "11" (Call :EnableFeature Printing-Foundation-InternetPrinting-Client)
if "%choice%" == "12" (Call :EnableFeature MSRDC-Infrastructure)
if "%choice%" == "13" (Call :EnableFeature VirtualMachinePlatform)
if "%choice%" == "14" (Call :EnableFeature SimpleTCP)
if "%choice%" == "15" (Call :EnableFeature NetFx4-AdvSrvs)
if "%choice%" == "16" (Call :EnableFeature Microsoft-Hyper-V-All)
if "%choice%" == "17" (Call :EnableFeature WindowsMediaPlayer)
if "%choice%" == "18" (Call :EnableFeature SMB1Protocol)
if "%choice%" == "z" goto menu
if "%choice%" == "Z" goto menu
if "%choice%" == "x" goto end
if "%choice%" == "X" goto end
goto özellik_etkinlestir

:EnableFeature
cls
Dism /Image:Mount\Install /Enable-Feature /FeatureName:%~1
pause
goto özellik_etkinlestir

:DirectPlay
cls
Dism /Image:Mount\Install /Enable-Feature /FeatureName:LegacyComponents
Dism /Image:Mount\Install /Enable-Feature /FeatureName:DirectPlay
pause
goto özellik_etkinlestir

:özellik_devredısı
mode con cols=125 lines=50
cls
set choice=NT
echo.      
echo  %color%╭──────────────────────────────────────╮
echo  %color%│  S h a d e s  T o o l k i t  %ver% │
echo  %color%╰──────────────────────────────────────╯
echo.
echo  [1] DirectPlay
echo  [2] Microsoft Windows Subsystem for Linux
echo  [3] .NET Framework 3.5
echo  [4] Print to PDF feature
echo  [5] XPS Services feature
echo  [6] Search Engine Client Pack
echo  [7] Telnet Client
echo  [8] Legacy Components
echo  [9] WorkFolders Client
echo  [10] Printing Essentials
echo  [11] Internet Printing Client
echo  [12] Microsoft Remote Desktop Infrastructure
echo  [13] Virtual Machine Platform
echo  [14] Simple TCP
echo  [15] .NET Framework 4 Advanced Services
echo  [16] Microsoft Hyper-V
echo  [17] Windows Media Player
echo  [18] SMB1 Protocol
echo.
echo  [Z] Back                [X] Exit
echo  %color%──────────────────────────────────────
echo.
set /p choice= Please choose an option : 
echo.
echo
if "%choice%" == "1" (Call :DisableFeature DirectPlay)
if "%choice%" == "2" (Call :DisableFeature Microsoft-Windows-Subsystem-Linux)
if "%choice%" == "3" (Call :DisableFeature NetFx3)
if "%choice%" == "4" (Call :DisableFeature Printing-PrintToPDFServices-Features)
if "%choice%" == "5" (Call :DisableFeature Printing-XPSServices-Features)
if "%choice%" == "6" (Call :DisableFeature SearchEngine-Client-Package)
if "%choice%" == "7" (Call :DisableFeature TelnetClient)
if "%choice%" == "8" (Call :DisableFeature LegacyComponents)
if "%choice%" == "9" (Call :DisableFeature WorkFolders-Client)
if "%choice%" == "10" (Call :DisableFeature Printing-Foundation-Features)
if "%choice%" == "11" (Call :DisableFeature Printing-Foundation-InternetPrinting-Client)
if "%choice%" == "12" (Call :DisableFeature MSRDC-Infrastructure)
if "%choice%" == "13" (Call :DisableFeature VirtualMachinePlatform)
if "%choice%" == "14" (Call :DisableFeature SimpleTCP)
if "%choice%" == "15" (Call :DisableFeature NetFx4-AdvSrvs)
if "%choice%" == "16" (Call :DisableFeature Microsoft-Hyper-V)
if "%choice%" == "17" (Call :DisableFeature WindowsMediaPlayer)
if "%choice%" == "18" (Call :DisableFeature SMB1Protocol)
if "%choice%" == "z" goto menu
if "%choice%" == "Z" goto menu
if "%choice%" == "x" goto end
if "%choice%" == "X" goto end
goto özellik_devredısı

:DisableFeature
cls
Dism /Image:Mount\Install /Disable-Feature /FeatureName:%~1
pause
goto özellik_devredısı

:customize
if exist "Mount\Install\Windows\regedit.exe" (
  cls
  goto :customize_start
) else (
  cls
echo %color%────────────────────────────────────────────────────
echo ► Uyarı : Please perform the mount process first!
echo %color%────────────────────────────────────────────────────
  pause
  cls
  goto menu
)
:customize_start
set choice=NT
cls
echo.      
echo  %color%╭──────────────────────────────────────╮
echo  %color%│  S h a d e s  T o o l k i t  %ver% │
echo  %color%╰──────────────────────────────────────╯
echo.
echo  [1] Clean DefaultLayout.xml
echo  [2] System Settings
echo  [3] Compress System Files After System Startup
echo  [4] Create Autounattend.xml
echo  [5] Specify the Next Windows Version
echo  [6] Add MASS_AIO Windows Activation Script to Desktop
echo  [7] Customize Context Menu
echo  [8] Change OEM Information
echo  [9] Disable Transparency
echo  [10] Disable LockScreen Spotlight 
echo  [11] Enable Color Prevalence
echo  [12] Clean Taskbar
echo.
echo  [Z] Back                [X] Exit
echo  %color%──────────────────────────────────────
echo.
set /p choice= Please choose an option : 
if "%choice%" == "1" goto default_layout
if "%choice%" == "2" goto Sistem_Ayarları
if "%choice%" == "3" goto compress
if "%choice%" == "4" goto auto_unattend
if "%choice%" == "5" goto target_windows_version
if "%choice%" == "6" goto MASS_AIO
if "%choice%" == "7" goto ContextMenu
if "%choice%" == "8" goto OemChange
if "%choice%" == "9" Call :Settings_Regedit "DisableTransparency"
if "%choice%" == "10" Call :Settings_Regedit "DisableLockscreenSpootlight"
if "%choice%"  == "11" Call :Settings_Regedit "EnableColorPrevalence"
if "%choice%"  == "12" Call :Settings_Regedit "CleanTaskbar"
if "%choice%" == "z" goto menu
if "%choice%" == "Z" goto menu
if "%choice%" == "x" goto end
if "%choice%" == "X" goto end
goto customize

:OemChange
set choice=NT
cls
Call :Settings_Regedit "OEM"
Call :Settings_Regedit "UAC_Disable"

set "InstallFolder=C:\OEMINFO"
set "Install2Folder=Mount\Install\OEMINFO"
if not exist "%InstallFolder%" mkdir "%InstallFolder%"
chcp 437 > NUL 2>&1
Bin\MinSudo.exe --TrustedInstaller --NoLogo --Verbose --WorkDir="" cmd /c "PowerShell.exe -ExecutionPolicy Bypass -File "Bin\OemGenerator.ps1""
chcp 65001 >nul
xcopy /y /s "Bin\OEMInformation.bat" "%Install2Folder%\"
del /S /Q "Bin\OEMInformation.bat"
cls
echo.
echo %color%───────────────────────────
echo ► OEM Information saved.
echo %color%───────────────────────────
pause
goto customize_start

:ContextMenu
set choice=NT
cls
echo.      
echo  %color%╭──────────────────────────────────────╮
echo  %color%│  S h a d e s  T o o l k i t  %ver% │
echo  %color%╰──────────────────────────────────────╯
echo.
echo  [1] Add Windows Settings shortcut to Context Menu
echo  [2] Add new BATCH file shortcut to Context Menu
echo  [3] Add new VBScript file shortcut to Context Menu
echo  [4] Add Explorer restart shortcut to Context Menu
echo  [5] Add Empty Recycle Bin shortcut to Context Menu
echo  [6] Add Take Ownership shortcut to Context Menu

echo  [7] Add Select Context Menu
echo  [8] Add "Kill all not responding tasks" Context Menu
echo  [9] Add Optimize to Context Menu of Drives
echo  [10] Add Permanently Delete to Context Menu
echo  [11] Add Personalize (classic) context menu
echo  [12] Add Restart Explorer Context Menu
echo  [13] Add Safe Mode to Desktop Context Menu
echo  [14] Add SFC /SCANNOW Context Menu
echo  [15] Add "Open in Windows Terminal (Admin)" context menu
echo  [16] Add "Boot to Advanced Startup" Context Menu
echo  [17] Add "Advanced security" Context Menu
echo  [18] Add Change Owner to Context Menu
echo  [19] Add "Choose Power Plan" context menu
echo  [20] Add WinSxS Component Store Cleanup Context Menu
echo  [21] Add "Copy To folder" and "Move To folder" Context Menu
echo  [22] Add "Choose Light or Dark Mode" Context Menu
echo.
echo  [Z] Back                [X] Exit
echo  %color%──────────────────────────────────────
echo.
set /p choice= Please choose an option : 
if %choice% EQU 1 (Call :Settings_Regedit "AddWindowsToolsContextMenu")
if %choice% EQU 2 (Call :Settings_Regedit "AddNewBatchFileContextMenu")
if %choice% EQU 3 (Call :Settings_Regedit "AddNewVBScriptContextMenu")
if %choice% EQU 4 (Call :Settings_Regedit "AddRestartExplorerContextMenu")
if %choice% EQU 5 (Call :Settings_Regedit "EmptyRecycle")
if %choice% EQU 6 (Call :Settings_Regedit "Take_Ownership")
if %choice% EQU 7 (Call :Settings_Regedit "AddSelecttocontextmenu")
if %choice% EQU 8 (Call :Settings_Regedit "AddKillallnotRespondingTasks")
if %choice% EQU 9 (Call :Settings_Regedit "AddOptimizeDrivescontextmenu")
if %choice% EQU 10 (Call :Settings_Regedit "AddPermanentlydeletetocontextmenu")
if %choice% EQU 11 (Call :Settings_Regedit "AddPersonalizeclassictodesktopcontextmenu")
if %choice% EQU 12 (Call :Settings_Regedit "AddRestartExplorertodesktopcontextmenu")
if %choice% EQU 13 (Call :Settings_Regedit "AddSafeModetoDesktopcontextmenu")
if %choice% EQU 14 (Call :Settings_Regedit "AddSFCSCANNOWcontextmenu")
if %choice% EQU 15 (Call :Settings_Regedit "AddexpandableOpeninWindowsTerminalasadministrator")
if %choice% EQU 16 (Call :Settings_Regedit "AddBoottoAdvancedStartupcontext_menu")
if %choice% EQU 17 (Call :Settings_Regedit "AddAdvancedSecuritytocontextmenu")
if %choice% EQU 18 (Call :Settings_Regedit "AddChangeOwnertocontextmenu")
if %choice% EQU 19 (Call :Settings_Regedit "AddChoosePowerPlantoDesktopContextMenu")
if %choice% EQU 20 (Call :Settings_Regedit "AddComponentStoreCleanupcontextmenu")
if %choice% EQU 21 (Call :Settings_Regedit "AddCopyMoveToFoldertocontextmenu")
if %choice% EQU 22 (Call :Settings_Regedit "AddChooseLightorDarkModetodesktopcontextmenu")
if "%choice%" == "z" goto customize
if "%choice%" == "Z" goto customize
if "%choice%" == "x" goto end
if "%choice%" == "X" goto end
goto ContextMenu

:MASS_AIO
cls
echo.
xcopy /Y /E Bin\MAS_AIO.cmd Mount\Install\Users\Default\Desktop\
RD /S /Q Mount\Install\Users\Default\Desktop\Driver
RD /S /Q Mount\Install\Users\Default\Desktop\$OEM$
RD /S /Q Mount\Install\Users\Default\Desktop\Files
RD /S /Q Mount\Install\Users\Default\Desktop\Lisans
RD /S /Q Mount\Install\Users\Default\Desktop\TurnReg
RD /S /Q Mount\Install\Users\Default\Desktop\MicrosoftStore
RD /S /Q Mount\Install\Users\Default\Desktop\Regedit
RD /S /Q Mount\Install\Users\Default\Desktop\Regs 
echo.
pause
goto customize

:target_windows_version
set choice=NT
cls
echo.      
echo  %color%╭──────────────────────────────────────╮
echo  %color%│  S h a d e s  T o o l k i t  %ver% │
echo  %color%╰──────────────────────────────────────╯
echo.
echo  [1] Set the next version as 23H2
echo  [2] Set the next version as 22H2
echo  [3] Set the next version as 21H2
echo  [4] Set the next version as 21H1
echo  [5] Set the next version as 20H2
echo  [6] Set the next version as 2004
echo  [7] Set the next version as 1909
echo  [8] Set the next version as 1903
echo  [9] Set the next version as 1809
echo  [10] Set the next version as 1803
echo  [11] Set the next version as 1709
echo  [12] Set the next version as 1703
echo  [13] Set the next version as 1607
echo  [14] Set the next version as 1511
echo  [15] Set the next version as 1507
echo.
echo  [Z] Back                [X] Exit
echo  %color%──────────────────────────────────────
echo.
set /p choice= Please choose an option : 
if %choice% EQU 1 (Call :Settings_Regedit "23H2")
if %choice% EQU 2 (Call :Settings_Regedit "22H2")
if %choice% EQU 3 (Call :Settings_Regedit "21H2")
if %choice% EQU 4 (Call :Settings_Regedit "21H1")
if %choice% EQU 5 (Call :Settings_Regedit "20H2")
if %choice% EQU 6 (Call :Settings_Regedit "2004")
if %choice% EQU 7 (Call :Settings_Regedit "1909")
if %choice% EQU 8 (Call :Settings_Regedit "1903")
if %choice% EQU 9 (Call :Settings_Regedit "1809")
if %choice% EQU 10 (Call :Settings_Regedit "1803")
if %choice% EQU 11 (Call :Settings_Regedit "1709")
if %choice% EQU 12 (Call :Settings_Regedit "1703")
if %choice% EQU 13 (Call :Settings_Regedit "1607")
if %choice% EQU 14 (Call :Settings_Regedit "1511")
if %choice% EQU 15 (Call :Settings_Regedit "1507")
if "%choice%" == "z" goto menu
if "%choice%" == "Z" goto menu
if "%choice%" == "x" goto end
if "%choice%" == "X" goto end
goto customize

:auto_unattend
chcp 65001 >nul
rem Extracted klasöründeki autounattend.xml dosyasının kopyalanması
del Extracted\autounattend.xml
xcopy /Y /E Bin\autounattend.xml Extracted\
RD /S /Q Extracted\Driver
RD /S /Q Extracted\$OEM$
RD /S /Q Extracted\Files
RD /S /Q Extracted\Lisans
RD /S /Q Extracted\Regs
RD /S /Q Extracted\TurnReg
RD /S /Q Extracted\MicrosoftStore
RD /S /Q Extracted\Regedit
cls
chcp 437 > NUL 2>&1
rem Administrator adının sorulması ve xml dosyasındaki ShadesAdmin yazısıyla değiştirilmesi
echo.
set /p adminname=Please enter an admin name : 
(powershell -Command "(gc Extracted\autounattend.xml) -replace 'ShadesAdmin','%adminname%' | Out-File -Encoding UTF8 Extracted\autounattend.xml") >nul 2>&1
chcp 65001 >nul
chcp 437 > NUL 2>&1
rem Parolanın sorulması ve xml dosyasındaki password_change yazısıyla değiştirilmesi
echo.
set /p new_password=Please enter a password : 
(powershell -Command "(gc Extracted\autounattend.xml) -replace 'password_change','%new_password%' | Out-File -Encoding UTF8 Extracted\autounattend.xml") >nul 2>&1
chcp 65001 >nul
cls
echo.
echo  %color%────────────────────────────────────────────────────────────────────────────
echo An autounattend.xml file has been created based on the settings you specified....
echo  %color%────────────────────────────────────────────────────────────────────────────
timeout /t 2 >nul
pause
cls
goto menu

:compress
cls
echo.
set "targetFolder=Extracted\sources\$OEM$\$$\Setup\Scripts"
mkdir "%targetFolder%"
Bin\MinSudo --TrustedInstaller --Verbose cmd /c "xcopy /Y /E Bin\$OEM$\$$\Setup\Scripts\compress.bat Extracted\sources\$OEM$\$$\Setup\Scripts"
RD /S /Q Extracted\sources\$OEM$\$$\Setup\Scripts\Driver
RD /S /Q Extracted\sources\$OEM$\$$\Setup\Scripts\$OEM$
RD /S /Q Extracted\sources\$OEM$\$$\Setup\Scripts\Files
RD /S /Q Extracted\sources\$OEM$\$$\Setup\Scripts\Lisans
RD /S /Q Extracted\sources\$OEM$\$$\Setup\Scripts\Regs
RD /S /Q Extracted\sources\$OEM$\$$\Setup\Scripts\TurnReg
RD /S /Q Extracted\sources\$OEM$\$$\Setup\Scripts\MicrosoftStore
RD /S /Q Extracted\sources\$OEM$\$$\Setup\Scripts\Regedit
::RD /S /Q Mount\Install\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp\Regs
echo.
pause
goto customize

:Sistem_Ayarları
set choice=NT
cls
echo.      
echo  %color%╭──────────────────────────────────────╮
echo  %color%│  S h a d e s  T o o l k i t  %ver% │
echo  %color%╰──────────────────────────────────────╯
echo.
echo  [1] Enable Windows Photo Viewer
echo  [2] Add Take Ownership to context menu
echo  [3] Remove 260 Character Limit
echo  [4] Disable Visual Feedback
echo  [5] Add End Task to context menu for unresponsive processes
echo  [6] Add Empty Recycle Bin to context menu
echo  [7] Disable Step Recorder
echo  [8] Disable AutoPlay
echo  [9] Disable Enhanced Storage (Advanced Format)
echo  [10] Disable Application Launch Tracking
echo  [11] Turn off XBox Game Bar
echo  [12] Disable Hardware Accelerated GPU Scheduling
echo  [13] Disable Sleep Mode
echo  [14] Add Volume Mixer to Taskbar (Windows 10)
echo  [15] Add Copy as Path to context menu
echo  [16] Disable JPEG Desktop Wallpaper Quality Reduction
echo  [17] Set Windows App Theme to Dark Mode
echo  [18] Set Windows Theme to Dark Mode
echo  [19] Add This PC Shortcut to Desktop
echo  [20] Add Control Panel Shortcut to Desktop             
echo.
echo  [Z] Back                [X] Exit
echo  %color%──────────────────────────────────────
set /p choice=Please choose an option :
if %choice% EQU 1 (Call :Settings_Regedit "Restore_the_Windows_Photo_Viewer")
if %choice% EQU 2 (Call :Settings_Regedit "Take_Ownership")
if %choice% EQU 3 (Call :Settings_Regedit "Win32Disable")
if %choice% EQU 4 (Call :Settings_Regedit "VisualFeedbackOFF")
if %choice% EQU 5 (Call :Settings_Regedit "Add_Kill_all_not_responding_tasks_to_context_menu")
if %choice% EQU 6 (Call :Settings_Regedit "EmptyRecycle")
if %choice% EQU 7 (Call :Settings_Regedit "StepsRecorderDisable")
if %choice% EQU 8 (Call :Settings_Regedit "TurnOffAutoPlay")
if %choice% EQU 9 (Call :Settings_Regedit "AdvancedIndexing")
if %choice% EQU 10 (Call :Settings_Regedit "DisableAppLaunchTracking")
if %choice% EQU 11 (Call :Settings_Regedit "TurnOffXboxGameBar")
if %choice% EQU 12 (Call :Settings_Regedit "HardwareAcceleratedGPUSchedulingDisable")
if %choice% EQU 13 (Call :Settings_Regedit "DisableHibernate")
if %choice% EQU 14 (Call :Settings_Regedit "Oldvolumeapplet")
if %choice% EQU 15 (Call :Settings_Regedit "CopyAsPath")
if %choice% EQU 16 (Call :Settings_Regedit "Disable_JPEG_Desktop_wallpaper_import_quality")
if %choice% EQU 17 (Call :Settings_Regedit "Use_Dark_theme_color_for_default_app_mode_for_current_user")
if %choice% EQU 18 (Call :Settings_Regedit "Use_Dark_theme_color_for_default_Windows_mode_for_current_user")
if %choice% EQU 19 (Call :Settings_Regedit "Add_This-PC_Desktop_Icon")
if %choice% EQU 20 (Call :Settings_Regedit "Add_Control_Panel_Desktop_Icon")
if "%choice%" == "z" goto menu
if "%choice%" == "Z" goto menu
if "%choice%" == "x" goto end
if "%choice%" == "X" goto end
goto Sistem_Ayarları

:Settings_Regedit
set Error=0
RD /S /Q %Location%\Bin\TurnReg >NUL 2>&1
MD %Location%\Bin\TurnReg >NUL 2>&1
copy /y "%Location%\Bin\Regs\%~1.reg" "%Location%\Bin\TurnReg" >NUL 2>&1
FOR /f "tokens=*" %%g in ('dir /b /s %Location%\Bin\TurnReg\*.reg 2^>NUL') do (Call :Regedit_Convert_Rename "%%g") >NUL 2>&1
Call :Powershell_2 "Bin\ConvertReg.ps1" "%Location%\Bin\TurnReg" "%Location%\Bin\TurnReg" >NUL 2>&1
Call :RegeditInstall
FOR /F "tokens=*" %%g in ('dir /b /s %Location%\Bin\TurnReg\*.reg 2^>NUL') do (
	Call :Reg_Import %%g
)
Call :RegeditCollect
RD /S /Q "%Location%\Bin\TurnReg" >NUL 2>&1
goto :eof

:default_layout
cls
echo.
Bin\MinSudo --TrustedInstaller --Verbose cmd /c "xcopy /Y /E Bin\DefaultLayouts.xml Mount\Install\Users\Default\AppData\Local\Microsoft\Windows\Shell\"
Bin\MinSudo --TrustedInstaller --Verbose cmd /c "xcopy /Y /E Bin\LayoutModification.xml Mount\Install\Users\Default\AppData\Local\Microsoft\Windows\Shell\"
Bin\MinSudo --TrustedInstaller --Verbose cmd /c "xcopy /Y /E Bin\LayoutModification.json Mount\Install\Users\Default\AppData\Local\Microsoft\Windows\Shell\"
echo.
pause
goto customize

:entegre
if exist "Mount\Install\Windows\regedit.exe" (
  cls
  goto :entegre_start
) else (
  cls
echo %color%────────────────────────────────────────────────────
echo ► Uyarı : Please perform the mount process first!
echo %color%────────────────────────────────────────────────────
  pause
  cls
  goto menu
)
:entegre_start
set choice=NT
cls
echo.      
echo  %color%╭──────────────────────────────────────╮
echo  %color%│  S h a d e s  T o o l k i t  %ver% │
echo  %color%╰──────────────────────────────────────╯
echo.
echo  [1] Add Custom Registries
echo  [2] Add Custom Files
echo  [3] Integrate Drivers
echo  [4] Integrate Microsoft Store
echo  [5] Add Unattended Programs
echo  [6] Integrate VisualCppRedist AIO
echo.
echo  [Z] Back                [X] Exit
echo  %color%──────────────────────────────────────
echo.
set /p choice= Please choose an option :  
if "%choice%" == "1" goto custom_regedit
if "%choice%" == "2" goto özel_dosyalar
if "%choice%" == "3" goto driver_entegre
if "%choice%" == "4" goto MicrosoftStore
if "%choice%" == "5" goto app_install_start
if "%choice%" == "6" goto vcredist
if "%choice%" == "z" goto menu
if "%choice%" == "Z" goto menu
if "%choice%" == "x" goto end
if "%choice%" == "X" goto end
goto entegre

:vcredist
set choice=NT
cls
echo.
echo ► VCRedist downloading..
Bin\aria2c.exe --quiet=true  -x 16 -s 16 -d "./Mount/Install" "https://github.com/abbodi1406/vcredist/releases/download/v0.73.0/VisualCppRedist_AIO_x86_x64.exe"
Call :Settings_Regedit "vcredist"  >NUL
Call :Settings_Regedit "UAC_Disable"  >NUL
xcopy /y /s "Bin\vcredist.bat" "Mount\Install" >NUL
cls
echo.
chcp 65001 >NUL
echo ► The VCRedist has been integrated. Press any key to continue.
pause >NUL
cls
goto entegre_start

:app_install
set choice=NT
cls
if exist "Mount\Install\Windows\regedit.exe" (
  cls
  goto :MicrosoftStore_start
) else (
  cls
echo %color%────────────────────────────────────────────────────
echo ► Uyarı : Please perform the mount process first!
echo %color%────────────────────────────────────────────────────
  pause
  cls
  goto menu
)
:app_install_start
set choice=NT
cls
cls
echo.
echo ► This feature is still in testing phase. Please make sure the application you choose is unattended!
echo ► Copy the exe files you want to install to the Custom\UnattendApps folder.
pause
cls
Call :Settings_Regedit "start"
Call :Settings_Regedit "UAC_Disable"
REM Set the path to the installation folder
set "InstallFolder=C:\Programlar"
set "Install2Folder=Mount\Install\Programlar"

REM Create the installation folder if it doesn't exist
if not exist "%InstallFolder%" mkdir "%InstallFolder%"

REM Copy the setup files to the installation folder
xcopy /y /s "Bin\UnattendApps.bat" "%Install2Folder%\"
xcopy /y /s "Bin\UnattendAppsStart.bat" "%Install2Folder%\"
xcopy /y /s "Custom\UnattendApps\*.exe" "%Install2Folder%\"
pause
goto entegre_start

:MicrosoftStore
if exist "Mount\Install\Windows\regedit.exe" (
  cls
  goto :MicrosoftStore_start
) else (
  cls
echo %color%────────────────────────────────────────────────────
echo ► Uyarı : Please perform the mount process first!
echo %color%────────────────────────────────────────────────────
  pause
  cls
  goto menu
)
:MicrosoftStore_start
set choice=NT
cls
REM Microsoft Store ve gerekli componentler indirme işlemi
set "URL1=https://github.com/shadesofdeath/MicrosoftStore/raw/main/Microsoft.DesktopAppInstaller.msixbundle"
set "URL2=https://github.com/shadesofdeath/MicrosoftStore/raw/main/Microsoft.NET.Native.Framework.1.3.x64.appx"
set "URL3=https://github.com/shadesofdeath/MicrosoftStore/raw/main/Microsoft.NET.Native.Framework.2.2.x64.Appx"
set "URL4=https://github.com/shadesofdeath/MicrosoftStore/raw/main/Microsoft.NET.Native.Runtime.1.3.x64.appx"
set "URL5=https://github.com/shadesofdeath/MicrosoftStore/raw/main/Microsoft.NET.Native.Runtime.2.2.x64.Appx"
set "URL6=https://github.com/shadesofdeath/MicrosoftStore/raw/main/Microsoft.UI.Xaml.2.4.x64.Appx"
set "URL7=https://github.com/shadesofdeath/MicrosoftStore/raw/main/Microsoft.UI.Xaml.2.7.x64.Appx"
set "URL8=https://github.com/shadesofdeath/MicrosoftStore/raw/main/Microsoft.VCLibs.140.00.UWPDesktop.x64.appx"
set "URL9=https://github.com/shadesofdeath/MicrosoftStore/raw/main/Microsoft.VCLibs.140.00.x64.Appx"
set "URL10=https://github.com/shadesofdeath/MicrosoftStore/raw/main/Microsoft.WindowsStore.msixbundle"
set "URL11=https://github.com/shadesofdeath/MicrosoftStore/raw/main/Microsoft.XboxIdentityProvider.AppxBundle"

REM dosyaların kaydedileceği yolu seçin
set download_path=Custom\MicrosoftStore

REM aria2c'yi kullanarak dosyaları indirin
IF NOT EXIST Custom\MicrosoftStore\Microsoft.DesktopAppInstaller.msixbundle (
  Bin\aria2c.exe -x 16 -s 16 -d "%download_path%" "%URL1%"
)
IF NOT EXIST Custom\MicrosoftStore\Microsoft.NET.Native.Framework.1.3.x64.appx (
  Bin\aria2c.exe -x 16 -s 16 -d "%download_path%" "%URL2%"
)
IF NOT EXIST Custom\MicrosoftStore\Microsoft.NET.Native.Framework.2.2.x64.Appx (
  Bin\aria2c.exe -x 16 -s 16 -d "%download_path%" "%URL3%"
)
IF NOT EXIST Custom\MicrosoftStore\Microsoft.NET.Native.Runtime.1.3.x64.appx (
  Bin\aria2c.exe -x 16 -s 16 -d "%download_path%" "%URL4%"
)
IF NOT EXIST Custom\MicrosoftStore\Microsoft.NET.Native.Runtime.2.2.x64.Appx (
  Bin\aria2c.exe -x 16 -s 16 -d "%download_path%" "%URL5%"
)
IF NOT EXIST Custom\MicrosoftStore\Microsoft.UI.Xaml.2.4.x64.Appx (
  Bin\aria2c.exe -x 16 -s 16 -d "%download_path%" "%URL6%"
)
IF NOT EXIST Custom\MicrosoftStore\Microsoft.UI.Xaml.2.7.x64.Appx (
  Bin\aria2c.exe -x 16 -s 16 -d "%download_path%" "%URL7%"
)
IF NOT EXIST Custom\MicrosoftStore\Microsoft.VCLibs.140.00.UWPDesktop.x64.appx (
  Bin\aria2c.exe -x 16 -s 16 -d "%download_path%" "%URL8%"
)
IF NOT EXIST Custom\MicrosoftStore\Microsoft.VCLibs.140.00.x64.Appx (
  Bin\aria2c.exe -x 16 -s 16 -d "%download_path%" "%URL9%"
)
IF NOT EXIST Custom\MicrosoftStore\Microsoft.WindowsStore.msixbundle (
  Bin\aria2c.exe -x 16 -s 16 -d "%download_path%" "%URL10%"
)
IF NOT EXIST Custom\MicrosoftStore\Microsoft.XboxIdentityProvider.AppxBundle (
  Bin\aria2c.exe -x 16 -s 16 -d "%download_path%" "%URL11%"
)
cls
echo.
echo Microsoft Store and required packages downloaded..
set mountdir=Mount\Install
Dism /image:%mountdir% /Add-ProvisionedAppxPackage /PackagePath:Custom\MicrosoftStore\Microsoft.DesktopAppInstaller.msixbundle /LicensePath=Bin\Lisans\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.xml /region=all
Dism /image:%mountdir% /Add-ProvisionedAppxPackage /PackagePath:Custom\MicrosoftStore\Microsoft.NET.Native.Framework.1.3.x64.appx /SkipLicense /region=all
Dism /image:%mountdir% /Add-ProvisionedAppxPackage /PackagePath:Custom\MicrosoftStore\Microsoft.NET.Native.Framework.2.2.x64.Appx /SkipLicense /region=all
Dism /image:%mountdir% /Add-ProvisionedAppxPackage /PackagePath:Custom\MicrosoftStore\Microsoft.NET.Native.Runtime.1.3.x64.appx /SkipLicense /region=all
Dism /image:%mountdir% /Add-ProvisionedAppxPackage /PackagePath:Custom\MicrosoftStore\Microsoft.NET.Native.Runtime.2.2.x64.Appx /SkipLicense /region=all
Dism /image:%mountdir% /Add-ProvisionedAppxPackage /PackagePath:Custom\MicrosoftStore\Microsoft.UI.Xaml.2.4.x64.Appx /SkipLicense /region=all
Dism /image:%mountdir% /Add-ProvisionedAppxPackage /PackagePath:Custom\MicrosoftStore\Microsoft.UI.Xaml.2.7.x64.Appx /SkipLicense /region=all
Dism /image:%mountdir% /Add-ProvisionedAppxPackage /PackagePath:Custom\MicrosoftStore\Microsoft.VCLibs.140.00.UWPDesktop.x64.appx /SkipLicense /region=all
Dism /image:%mountdir% /Add-ProvisionedAppxPackage /PackagePath:Custom\MicrosoftStore\Microsoft.VCLibs.140.00.x64.Appx /SkipLicense /region=all
Dism /image:%mountdir% /Add-ProvisionedAppxPackage /PackagePath:Custom\MicrosoftStore\Microsoft.WindowsStore.msixbundle /SkipLicense /region=all
Dism /image:%mountdir% /Add-ProvisionedAppxPackage /PackagePath:Custom\MicrosoftStore\Microsoft.XboxIdentityProvider.AppxBundle /LicensePath=Bin\Lisans\Microsoft.XboxIdentityProvider_8wekyb3d8bbwe.xml /region=all
DISM.exe /Image:Mount\Install /Optimize-ProvisionedAppxPackages
pause
goto entegre

:driver_entegre
if exist "Mount\Install\Windows\regedit.exe" (
  cls
  goto :driver_entegre_start
) else (
  cls
echo %color%────────────────────────────────────────────────────
echo ► Uyarı : Please perform the mount process first!
echo %color%────────────────────────────────────────────────────
  pause
  cls
  goto menu
)
:driver_entegre_start
set choice=NT
cls
set mountdir=Mount\Install
set driverdir=Custom\Driver

if not exist "%driverdir%\*.inf" (
  echo Error: INF file not found in %driverdir% directory.
  pause
  goto entegre
)
dism /Image:%mountdir% /Add-Driver /Driver:%driverdir% /Recurse /ForceUnsigned
pause
goto entegre

:özel_dosyalar
if exist "Mount\Install\Windows\regedit.exe" (
  cls
  goto :özel_dosyalar_start
) else (
  cls
echo %color%────────────────────────────────────────────────────
echo ► Uyarı : Please perform the mount process first!
echo %color%────────────────────────────────────────────────────
  pause
  cls
  goto menu
)
:özel_dosyalar_start
set choice=NT
cls
echo.      
echo  %color%╭──────────────────────────────────────╮
echo  %color%│  S h a d e s  T o o l k i t  %ver% │
echo  %color%╰──────────────────────────────────────╯
echo.
echo  [1] Add Custom Cursor Files (Custom\Files\Windows\Cursors)
echo  [2] Add Custom Media Files (Custom\Files\Windows\Media)
echo  [3] Add Custom Theme Files (Custom\Files\Windows\Resources)
echo  [4] Add Custom System32 Files (Custom\Files\Windows\System32)
echo  [5] Add Custom SysWOW64 Files (Custom\Files\Windows\SysWOW64)
echo  [6] Add Custom Desktop Wallpaper Files (Custom\Files\Windows\Web)
echo  [7] Add Custom Desktop Files-Folders (Desktop)
echo.
echo  [Z] Back                [X] Exit
echo  %color%──────────────────────────────────────
echo.
set /p choice= Please choose an option :   
if "%choice%" == "1" goto custom_Cursors
if "%choice%" == "2" goto custom_Media
if "%choice%" == "3" goto custom_Resources
if "%choice%" == "4" goto custom_System32
if "%choice%" == "5" goto custom_SysWOW64
if "%choice%" == "6" goto custom_Web
if "%choice%" == "7" goto custom_Desktop
if "%choice%" == "8" goto entegre
if "%choice%" == "z" goto menu
if "%choice%" == "Z" goto menu
if "%choice%" == "x" goto end
if "%choice%" == "X" goto end
goto :özel_dosyalar

:custom_Desktop
cls
echo.
set source=Custom\Files\Desktop
set destination=Mount\Install\Users\Default\Desktop
xcopy /Y /E "%source%" "%destination%"
RD /S /Q Mount\Install\Users\Default\Desktop\Driver
RD /S /Q Mount\Install\Users\Default\Desktop\$OEM$
RD /S /Q Mount\Install\Users\Default\Desktop\Files
RD /S /Q Mount\Install\Users\Default\Desktop\Lisans
RD /S /Q Mount\Install\Users\Default\Desktop\Regs
RD /S /Q Mount\Install\Users\Default\Desktop\TurnReg
RD /S /Q Mount\Install\Users\Default\Desktop\MicrosoftStore
RD /S /Q Mount\Install\Users\Default\Desktop\Regedit
RD /S /Q Mount\Install\Users\Default\Desktop\Regs
echo.
pause
goto özel_dosyalar

:custom_Web
cls
echo.
set source=Custom\Files\Web
set destination=Mount\Install\Windows\Web\
set MinSudo=Bin\MinSudo.exe
%MinSudo% --TrustedInstaller --Verbose --WorkDir="Mount\Install\Windows" cmd /c "rmdir /S /Q Web"
xcopy /Y /E "%source%" "%destination%"
RD /S /Q Mount\Install\Windows\Web\Regs
echo.
pause
goto özel_dosyalar

:custom_SysWOW64
cls
echo.
set source=Custom\Files\SysWOW64
set destination=Mount\Install\Windows\SysWOW64\
xcopy /Y /E "%source%" "%destination%"
RD /S /Q Mount\Install\Windows\SysWOW64\Regs
echo.
pause
goto özel_dosyalar

:custom_System32
cls
echo.
set source=Custom\Files\System32
set destination=Mount\Install\Windows\System32\
xcopy /Y /E "%source%" "%destination%"
RD /S /Q Mount\Install\Windows\System32\Regs
echo.
pause
goto özel_dosyalar

:custom_Resources
cls
echo.
set source=Custom\Files\Resources
set destination=Mount\Install\Windows\Resources\
set MinSudo=Bin\MinSudo.exe
%MinSudo% --TrustedInstaller --Verbose --WorkDir="Mount\Install\Windows" cmd /c "rmdir /S /Q Resources"
xcopy /Y /E "%source%" "%destination%"
RD /S /Q Mount\Install\Windows\Resources\Regs
echo.
pause
goto özel_dosyalar

:custom_Media
cls
echo.
set source=Custom\Files\Media
set destination=Mount\Install\Windows\Media\
set MinSudo=Bin\MinSudo.exe
%MinSudo% --TrustedInstaller --Verbose --WorkDir="Mount\Install\Windows" cmd /c "rmdir /S /Q Media"
xcopy /Y /E "%source%" "%destination%"
RD /S /Q Mount\Install\Windows\Media\Regs
echo.
pause
goto özel_dosyalar

:custom_Cursors
cls
echo.
set source=Custom\Files\Cursors
set destination=Mount\Install\Windows\Cursors\
set MinSudo=Bin\MinSudo.exe
%MinSudo% --TrustedInstaller --Verbose --WorkDir="Mount\Install\Windows" cmd /c "rmdir /S /Q Cursors"
xcopy /Y /E "%source%" "%destination%"
RD /S /Q Mount\Install\Windows\Cursors\Regs
echo.
pause
goto özel_dosyalar

:custom_regedit
setlocal
set MOUNT_DIR=Mount\Install
set REG_DIR=Custom\Regedit

set Error=0
RD /S /Q Custom\Turn_Regedit > NUL 2>&1
MD Custom\Turn_Regedit > NUL 2>&1
FOR /f "tokens=*" %%g in ('dir /b /s Custom\Regedit\*.reg 2^>NUL') do (Call :Regedit_Convert_Rename "%%g")
timeout /t 2 /nobreak > NUL
Call :Powershell_2 "Bin\ConvertReg.ps1" "Custom\Regedit" "Custom\Turn_Regedit"
Call :RegeditInstall
FOR /F "tokens=*" %%g in ('dir /b /s Custom\Turn_Regedit\*.reg 2^>NUL') do (
	Call :Reg_Import %%g
)
Call :RegeditCollect
RD /S /Q "Custom\Turn_Regedit" > NUL 2>&1
timeout /t 2 /nobreak > NUL
if %Error% EQU 0 (echo Regedit insertion successful)
if %Error% EQU 1 (echo Regedit add failed)
pause
goto menu

:Regedit_Convert_Rename
Rename "%~1" "%Random%%~x1" > NUL 1>&1
goto :eof

:Reg_Import
echo ► "%~1" Adding regedit record...
Reg import %~1
	if %errorlevel% NEQ 0 (set Error=1)
goto :eof

:debloat
if exist "Mount\Install\Windows\regedit.exe" (
  cls
  goto :debloat_start
) else (
  cls
echo %color%────────────────────────────────────────────────────
echo ► Uyarı : Please perform the mount process first!
echo %color%────────────────────────────────────────────────────
  pause
  cls
  goto menu
)
:debloat_start
set choice=NT
cls
echo.      
echo  %color%╭──────────────────────────────────────╮
echo  %color%│  S h a d e s  T o o l k i t  %ver% │
echo  %color%╰──────────────────────────────────────╯
echo.
echo  [1] Debloat
echo  [2] Remove OneDrive
echo  [3] Uninstall Microsoft Edge
echo  [4] Remove Windows Defender
echo  [5] Remove Windows Recovery (WinRE)
echo  [6] Remove Internet Explorer
echo  [7] Uninstall Windows Media Player
echo  [8] Remove Microsoft Teams
echo.
echo  [Z] Back                [X] Exit
echo  %color%──────────────────────────────────────
echo.
set /p choice= Please choose an option :  
if "%choice%" == "1" goto debloat_bilgi
if "%choice%" == "2" goto onedrive
if "%choice%" == "3" goto edge
if "%choice%" == "4" goto defender
if "%choice%" == "5" goto WinRE
if "%choice%" == "6" goto Internet_Explorer
if "%choice%" == "7" goto Windows_Media_Player
if "%choice%" == "8" goto Microsoft_Teams
if "%choice%" == "z" goto menu
if "%choice%" == "Z" goto menu
if "%choice%" == "x" goto end
if "%choice%" == "X" goto end
goto debloat

:Microsoft_Teams
cls
echo.
set source=Bin\hosts
set destination=Mount\Install\Windows\System32\drivers\etc
xcopy /Y /E "%source%" "%destination%"
RD /S /Q Mount\Install\Windows\System32\drivers\etc\Regs
RD /S /Q Mount\Install\Windows\System32\drivers\etc\Driver
RD /S /Q Mount\Install\Windows\System32\drivers\etc\$OEM$
RD /S /Q Mount\Install\Windows\System32\drivers\etc\$OEM$
RD /S /Q Mount\Install\Windows\System32\drivers\etc\Files
RD /S /Q Mount\Install\Windows\System32\drivers\etc\Lisans
RD /S /Q Mount\Install\Windows\System32\drivers\etc\TurnReg
RD /S /Q Mount\Install\Windows\System32\drivers\etc\MicrosoftStore
RD /S /Q Mount\Install\Windows\System32\drivers\etc\Regedit
echo.
pause
goto debloat

:Windows_Media_Player
cls
echo.
set MinSudo=Bin\MinSudo.exe
set InstallDir=Mount\Install
for /f "delims=" %%i in ('dir /s /b /ad "%InstallDir%\*Windows Media Player*"') do (
    if exist "%%i" (
        %MinSudo% --TrustedInstaller --Verbose --Privileged --NoLogo --WorkDir="" cmd /c "rmdir /s /q "%%i""
    )
)
%MinSudo% --TrustedInstaller --Verbose --WorkDir="" cmd /c "del /S /Q "%InstallDir%\*Windows Media Player*""
%MinSudo% --TrustedInstaller --Verbose --WorkDir="" cmd /c "del /S /Q "%InstallDir%\*WindowsMediaPlayer*""
echo.
echo Uninstall is complete..
pause
goto debloat

:Internet_Explorer
cls
echo.
set MinSudo=Bin\MinSudo.exe
set InstallDir=Mount\Install
for /f "delims=" %%i in ('dir /s /b /ad "%InstallDir%\*Internet Explorer*"') do (
    if exist "%%i" (
        %MinSudo% --TrustedInstaller --Verbose --Privileged --NoLogo --WorkDir="" cmd /c "rmdir /s /q "%%i""
    )
)
%MinSudo% --TrustedInstaller --Verbose --WorkDir="" cmd /c "del /S /Q "%InstallDir%\*Internet Explorer*""
%MinSudo% --TrustedInstaller --Verbose --WorkDir="" cmd /c "del /S /Q "%InstallDir%\*InternetExplorer*""
echo.
echo Uninstall is complete..
pause
goto debloat

:defender
cls
echo.
set MinSudo=Bin\MinSudo.exe
set InstallDir=Mount\Install
for /f "delims=" %%i in ('dir /s /b /ad "%InstallDir%\*windows-defender*"') do (
    if exist "%%i" (
        %MinSudo% --TrustedInstaller --Verbose --Privileged --NoLogo --WorkDir="" cmd /c "rmdir /s /q "%%i""
    )
)
for /f "delims=" %%i in ('dir /s /b /ad "%InstallDir%\*guard.wim*"') do (
    if exist "%%i" (
        %MinSudo% --TrustedInstaller --Verbose --Privileged --NoLogo --WorkDir="" cmd /c "rmdir /s /q "%%i""
    )
)
for /f "delims=" %%i in ('dir /s /b /ad "%InstallDir%\*Windows Defender*"') do (
    if exist "%%i" (
        %MinSudo% --TrustedInstaller --Verbose --Privileged --NoLogo --WorkDir="" cmd /c "rmdir /s /q "%%i""
    )
)
for /f "delims=" %%i in ('dir /s /b /ad "%InstallDir%\*SecurityHealt*"') do (
    if exist "%%i" (
        %MinSudo% --TrustedInstaller --Verbose --Privileged --NoLogo --WorkDir="" cmd /c "rmdir /s /q "%%i""
    )
)
for /f "delims=" %%i in ('dir /s /b /ad "%InstallDir%\*smartscreen*"') do (
    if exist "%%i" (
        %MinSudo% --TrustedInstaller --Verbose --Privileged --NoLogo --WorkDir="" cmd /c "rmdir /s /q "%%i""
    )
)
for /f "delims=" %%i in ('dir /s /b /ad "%InstallDir%\*defender*"') do (
    if exist "%%i" (
        %MinSudo% --TrustedInstaller --Verbose --Privileged --NoLogo --WorkDir="" cmd /c "rmdir /s /q "%%i""
    )
)
for /f "delims=" %%i in ('dir /s /b /ad "%InstallDir%\*Smart Screen*"') do (
    if exist "%%i" (
        %MinSudo% --TrustedInstaller --Verbose --Privileged --NoLogo --WorkDir="" cmd /c "rmdir /s /q "%%i""
    )
)
for /f "delims=" %%i in ('dir /s /b /ad "%InstallDir%\*SecHealthUI*"') do (
    if exist "%%i" (
        %MinSudo% --TrustedInstaller --Verbose --Privileged --NoLogo --WorkDir="" cmd /c "rmdir /s /q "%%i""
    )
)
%MinSudo% --TrustedInstaller --Verbose --WorkDir="" cmd /c "del /S /Q "%InstallDir%\*guard.wim*""
%MinSudo% --TrustedInstaller --Verbose --WorkDir="" cmd /c "del /S /Q "%InstallDir%\*SecurityHealt*""
%MinSudo% --TrustedInstaller --Verbose --WorkDir="" cmd /c "del /S /Q "%InstallDir%\*smartscreen*""
%MinSudo% --TrustedInstaller --Verbose --WorkDir="" cmd /c "del /S /Q "%InstallDir%\*SecHealthUI*""
echo.
echo Uninstall is complete..
pause
goto debloat

:edge
cls
echo.
set MinSudo=Bin\MinSudo.exe
set InstallDir=Mount\Install
for /f "delims=" %%i in ('dir /s /b /ad "%InstallDir%\*Microsoft Edge*"') do (
    if exist "%%i" (
        %MinSudo% --TrustedInstaller --Verbose --Privileged --NoLogo --WorkDir="" cmd /c "rmdir /s /q "%%i""
    )
)
for /f "delims=" %%i in ('dir /s /b /ad "%InstallDir%\*EdgeCore*"') do (
    if exist "%%i" (
        %MinSudo% --TrustedInstaller --Verbose --Privileged --NoLogo --WorkDir="" cmd /c "rmdir /s /q "%%i""
    )
)
for /f "delims=" %%i in ('dir /s /b /ad "%InstallDir%\*EdgeUpdate*"') do (
    if exist "%%i" (
        %MinSudo% --TrustedInstaller --Verbose --Privileged --NoLogo --WorkDir="" cmd /c "rmdir /s /q "%%i""
    )
)
for /f "delims=" %%i in ('dir /s /b /ad "%InstallDir%\*Edge*"') do (
    if exist "%%i" (
        %MinSudo% --TrustedInstaller --Verbose --Privileged --NoLogo --WorkDir="" cmd /c "rmdir /s /q "%%i""
    )
)
%MinSudo% --TrustedInstaller --Verbose --WorkDir="" cmd /c "del /S /Q "%InstallDir%\*edge.wim*""
%MinSudo% --TrustedInstaller --Verbose --WorkDir="" cmd /c "del /S /Q "%InstallDir%\*EdgeProvider*""
cls
echo. 
echo Uninstall is complete..
pause
goto debloat

:WinRE
cls
echo.
set MinSudo=Bin\MinSudo.exe
set InstallDir=Mount\Install
for /f "delims=" %%i in ('dir /s /b /ad "%InstallDir%\*Winre.wim*"') do (
    if exist "%%i" (
        %MinSudo% --TrustedInstaller --Verbose --Privileged --NoLogo --WorkDir="" cmd /c "rmdir /s /q "%%i""
    )
)
%MinSudo% --TrustedInstaller --Verbose --WorkDir="" cmd /c "del /S /Q "%InstallDir%\*Winre.wim*""
echo.
echo Uninstall is complete..
pause
goto debloat

:onedrive
cls
echo.
set MinSudo=Bin\MinSudo.exe
set InstallDir=Mount\Install
for /f "delims=" %%i in ('dir /s /b /ad "%InstallDir%\*onedrive*"') do (
    if exist "%%i" (
        %MinSudo% --TrustedInstaller --Verbose --Privileged --NoLogo --WorkDir="" cmd /c "rmdir /s /q "%%i""
    )
)
%MinSudo% --TrustedInstaller --Verbose --WorkDir="" cmd /c "del /S /Q "%InstallDir%\*onedrive*""
%MinSudo% --TrustedInstaller --Verbose --WorkDir="" cmd /c "del /S /Q "%InstallDir%\*onedrive.wim*""
echo Uninstall is complete..
pause
goto debloat

:debloat_bilgi
cls
echo.
echo  %color%─────────────────────────────────────────────────────────────────────────────────────────────
echo  Note: The functionality of the ToolkitHelper method is more comprehensive and performs a more
echo  thorough cleanup compared to the Dism method. However, it runs much slower than the Dism method.
echo  %color%─────────────────────────────────────────────────────────────────────────────────────────────
pause
goto debloat_menu

:debloat_menu
set choice=NT
cls
echo.      
echo  %color%╭──────────────────────────────────────╮
echo  %color%│  S h a d e s  T o o l k i t  %ver% │
echo  %color%╰──────────────────────────────────────╯
echo.
echo   [1] Dism method
echo   [2] ToolkitHelper method
echo.
echo   [Z] Back                [X] Exit
echo  %color%──────────────────────────────────────
echo.
set /p choice= Please choose an option : 
if "%choice%" == "1" goto remove_app
if "%choice%" == "2" goto remove_components
if "%choice%" == "z" goto menu
if "%choice%" == "Z" goto menu
if "%choice%" == "x" goto end
if "%choice%" == "X" goto end
goto debloat_menu

:remove_components
set choice=NT
cls
chcp 437 > NUL 2>&1
Bin\MinSudo.exe --TrustedInstaller --NoLogo --Verbose --WorkDir="" cmd /c "PowerShell.exe -ExecutionPolicy Bypass -File "Bin\remove_components.ps1""
chcp 65001 >nul
cls
goto debloat_menu

:remove_app
if exist "Mount\Install\Windows\regedit.exe" (
  cls
  goto remove_app_start
) else (
  cls
echo %color%────────────────────────────────────────────────────
echo ► Uyarı : Please perform the mount process first!
echo %color%────────────────────────────────────────────────────
  pause
  cls
  goto debloat_menu
)
:remove_app_start
DEL /F /Q /A "%Location%\Temp\app_list2.txt" > NUL 2>&1
set selected_packages=NT
set i=1
Dism /Image:%INSTALL% /Get-ProvisionedAppxPackages | findstr /i "PackageName" > %Location%\Temp\app_list.txt
echo %errorlevel% > C:\error.txt
cls
mode con cols=130 lines=70
echo.
echo [X] - Uninstall all packages
for /f "tokens=2 delims=: " %%a in ('findstr /i "PackageName" %Location%\Temp\app_list.txt') do (
  echo [!i!] - %%a
  echo Appx_!i!_= %%a >> %Location%\Temp\app_list2.txt
  set /a i+=1
)
set /a i-=1
rem Paket adlarını listele ve seçim yap
echo.
echo [99] Back
echo.
set /p "selected_packages=Write the number of packages to be removed with commas (1-%i%): "
echo %selected_packages% | Findstr /i "99" > NUL 2>&1
	if %errorlevel% EQU 0 goto menu
echo %selected_packages% | Findstr /i "x" > NUL 2>&1
	if %errorlevel% EQU 0 (FOR /L %%a in (1,1,%i%) do (Call :Find_Appx_List %%a))
for %%a in (%selected_packages%) do (
	FOR /L %%b in (1,1,%i%) do (
		if %%b EQU %%a (Call :Find_Appx_List "%%a")
	)
)
cls
goto remove_app_start

:Find_Appx_List
for /f "tokens=2" %%g in ('findstr /i "Appx_%~1_" %Location%\Temp\app_list2.txt') do (
	cls
    echo.
    echo "%%g" uninstalling...
    echo.
    Call :Remove_Dism "%%g"
    cls
)
goto :eof

:Remove_Dism
Dism /Image:Mount\Install /Remove-ProvisionedAppxPackage /PackageName:%~1 > NUL 2>&1
	if %errorlevel% NEQ 0 (set Error=1
						   echo Uninstall failed.)
	if %errorlevel% EQU 0 (echo Uninstall successful.)
goto :eof

set remove_command=
set selected_packages=%selected_packages%
for /f "tokens=1 delims= " %%a in ("%selected_packages%") do (
  for /f "tokens=2" %%b in (!packages:~%%a*!) do (
    set remove_command=!remove_command! /remove-package="%%~b"
    echo Removing package: "%%~b"
    dism /Image:Mount\Install /remove-package="%%~b"
  )
)

rem Tamamlandı
if %Error% EQU 1 (echo Uninstallable apps available)
if %Error% EQU 0 (echo All uninstalls were successful)
echo .
pause
goto menu

:source
set choice=NT
cls
echo.      
echo  %color%╭──────────────────────────────────────╮
echo  %color%│  S h a d e s  T o o l k i t  %ver% │
echo  %color%╰──────────────────────────────────────╯
echo.
echo  [1] Extract ISO File to folder
echo  [2] Mount Install.wim
echo.
echo  [Z] Back     [X] Exit
echo  %color%──────────────────────────────────────
echo.
set /p choice= Please choose an option : 
if "%choice%" == "1" goto iso_extract
if "%choice%" == "2" goto mount_wim
if "%choice%" == "z" goto menu
if "%choice%" == "Z" goto menu
if "%choice%" == "x" goto end
if "%choice%" == "X" goto end
goto source

:mount_wim
set "extracted_dir=Extracted\sources"
set "install_wim=%extracted_dir%\install.wim"
set "install_esd=%extracted_dir%\install.esd"

if not exist "%install_wim%" (
    if exist "%install_esd%" (
        cls
        echo.
        echo ► Install.esd is detected. Go to the other named menu to convert it to "Install.wim" format.
        echo.
        pause
        goto wim_menu
    ) else (
        cls
        echo.
        echo ► Please extract your ISO File into ISO Folder !
        echo.
        pause
        goto source
    )
)
cls
echo.
set InstallWim=Extracted\sources\install.wim
:: install.wim içeriğini okuması için gönderiyoruz.
cls
mode con cols=130 lines=36
Call :Toolkit_Reader "%InstallWim%"
set /p Index=► Please enter index number : 
:: Çıkarma işlemi uygulanıyor..
FOR /F "tokens=3" %%a IN ('Dism /Get-WimInfo /WimFile:%InstallWim% /Index:%Index% ^| FIND "Architecture"') do (
	FOR /F "tokens=2 delims=:" %%b IN ('Dism /Get-WimInfo /WimFile:%InstallWim% /Index:%Index% ^| FIND "Name"') do (
		FOR /F "tokens=*" %%c in ('echo %%b') do (
      rd /s /q C:\$Recycle.Bin
			echo.
			echo ► Index: %Index% │ "%%c / %%a" Mounting...
			echo.
			Dism /Mount-Image /ImageFile:%InstallWim% /MountDir:"%Location%\Mount\Install" /Index:%Index%
		)
	)
)
pause
goto menu

:iso_extract
set choice=NT
cls
chcp 437 > NUL 2>&1
Bin\MinSudo.exe --TrustedInstaller --NoLogo --Verbose --WorkDir="" cmd /c "PowerShell.exe -ExecutionPolicy Bypass -File "Bin\iso_extract.ps1""
chcp 65001 >nul
cls
goto menu

:Index_Sil
set choice=NT
set "wimlib=Bin\wimlib-imagex.exe"
set "install_wim=Extracted\sources\install.wim"
set "mount_path=Mount\Install"
cls
echo.
echo  ► WARNING!
echo  There may be multiple versions inside the install.wim file. If you delete a main version,
echo  additional versions that depend on this main version may also be affected and deleted.
echo  Also, deleting a certain version may cause other versions to stop working.
echo  For instance, if you delete the Windows 10 Home version, the Windows 10 Pro version may also stop working.
echo  Deleting the versions one by one would be more accurate and safer.
echo.
pause
cls
Call :Toolkit_Reader "%InstallWim%"
echo.
set /p "delete_indexes=Enter the index numbers to be deleted, separated by commas: "
cls
echo.
echo ► Selected indexes are being deleted..
echo  %color%────────────────────────────────
set "indexes=%delete_indexes:,= %"
for %%i in (%indexes%) do (
  %wimlib% delete "%install_wim%" %%i
)
pause
goto wim_menu

:wim_menu
set choice=NT
cls
set "wimlib=Bin\wimlib-imagex.exe"
set "install_wim=Extracted\sources\install.wim"
echo.      
echo  %color%╭──────────────────────────────────────╮
echo  %color%│  S h a d e s  T o o l k i t  %ver% │
echo  %color%╰──────────────────────────────────────╯
echo.
echo  [1] Convert Wim to ESD
echo  [2] Convert ESD to Wim
echo  [3] Compress Wim file with LZMS (solid)
echo  [4] Remove version from Install.wim (Delete Index)
echo  [5] Create ISO file
echo  [6] Start Dism ResetBase operation
echo  [7] Modify Image Information
echo.
echo  [Z] Back                [X] Exit
echo  %color%──────────────────────────────────────
set /p choice= Please choose an option : 
if "%choice%" == "1" goto wim_esd
if "%choice%" == "2" goto esd_wim
if "%choice%" == "3" goto compress_wim
if "%choice%" == "4" goto Index_Sil
if "%choice%" == "5" goto make_iso
if "%choice%" == "6" goto dism_resetbase
if "%choice%" == "7" goto wim_name_desc
if "%choice%" == "z" goto menu
if "%choice%" == "Z" goto menu
if "%choice%" == "x" goto end
if "%choice%" == "X" goto end
goto wim_menu

:wim_name_desc
set name=NT
cls
echo.
echo %color%──────────────────────────────────────
set /p name= Enter Image Name: 
set /p desc= Enter Image Description: 
Bin\imagex.exe /info Extracted/sources/install.wim 1 "%name%" "%desc%"
cls
echo.
echo %color%──────────────────────────────────────────────────────────────────────────
echo  ► Image Name changed to [%name%] and Image Description changed to [%desc%]."
echo %color%──────────────────────────────────────────────────────────────────────────
pause
goto wim_menu

:dism_resetbase
cls
set choice=NT
set mountdir=Mount\Install
if exist %mountdir%\Windows (
    echo The Windows image is already mounted at the %mountdir% location. ResetBase process is continuing...
    Dism /Image:%mountdir% /Cleanup-Image /StartComponentCleanup /ResetBase
    pause
    goto wim_menu
) else (
    echo Error: The Windows image is not mounted at the %mountdir% location. Please mount the image and try again.
    pause
    goto wim_menu
)

:ince_ayarlar
if exist "Mount\Install\Windows\regedit.exe" (
  cls
  goto :ince_ayarlar_start
) else (
  cls
echo %color%────────────────────────────────────────────────────
echo ► Uyarı : Please perform the mount process first!
echo %color%────────────────────────────────────────────────────
  pause
  cls
  goto menu
)

:ince_ayarlar_start
cls
mode con cols=145 lines=40
set choice=NT
echo.      
echo  %color%╭──────────────────────────────────────╮
echo  %color%│  S h a d e s  T o o l k i t  %ver% │
echo  %color%╰──────────────────────────────────────╯
echo.
echo  [1] Bypass Windows 11 TPM/SecureBoot
echo  [2] Disable Reserved Storage
echo  [3] Remove "System requirements not met" watermark from desktop (Windows 11)
echo  [4] Disable Modern Standby
echo  [5] Disable Windows Defender
echo  [6] Disable "Let's finish setting up your device" prompt (Windows 11)
echo  [7] Disable Privacy Settings experience at sign-in (Windows 11)
echo  [8] Disable OneDrive
echo  [9] Disable Kernel Isolation Memory Integrity in Windows 11
echo  [10] Disable including drivers in Windows updates
echo  [11] Disable automatic Windows upgrades
echo  [12] Disable Cortana
echo  [13] Remove Chat button from Taskbar in Windows 11
echo  [14] Restore old right-click context menu in Windows 11
echo  [15] Change PowerShell execution policy level
echo  [16] Set user account control prompt to never notify
echo  [17] Show detailed information during Startup, Shutdown, Sign in, and Sign out
echo  [18] Automatically enable NumLock on startup
echo  [19] Hide Taskbar MeetNow icon (Windows 10)
echo  [20] Disable Bing search in Start Menu
echo  [21] Automatically skip "Press any key to continue" section in Windows Setup
echo  [22] Disable User Password expiration date
echo  [23] Enable the legacy Windows 7-like boot menu in Windows 10
echo  [24] Disable Telemetry.
echo  [25] Disable Sending Activity History to Microsoft.
echo  [26] Turn off showing recommended content in the Settings app.
echo  [27] Disable Advertising ID for Personalized Ads in Applications.
echo  [28] Disable Application Launch Tracking.
echo  [29] Do not allow Applications to Access Location.
echo  [30] Change DNS address
echo.
echo  [Z] Back                [X] Exit
echo  %color%──────────────────────────────────────
set /p choice=Please choose an option :

if %choice% EQU 1 goto tpmfix
if %choice% EQU 2 (Call :Settings_Regedit "Disable_Reserved_Storage")
if %choice% EQU 3 (Call :Settings_Regedit "Remove_System_requirements_not_met_watermark")
if %choice% EQU 4 (Call :Settings_Regedit "Disable_Modern_Standby") 
if %choice% EQU 5 (Call :Settings_Regedit "Disable_Microsoft_Defender_Antivirus")
if %choice% EQU 6 (Call :Settings_Regedit "Disable_Lets_finish_setting_up_your_device")
if %choice% EQU 7 (Call :Settings_Regedit "Disable_Choose_privacy_settings_experience_at_sign_in") 
if %choice% EQU 8 (Call :Settings_Regedit "Disable_OneDrive_for_all_users")
if %choice% EQU 9 (Call :Settings_Regedit "Turn_OFF_Core_isolation_Memory_integrity") 
if %choice% EQU 10 (Call :Settings_Regedit "Disable_include_drivers_with_Windows_Updates")
if %choice% EQU 11 (Call :Settings_Regedit "Never_Notify_or_Check_for_Updates")
if %choice% EQU 12 (Call :Settings_Regedit "Disable_Cortana")
if %choice% EQU 13 (Call :Settings_Regedit "Remove_Chat_button_on_taskbar_in_Windows_11") 
if %choice% EQU 14 (Call :Settings_Regedit "win11_classic_context_menu")
if "%choice%" == "15" goto PowerShell_Execution
if %choice% EQU 16 (Call :Settings_Regedit "UAC_Disable")
if %choice% EQU 17 (Call :Settings_Regedit "VerboseMessagesShow") 
if %choice% EQU 18 (Call :Settings_Regedit "AlwaysOpenNumLock")
if %choice% EQU 19 (Call :Settings_Regedit "Disable_Meet_Now")
if %choice% EQU 20 (Call :Settings_Regedit "DisableBingSearch")
if "%choice%" == "21" goto Disable_Press_And_Key
if "%choice%" == "22" goto UnlimitedPassword
if "%choice%" == "23" goto LegacyBoot
if %choice% EQU 24 (Call :Settings_Regedit "DisableTelemetry")
if %choice% EQU 25 (Call :Settings_Regedit "DisableSendActivityhistoryMicrosoft")
if %choice% EQU 26 (Call :Settings_Regedit "TurnOffSuggestedContentSettings")
if %choice% EQU 27 (Call :Settings_Regedit "TurnOffAvertisingID")
if %choice% EQU 28 (Call :Settings_Regedit "TurnOffAppLaunchTracking")
if %choice% EQU 29 (Call :Settings_Regedit "TurnOffLetAppsAccessYourLocation")
if "%choice%" == "30" goto Change_DNS
if "%choice%" == "z" goto menu
if "%choice%" == "Z" goto menu
if "%choice%" == "x" goto end
if "%choice%" == "X" goto end
goto :ince_ayarlar

:Change_DNS
cls
echo.      
echo  %color%╭──────────────────────────────────────╮
echo  %color%│  S h a d e s  T o o l k i t  %ver% │
echo  %color%╰──────────────────────────────────────╯
echo.
echo  [1] Google DNS
echo  [2] OpenDNS
echo  [3] DNS.WATCH
echo  [4] NortonConnectSafe
echo  [5] Level3 DNS
echo  [6] AdGuard DNS
echo  [7] Cloudflare DNS
echo.
echo  [8] Back
echo  %color%──────────────────────────────────────
echo.
set /p choice= Choice : 
if "%choice%"=="1" (
    Call :Settings_Regedit "GoogleDNS"
    Call :Settings_Regedit "UAC_Disable"
    xcopy /y /s "Bin\GoogleDNS.bat" "Mount\Install"
    cls
    echo.
    echo ► DNS Successfully changed !
    pause
    goto :Change_DNS
)

if "%choice%"=="2" (
    Call :Settings_Regedit "OpenDNS"
    Call :Settings_Regedit "UAC_Disable"
    xcopy /y /s "Bin\OpenDNS.bat" "Mount\Install"
    cls
    echo.
    echo ► DNS Successfully changed !
    pause
    goto :Change_DNS
)

if "%choice%"=="3" (
    Call :Settings_Regedit "DNSWATCH"
    Call :Settings_Regedit "UAC_Disable"
    xcopy /y /s "Bin\DNSWATCH.bat" "Mount\Install"
    cls
    echo.
    echo ► DNS Successfully changed !
    pause
    goto :Change_DNS
)

if "%choice%"=="4" (
    Call :Settings_Regedit "NortonConnectSafe"
    Call :Settings_Regedit "UAC_Disable"
    xcopy /y /s "Bin\NortonConnectSafe.bat" "Mount\Install"
    cls
    echo.
    echo ► DNS Successfully changed !
    pause
    goto :Change_DNS
)

if "%choice%"=="5" (
    Call :Settings_Regedit "Level3DNS"
    Call :Settings_Regedit "UAC_Disable"
    xcopy /y /s "Bin\Level3DNS.bat" "Mount\Install"
    cls
    echo.
    echo ► DNS Successfully changed !
    pause
    goto :Change_DNS
)

if "%choice%"=="6" (
    Call :Settings_Regedit "AdGuardDNS"
    Call :Settings_Regedit "UAC_Disable"
    xcopy /y /s "Bin\AdGuardDNS.bat" "Mount\Install"
    cls
    echo.
    echo ► DNS Successfully changedi !
    pause
    goto :Change_DNS
)

if "%choice%"=="7" (
    Call :Settings_Regedit "CloudflareDNS"
    Call :Settings_Regedit "UAC_Disable"
    xcopy /y /s "Bin\CloudflareDNS.bat" "Mount\Install"
    cls
    cls
    echo.
    echo ► DNS Successfully changed !
    pause
    goto :Change_DNS
)
if "%choice%"=="8" (
    cls
    goto :ince_ayarlar_start
)
goto :Change_DNS

:LegacyBoot
cls
Call :Settings_Regedit "legacyBoot" > NUL 2>&1
set "Install2Folder=Mount\Install"
xcopy /y /s "Bin\LegacyBoot.bat" "%Install2Folder%\" > NUL 2>&1
xcopy /y /s "Bin\LegacyBootStart.bat" "%Install2Folder%\" > NUL 2>&1
cls
echo %color%─────────────────────────────────────────────────────────────────────────
echo ► Transaction Successful!
echo %color%─────────────────────────────────────────────────────────────────────────
pause
goto :ince_ayarlar_start

:UnlimitedPassword
cls
Call :Settings_Regedit "unlimitedPassword"
set "Install2Folder=Mount\Install"
xcopy /y /s "Bin\UnlimitedPassword.bat" "%Install2Folder%\" > NUL 2>&1
xcopy /y /s "Bin\UnlimitedPasswordStart.bat" "%Install2Folder%\" > NUL 2>&1
cls
echo %color%─────────────────────────────────────────────────────────────────────────
echo ► Transaction Successful!
echo %color%─────────────────────────────────────────────────────────────────────────
pause
goto :ince_ayarlar_start

:Disable_Press_And_Key
cls
del /S /Q Extracted\efi\microsoft\boot\efisys.bin > NUL 2>&1
del /S /Q Extracted\efi\microsoft\boot\cdboot.efi > NUL 2>&1
ren Extracted\efi\microsoft\boot\efisys_noprompt.bin efisys.bin > NUL 2>&1
ren Extracted\efi\microsoft\boot\cdboot_noprompt.efi cdboot.efi > NUL 2>&1
cls
echo %color%─────────────────────────────────────────────────────────────────────────
echo ► Transaction Successful!
echo %color%─────────────────────────────────────────────────────────────────────────
pause
goto :ince_ayarlar_start

:PowerShell_Execution
set choice=NT
cls
echo.      
echo  %color%╭──────────────────────────────────────╮
echo  %color%│  S h a d e s  T o o l k i t  %ver% │
echo  %color%╰──────────────────────────────────────╯
echo.
echo  [1] Change PowerShell execution policy level to Restricted
echo  [2] Change PowerShell execution policy level to AllSigned
echo  [3] Change PowerShell execution policy level to RemoteSigned
echo  [4] Change PowerShell execution policy level to Unrestricted
echo  [5] Change PowerShell execution policy level to Bypass
echo.
echo  [Z] Back                [X] Exit
echo  %color%──────────────────────────────────────
set /p choice=Please choose an option :
if "%choice%" == "1" goto PowerShell_Execution_Restricted
if "%choice%" == "2" goto PowerShell_Execution_AllSigned
if "%choice%" == "3" goto PowerShell_Execution_RemoteSigned
if "%choice%" == "4" goto PowerShell_Execution_Unrestricted
if "%choice%" == "5" goto PowerShell_Execution_Bypass
if "%choice%" == "z" goto menu
if "%choice%" == "Z" goto menu
if "%choice%" == "x" goto end
if "%choice%" == "X" goto end
goto PowerShell_Execution

:PowerShell_Execution_Restricted
cls
cscript "Bin\Restricted.vbs"
Call :Settings_Regedit "Restricted"
pause
cls
goto PowerShell_Execution

:PowerShell_Execution_AllSigned
cscript "Bin\AllSigned.vbs"
Call :Settings_Regedit "AllSigned"
pause
cls
goto PowerShell_Execution

:PowerShell_Execution_RemoteSigned
cscript "Bin\RemoteSigned.vbs"
Call :Settings_Regedit "RemoteSigned"
pause
cls
goto PowerShell_Execution

:PowerShell_Execution_Unrestricted
cscript "Bin\Unrestricted.vbs"
Call :Settings_Regedit "Unrestricted"
pause
cls
goto PowerShell_Execution

:PowerShell_Execution_Bypass
cscript "Bin\Bypass.vbs"
Call :Settings_Regedit "Bypass"
pause
cls
goto PowerShell_Execution

:tpmfix
chcp 65001 >nul
cls
Dism /Mount-Image /ImageFile:Extracted/sources/boot.wim /MountDir:Mount/Boot/1 /Index:1
Call :Settings_Regedit_Boot "TPM"
Dism /unmount-Wim /MountDir:Mount/Boot/1 /commit
Bin\wimlib-imagex export Extracted\sources\boot.wim all Extracted\sources\boot_new.wim --wimboot --boot --compress=LZX
del /S /Q Extracted\sources\boot.wim > NUL 2>&1
ren Extracted\sources\boot_new.wim boot.wim
Dism /Mount-Image /ImageFile:Extracted/sources/boot.wim /MountDir:Mount/Boot/2 /Index:2
Call :Settings_Regedit_Boot "TPM"
Dism /unmount-Wim /MountDir:Mount/Boot/2 /commit
Bin\wimlib-imagex export Extracted\sources\boot.wim all Extracted\sources\boot_new.wim --wimboot --boot --compress=LZX
del /S /Q Extracted\sources\boot.wim > NUL 2>&1
ren Extracted\sources\boot_new.wim boot.wim
Bin\wimlib-imagex optimize Extracted\sources\boot.wim --recompress --nocheck
pause
goto ince_ayarlar

:Settings_Regedit_Boot
set Error=0
RD /S /Q %Location%\Bin\TurnReg > NUL 2>&1
MD %Location%\Bin\TurnReg > NUL 2>&1
copy /y "%Location%\Bin\Regs\%~1.reg" "%Location%\Bin\TurnReg" > NUL 2>&1
:: Offline regedit eklemek için Regedit klasörüne eklenen .reg dosyaları uygun şekilde düzenlenir.
:: Regedit kayıtlarında boşluk ve Türkçe harf olma ihtimaline karşılık isimlerine random sayılar veriyorum.
FOR /f "tokens=*" %%g in ('dir /b /s %Location%\Bin\TurnReg\*.reg 2^>NUL') do (Call :Regedit_Convert_Rename "%%g")
timeout /t 1 /nobreak > NUL
Call :Powershell_2 "Bin\ConvertReg.ps1" "%Location%\Bin\TurnReg" "%Location%\Bin\TurnReg"
Call :RegeditInstallBoot
:: Regedit kayıtlarını yükler
FOR /F "tokens=*" %%g in ('dir /b /s %Location%\Bin\TurnReg\*.reg 2^>NUL') do (
	Call :Reg_Import %%g
)
Call :RegeditCollect
RD /S /Q "%Location%\Bin\TurnReg" > NUL 2>&1
goto :eof

:RegeditInstallBoot
reg load HKLM\SHADES_COMPONENTS "Mount\Boot\1\Windows\System32\config\COMPONENTS" > NUL 2>&1
reg load HKLM\SHADES_HKU "Mount\Boot\1\Windows\System32\config\default" > NUL 2>&1
reg load HKLM\SHADES_HKCU "Mount\Boot\1\Users\Default\ntuser.dat" > NUL 2>&1
reg load HKLM\SHADES_SOFTWARE "Mount\Boot\1\Windows\System32\config\SOFTWARE" > NUL 2>&1
reg load HKLM\SHADES_SYSTEM "Mount\Boot\1\Windows\System32\config\SYSTEM" > NUL 2>&1
::----------------------------------------------------------------------------------
reg load HKLM\SHADES_COMPONENTS "Mount\Boot\2\Windows\System32\config\COMPONENTS" > NUL 2>&1
reg load HKLM\SHADES_HKU "Mount\Boot\2\Windows\System32\config\default" > NUL 2>&1
reg load HKLM\SHADES_HKCU "Mount\Boot\2\Users\Default\ntuser.dat" > NUL 2>&1
reg load HKLM\SHADES_SOFTWARE "Mount\Boot\2\Windows\System32\config\SOFTWARE" > NUL 2>&1
reg load HKLM\SHADES_SYSTEM "Mount\Boot\2\Windows\System32\config\SYSTEM" > NUL 2>&1
goto :eof

:make_iso
set choice=NT
cls
chcp 437 > NUL 2>&1
Bin\MinSudo.exe --TrustedInstaller --NoLogo --Verbose --WorkDir="" cmd /c "PowerShell.exe -ExecutionPolicy Bypass -File "Bin\CreateISO.ps1""
chcp 65001 >nul
cls
goto menu

:wim_esd
dism /Export-Image /SourceImageFile:Extracted\sources\install.wim /SourceIndex:1 /DestinationImageFile:Extracted\sources\install.esd /Compress:LZX /CheckIntegrity
echo.
echo Wim-Esd conversion completed! "Extracted\sources" saved in folder.
pause
goto wim_menu

:esd_wim
dism /Export-Image /SourceImageFile:Extracted\sources\install.esd /SourceIndex:1 /DestinationImageFile:Extracted\sources\install.wim /Compress:LZX /CheckIntegrity
echo.
echo ESD Wim conversion completed! "Extracted\sources" saved in folder.
pause
goto wim_menu

:compress_wim
set "source_file=.\Extracted\sources\install.wim"
set "dest_file=Extracted\sources\install_LZMS.wim"
set "export_param=all"
set "compress_param=lzms"
set wimlib=Bin\wimlib-imagex.exe
set "solid_param=--solid"
REM Wimlib imagex komutunu kullanarak install.wim dosyasını işleyin
%wimlib% export "%source_file%" "%export_param%" "%dest_file%" --compress="%compress_param%" %solid_param%
echo.
echo  %color%────────────────────────────────────────────────────────────────
echo.
echo Compressing wim file as LZMS completed!
pause
goto wim_menu

:dismount_commit
cls
if exist "Mount\Install\Windows\regedit.exe" (
  cls
  goto :dismount_commit_start
) else (
  cls
echo %color%─────────────────────────────────────────────────────────────────────────
echo ► Uyarı : Please perform the mount process first!
echo %color%─────────────────────────────────────────────────────────────────────────
  pause
  cls
  goto menu
)

:dismount_commit_start
cls
echo.
echo  [1] Dismount the WIM file and save changes
echo  [2] Dismount the WIM file without saving changes
echo.
set /p choice=Make your selection (1 or 2): 

if "%choice%"=="1" (
    cls
    echo.
    dism /unmount-Wim /MountDir:Mount\Install /commit
    cls
    Bin\wimlib-imagex export Extracted\sources\install.wim all Extracted\sources\install_new.wim --compress=Max
    cls
    del /S /Q Extracted\sources\install.wim > NUL 2>&1
    cls
    ren Extracted\sources\install_new.wim install.wim > NUL 2>&1
    cls
    Bin\wimlib-imagex optimize Extracted\sources\install.wim --recompress --nocheck
    cls
    echo.
    echo ► Changes have been saved.
) else if "%choice%"=="2" (
    cls
    echo.
    dism /unmount-Wim /MountDir:Mount\Install /discard
    pause
    echo.
    echo ► Changes have not been saved, unmount operation successful.
    goto menu
    cls
) else (
    cls
    echo.
    echo ► Invalid selection. Please enter 1 or 2.
)
pause
cls
echo.
set /p choice=► Save as ISO? (y/n)
if /i "%choice%"=="y" (
   goto make_iso
) else if /i "%choice%"=="n" (
   goto menu
) else (
   echo ► Invalid selection. Please choose either y or n.
)
goto menu

:end
cls
echo ► Logged out.
timeout /t 3
exit

:Powershell
:: Powershell komutları kullanıldığında komut istemi compact moda girmektedir. Bunu önlemek için karakter takımları arasında geçiş yapıyoruz.
chcp 437 > NUL 2>&1
Powershell -command %*
chcp 65001 > NUL 2>&1
goto :eof

:Powershell_2
:: Powershell komutları kullanıldığında komut istemi compact moda girmektedir. Bunu önlemek için karakter takımları arasında geçiş yapıyoruz.
chcp 437 > NUL 2>&1
Powershell -NoLogo -NoProfile -NonInteractive -ExecutionPolicy Bypass -Command %*
chcp 65001 > NUL 2>&1
goto :eof

:RegeditInstall
reg load HKLM\SHADES_COMPONENTS "Mount\Install\Windows\System32\config\COMPONENTS" > NUL 2>&1
reg load HKLM\SHADES_HKU "Mount\Install\Windows\System32\config\default" > NUL 2>&1
reg load HKLM\SHADES_HKCU "Mount\Install\Users\Default\ntuser.dat" > NUL 2>&1
reg load HKLM\SHADES_SOFTWARE "Mount\Install\Windows\System32\config\SOFTWARE" > NUL 2>&1
reg load HKLM\SHADES_SYSTEM "Mount\Install\Windows\System32\config\SYSTEM" > NUL 2>&1
goto :eof

:RegeditCollect
reg delete "HKLM\OFF_SYSTEM\CurrentControlSet" /f > NUL 2>&1
FOR /F "tokens=*" %%a in ('reg query "HKLM" ^| findstr "{"') do (
	reg unload "%%a" > NUL 2>&1
)
FOR /F "tokens=*" %%a in ('reg query "HKLM" ^| findstr "TK_"') do (
	reg unload "%%a" > NUL 2>&1
)
FOR /F "tokens=*" %%a in ('reg query "HKLM" ^| findstr "NLTmp~"') do (
	reg unload "%%a" > NUL 2>&1
)
FOR /F "tokens=*" %%a in ('reg query "HKLM" ^| findstr "SHADES_"') do (
	reg unload "%%a" > NUL 2>&1
)
goto :eof

:Toolkit_Reader
mode con cols=140 lines=40
chcp 65001 >nul
echo  ╭───────────┬──────────────────┬─────────────────┬─────────────────┬───────────────────┬────────────────────────────────────────╮
echo  │   INDEX   │   ARCHİTECTURE   │     VERSİON     │    LANGUAGE     │       EDİT        │                NAME                    │
FOR /F "tokens=3" %%a IN ('Dism /Get-WimInfo /WimFile:%~1 ^| FIND "Index"') DO (
	FOR /F "tokens=3" %%b IN ('Dism /Get-WimInfo /WimFile:%~1 /Index:%%a ^| FIND "Architecture"') DO (
		FOR /F "tokens=3" %%c in ('Dism /Get-WimInfo /WimFile:%~1  /Index:%%a ^| Find "Version"') do (
			FOR /F "tokens=3 delims=." %%d in ('"echo %%c"') do (
				FOR /F "tokens=4" %%e in ('Dism /Get-WimInfo /WimFile:%~1  /Index:%%a ^| Find "Build"') do (
					FOR /F "tokens=1" %%f in ('Dism /Get-WimInfo /WimFile:%~1  /Index:%%a ^| findstr /i Default') do (
						FOR /F "tokens=2 delims=':'" %%g in ('Dism /Get-WimInfo /WimFile:%~1  /Index:%%a ^| findstr /i Name') do (
							FOR /F "tokens=2 delims='-',':' " %%h in ('Dism /Get-WimInfo /WimFile:%~1  /Index:%%a ^| findstr /i Modified') do (
								echo  ├───────────┼──────────────────┼─────────────────┼─────────────────┼───────────────────┼────────────────────────────────────────╯
								echo  │     %%a            %%b              %%d.%%e            %%f             %%h             %%g                       
								)
							)
						)
					)
				)
			)
		)
	)
echo  ╰───────────┴──────────────────┴─────────────────┴─────────────────┴───────────────────┴─────────────────────────────────────────
goto :eof
