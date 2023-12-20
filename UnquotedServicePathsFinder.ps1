# Created by Tom R.  20231220

# Displays services

# All Unquoted Serivce Paths
Get-CimInstance -ClassName Win32_Service | Select Name, State, PathName | Where-Object { $_.PathName -notlike "* *" }

# Unquoted Service Paths - Not in System Directory

Get-CimInstance -ClassName Win32_Service | Select Name, State, PathName | Where-Object { $_.PathName -notlike "* *" -and $_.PathName -notlike "C:\Windows\system32\*" }
