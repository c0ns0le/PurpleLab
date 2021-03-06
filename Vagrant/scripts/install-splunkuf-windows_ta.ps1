# Purpose: Installs the Splunk Universal Forwarder Windows Technical Add-On

Write-Host "$('[{0:HH:mm}]' -f (Get-Date)) Installing the Windows TA for Splunk"

If (Test-Path "C:\Program Files\SplunkUniversalForwarder\etc\apps\Splunk_TA_windows\default") {
  Write-Host "$('[{0:HH:mm}]' -f (Get-Date)) Windows TA is already installed. Moving on."
  Exit 0
}

# Install Windows TA
$windowstaPath = "C:\vagrant\resources\splunk_forwarder\splunk-add-on-for-microsoft-windows_800.tgz"
Write-Host "$('[{0:HH:mm}]' -f (Get-Date)) Installing the Windows TA"
Start-Process -FilePath "C:\Program Files\SplunkUniversalForwarder\bin\splunk.exe" -ArgumentList "install app $windowstaPath -auth admin:changeme" -NoNewWindow

# Create local directory
If (Test-Path "C:\Program Files\SplunkUniversalForwarder\etc\apps\Splunk_TA_windows\default") {
  $inputsPath = "C:\Program Files\SplunkUniversalForwarder\etc\apps\Splunk_TA_windows\local\inputs.conf"
  New-Item -ItemType Directory -Force -Path "C:\Program Files\SplunkUniversalForwarder\etc\apps\Splunk_TA_windows\local"
  Copy-Item c:\vagrant\resources\splunk_forwarder\windows_ta_inputs.conf $inputsPath -Force
}

# Add a check here to make sure the TA was installed correctly
Write-Host "$('[{0:HH:mm}]' -f (Get-Date)) Sleeping for 15 seconds"
Start-Sleep -s 15
If (Test-Path "C:\Program Files\SplunkUniversalForwarder\etc\apps\Splunk_TA_windows\default") {
  Write-Host "$('[{0:HH:mm}]' -f (Get-Date)) Windows TA installed successfully."
} Else {
  Write-Host "$('[{0:HH:mm}]' -f (Get-Date)) Something went wrong during installation."
  exit 1
}