Get-ItemProperty -Path HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object Displayname, DisplayVersion, Publisher, InstallDate | Format-Table -Autosize

