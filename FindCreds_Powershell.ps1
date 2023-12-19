# Created by Tom R. 20231219

# Steps to search for privilege escalation in Powershell
# History, Console History, Transcripts and Script Block Logging

# Standard PS History
get-history

# Locate Console History Location 
(Get-PSReadlineOption).HistorySavePath

# Files where name contains Transcript
Get-ChildItem -Path C:\Users -File -Recurse -ErrorAction SilentlyContinue | Where-Object { $_.Name -like '*transcript*' }

# Script Block Logging Within Logs
Get-WinEvent -LogName 'Microsoft-Windows-PowerShell/Operational' | Where-Object { $_.Id -eq 4104 } | ForEach-Object { $_.Message } | Select-String -Pattern 'authorization'

# Script Block Logging Searching for Base64
# I picked this one, because special things are often Base64 encoded

Get-WinEvent -LogName 'Microsoft-Windows-PowerShell/Operational' | Where-Object { $_.Id -eq 4104 } | ForEach-Object { $_.Message } | Select-String -Pattern 'Base64'

# Event Log Filter in GUI

<QueryList>
  <Query Id="0" Path="Microsoft-Windows-PowerShell/Operational">
    <Select Path="Microsoft-Windows-PowerShell/Operational">*[System[(EventID=4104)]]</Select>
  </Query>
  </QueryList>
