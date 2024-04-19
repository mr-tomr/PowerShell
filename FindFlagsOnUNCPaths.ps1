# Created by Tom R.

# Search a remote C$ for proof.txt or local.txt

Get-ChildItem -Path '\\name\c$\users' -Recurse -File | Where-Object { $_.Name -like '*proof.txt' -or $_.Name -like '*local.txt' } | Select-Object -ExpandProperty FullName

# Search server C$ drives, from a list of servers

Get-Content names.txt | ForEach-Object { $server = $_; "\\$server\c$\users" | Get-ChildItem -Recurse -File -ErrorAction SilentlyContinue | Where-Object { $_.Name -like '*proof.txt' -or $_.Name -like '*local.txt' } | Select-Object -ExpandProperty FullName }

# Cat each file it finds 

Get-Content names.txt | ForEach-Object { $server = $_; "\\$server\c$\users" | Get-ChildItem -Recurse -File -ErrorAction SilentlyContinue | Where-Object { $_.Name -like '*proof.txt' -or $_.Name -like '*local.txt' } | ForEach-Object { Write-Output "File: $($_.FullName)`n$($_ | Get-Content -Raw)`n" } }

# Cat each file and resolve IP from name

Get-Content names.txt | ForEach-Object { $server = $_; $ip = (Resolve-DnsName -Name $server).IPAddress; "\\$server\c$\users" | Get-ChildItem -Recurse -File -ErrorAction SilentlyContinue | Where-Object { $_.Name -like '*proof.txt' -or $_.Name -like '*local.txt' } | ForEach-Object { Write-Output "Server: $server (IP: $ip)`nFile: $($_.FullName)`n$($_ | Get-Content -Raw)`n" } }
