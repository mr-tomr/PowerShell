# Created by Tom
# Created 20230526
# PowerShell Script to open list of websites in Firefox tabs
# You need to preset Firefox to use Burp before running

"C:\Program Files\Mozilla Firefox\firefox.exe"
$serverFile = "C:\Users\B009235\OneDrive - Macy's, Inc\Documents\_pentesting\2023\20230523-IPT-IPMI-Retest\ipmiretest2.txt"  # Path to the file containing server names

$servers = Get-Content $serverFile  # Read server names from file

foreach ($server in $servers) {
    $url = "https://$server"  # Construct the URL using the server name

    # Open the URL in a new Firefox tab
    Start-Process -FilePath "firefox.exe" -ArgumentList $url
}
