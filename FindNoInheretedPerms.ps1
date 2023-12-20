# Created by Tom R. 20231220

# Command to search for files which do not have Inhereted permissions (I) in acls

# These show where someone intentionally set the permissions and could present vulnerabilites.

# Standard, display on screen
Get-ChildItem -File -Recurse "C:\path\to\directory" | Where-Object { $_.GetAccessControl().Access | Where-Object { -not $_.IsInherited } } | ForEach-Object { Write-Host "File: $($_.FullName)"; icacls $_.FullName }

# Write output to file
Get-ChildItem -File -Recurse "C:\path\to\directory" | Where-Object { $_.GetAccessControl().Access | Where-Object { -not $_.IsInherited } } | ForEach-Object { Write-Host "File: $($_.FullName)"; icacls $_.FullName } | Out-File "c:\temp\NonInheritedPermissions.txt"
