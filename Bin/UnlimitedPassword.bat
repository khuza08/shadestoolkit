@echo off
net accounts /maxpwage:unlimited
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "StartBatPass" /f
DEL "%~f0"
exit