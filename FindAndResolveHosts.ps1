# Created by Tom R.

# One liner to search for live hosts from a compromised host that does not have tools installed.

1..255 | ForEach-Object { $ip = "172.16.113.$_"; if (Test-Connection -ComputerName $ip -Count 1 -Quiet) { $ip; Resolve-DnsName -Name $ip -ErrorAction SilentlyContinue } }

# Example Smaller Output

1..30 | ForEach-Object { $ip = "172.16.113.$_"; if (Test-Connection -ComputerName $ip -Count 1 -Quiet) { $ip; Resolve-DnsName -Name $ip -ErrorAction SilentlyContinue } }
