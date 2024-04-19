# Created by Tom R.

# Resolves the ips of servers, from list in file named "names.txt" in current directory.

Get-Content names.txt | ForEach-Object { $name = $_; $ip = (Resolve-DnsName $name).IPAddress; "$name $ip" } | Out-File resolved_ips.txt
