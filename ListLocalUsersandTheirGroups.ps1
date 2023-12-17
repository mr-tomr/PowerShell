# ListLocalUsersandTheirGroups.ps1
# Created by Tom R.   20231216
# One-liner to list all local users on computer and display their group memberships.

Get-WmiObject -Class Win32_UserAccount | ForEach-Object { $user = $_; $groups = $user.GetRelated('Win32_Group') | ForEach-Object { $_.Name }; Write-Host "User: $($user.Name)`nGroups: $($groups -join ', ')`n" }
