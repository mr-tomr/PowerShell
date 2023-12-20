# Created by Tom R. 20231220

# Use to locate services whose paths are not the System Directory.

# Running Serivces
Get-CimInstance -ClassName win32_service | Select Name, State, PathName | Where-Object { $_.State -like 'Running' -and $_.PathName -notlike "C:\Windows\system32\*" }

# Running or Stopped - Better View
Get-CimInstance -ClassName win32_service | Select Name, State, PathName | Where-Object { $_.PathName -notlike "C:\Windows\system32\*" }
