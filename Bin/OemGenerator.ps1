Add-Type -AssemblyName PresentationFramework

[xml]$xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="ShadesToolkit - OEM Information Changer" Height="250" Width="450"
        Background="White" Foreground="Black">
    <Grid Margin="0,15,0,0">
        <Grid.RowDefinitions>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="*"/>
        </Grid.RowDefinitions>
        <Grid.ColumnDefinitions>
            <ColumnDefinition Width="Auto"/>
            <ColumnDefinition Width="*"/>
        </Grid.ColumnDefinitions>

        <Label Grid.Row="0" Grid.Column="0" Foreground="Black">Uretici firma:</Label>
        <TextBox Grid.Row="0" Grid.Column="1" Width="300" Name="Manufacturer"
                 BorderThickness="1" BorderBrush="Black" Margin="5"/>

        <Label Grid.Row="1" Grid.Column="0" Foreground="Black">Model:</Label>
        <TextBox Grid.Row="1" Grid.Column="1" Width="300" Name="Model"
                 BorderThickness="1" BorderBrush="Black" Margin="5"/>

        <Label Grid.Row="2" Grid.Column="0" Foreground="Black">Destek Saatleri:</Label>
        <TextBox Grid.Row="2" Grid.Column="1" Width="300" Name="SupportHours"
                 BorderThickness="1" BorderBrush="Black" Margin="5"/>

        <Label Grid.Row="3" Grid.Column="0" Foreground="Black">Destek Telefon:</Label>
        <TextBox Grid.Row="3" Grid.Column="1" Width="300" Name="SupportPhone"
                 BorderThickness="1" BorderBrush="Black" Margin="5"/>

        <Label Grid.Row="4" Grid.Column="0" Foreground="Black">Destek URL:</Label>
        <TextBox Grid.Row="4" Grid.Column="1" Width="300" Name="SupportURL"
                 BorderThickness="1" BorderBrush="Black" Margin="5"/>

        <Button Grid.Row="5" Grid.Column="0" Grid.ColumnSpan="2" Name="SaveButton" HorizontalAlignment="Center" VerticalAlignment="Center" 
                Background="LightGray" Foreground="Black" BorderThickness="1" BorderBrush="Black" Padding="10 5" Margin="5"> Kaydet </Button>
    </Grid>
</Window>
"@

$reader = (New-Object System.Xml.XmlNodeReader $xaml)
$window = [Windows.Markup.XamlReader]::Load($reader)

$window.FindName("SaveButton").Add_Click({
    $manufacturer = $window.FindName("Manufacturer").Text
    $model = $window.FindName("Model").Text
    $supportHours = $window.FindName("SupportHours").Text
    $supportPhone = $window.FindName("SupportPhone").Text
    $supportURL = $window.FindName("SupportURL").Text

    $regFileContent = @"
@echo off
chcp 65001 >nul
if not "%1"=="am_admin" (powershell start -verb runas '%0' am_admin & exit /b)
set "InstallFolder=C:\OEMINFO"
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation" /v Manufacturer /d "$manufacturer" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation" /v Model /d "$model" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation" /v SupportHours /d "$supportHours" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation" /v SupportPhone /d "$supportPhone" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation" /v SupportURL /d "$supportURL" /f
rd /s /q "%InstallFolder%"
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "StartBatOem" /f
exit
"@

	$regFilePath = Join-Path -Path $PSScriptRoot -ChildPath "OEMInformation.bat"

	Set-Content -Path $regFilePath -Value $regFileContent

	[System.Windows.MessageBox]::Show("OEM Bilgileri kayit edildi!")
	exit


})

$window.ShowDialog()
