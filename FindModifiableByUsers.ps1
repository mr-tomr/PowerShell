# Created by Tom R. 20231220

# Locate files, typically from Service Binary Paths, which are modifiable by USERS

# Use this with https://github.com/mr-tomr/PowerShell/blob/master/FindNoInheretedPerms.ps1

# Write to Screen
Get-ChildItem -File -Recurse "c:\BackupMonitor" | Where-Object { $_.GetAccessControl().Access | Where-Object { $_.IdentityReference -eq 'NT AUTHORITY\Authenticated Users' -and $_.FileSystemRights -band [System.Security.AccessControl.FileSystemRights]::Modify } } | ForEach-Object { Write-Host "File: $($_.FullName)"; icacls $_.FullName }

# Write to File
Get-ChildItem -File -Recurse "c:\BackupMonitor" | Where-Object { $_.GetAccessControl().Access | Where-Object { $_.IdentityReference -eq 'NT AUTHORITY\Authenticated Users' -and $_.FileSystemRights -band [System.Security.AccessControl.FileSystemRights]::Modify } } | ForEach-Object { Write-Host "File: $($_.FullName)"; icacls $_.FullName } ullName } | Out-File "c:\temp\NonInheritedPermissions.txt"
