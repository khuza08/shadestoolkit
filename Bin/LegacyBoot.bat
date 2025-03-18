@echo off
bcdedit /set "{current}" bootmenupolicy legacy
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "LegacyBoot" /f
DEL "%~f0"
exit