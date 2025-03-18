Add-Type -AssemblyName PresentationFramework

$window = New-Object System.Windows.Window
$window.Title = "ShadesToolkit - ISO Creator"
$window.Width = 400
$window.Height = 200
$window.WindowStartupLocation = "CenterScreen"

$panel = New-Object System.Windows.Controls.StackPanel
$panel.Orientation = "Vertical"
$panel.Margin = "10"

$isoNameLabel = New-Object System.Windows.Controls.Label
$isoNameLabel.Content = "ISO Name:"
$panel.Children.Add($isoNameLabel)

$isoNameTextBox = New-Object System.Windows.Controls.TextBox
$isoNameTextBox.Width = 350
$panel.Children.Add($isoNameTextBox)

$isoLabelLabel = New-Object System.Windows.Controls.Label
$isoLabelLabel.Content = "ISO Label:"
$panel.Children.Add($isoLabelLabel)

$isoLabelTextBox = New-Object System.Windows.Controls.TextBox
$isoLabelTextBox.Width = 350
$panel.Children.Add($isoLabelTextBox)

$createButton = New-Object System.Windows.Controls.Button
$createButton.Content = "Make ISO"
$createButton.Width = 150
$createButton.Margin = "15"
$createButton.Add_Click({
    $isoName = $isoNameTextBox.Text
    $isoLabel = $isoLabelTextBox.Text
    $ISODir = "ISO"
    if (-not (Test-Path $ISODir)) {
        New-Item -ItemType Directory -Force -Path $ISODir | Out-Null
    }
    $IMAGE = "Extracted/"
    $ISOPath = Join-Path -Path $ISODir -ChildPath "$isoName.iso"
    if (Test-Path "$IMAGE\efi\microsoft\boot\efisys.bin") {
        & "Bin\oscdimg.exe" -l"$isoLabel" -m -oc -u2 -udfver102 -bootdata:2#p0,e,b"$IMAGE\boot\etfsboot.com"#pEF,e,b"$IMAGE\efi\microsoft\boot\efisys.bin" "$IMAGE" "$ISOPath"
    } else {
        & "Bin\oscdimg.exe" -l"$isoLabel" -m -oc -u2 -udfver102 -b"$IMAGE\boot\etfsboot.com" "$IMAGE" "$ISOPath"
    }
    [System.Windows.MessageBox]::Show("Your ISO file has been saved in the ISO folder.")
	exit
})
$panel.Children.Add($createButton)

$window.Content = $panel
$window.ShowDialog() | Out-Null
