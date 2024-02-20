<#

Use for quickly checking large server lists for SMB Signing.

Created by Tom R.  20240220

In the script, the Get-SmbConnection cmdlet is used to establish a connection to the server. 
If the connection is successful, it indicates that the server supports SMB and, depending on the configuration, 
may require SMB signing. 

The script then checks whether SMB signing is enabled for the connection.
#>



# Path to the text file containing IP addresses
$file = "C:\tools\SMBSigning\servers.txt"

# Path to the output file
$outputFile = "C:\tools\SMBSigning\output.txt"
 
# Read the list of servers from the text file
$servers = Get-Content $file
 
# Create or overwrite the output file
New-Item -Path $outputFile -ItemType File -Force | Out-Null
 
foreach ($server in $servers) {
    Write-Output "Testing SMB signing for $server" | Out-File -Append $outputFile
    try {
        $smb = Get-SmbConnection -Server $server
        if ($smb) {
            Write-Output "SMB signing is enabled for $server" | Out-File -Append $outputFile
        } else {
            Write-Output "SMB signing is not enabled for $server" | Out-File -Append $outputFile
        }
    } catch {
        Write-Output "Failed to connect to $server" | Out-File -Append $outputFile
    }
}
