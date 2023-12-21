# Created by Tom R. 20231221

# Search for Schedued Tasks that may allow for Priv Esc.

# Powershell

#Find Tasks where author is not Microsoft or Blank
Get-ScheduledTask | Where-Object { $_.Author -notmatch "Microsoft" -and $_.Author -ne $null } | Select-Object TaskName, Author

#Show Executable Path of Task
	(Get-ScheduledTask -TaskName "TASK NAME").Actions


# cmd

schtasks /query /fo LIST /v > output.txt

# Search file as follows
#	 “Author:                               COMPUTERNAME”
	
#	 Filter for “run every minute”
#	“Repeat: Every:                        0 Hour(s), 1 Minute(s)”

