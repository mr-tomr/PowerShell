# Used to retest various pentest findgins where confirming the password change date determines remediation.

# Import Active Directory module (if not already loaded)
Import-Module ActiveDirectory

# Define input and output files
$UserList = "users.txt"     # List of usernames (one per line)
$OutputFile = "pwd_last_set.txt"

# Clear previous output
"SamAccountName, PasswordLastSet" | Out-File -FilePath $OutputFile

# Loop through each user in users.txt
Get-Content $UserList | ForEach-Object {
    $user = $_.Trim()
    Write-Host "Checking: $user"

    # Query AD for PasswordLastSet
    $ADUser = Get-ADUser -Identity $user -Properties PasswordLastSet -ErrorAction SilentlyContinue

    if ($ADUser) {
        "$($ADUser.SamAccountName), $($ADUser.PasswordLastSet)" | Out-File -FilePath $OutputFile -Append
    } else {
        "$user, NOT FOUND" | Out-File -FilePath $OutputFile -Append
    }
}

Write-Host "Results saved to $OutputFile"



# If you would rather have a csv file
# "SamAccountName,PasswordLastSet" | Out-File -FilePath pwd_last_set.csv
# "$($ADUser.SamAccountName),$($ADUser.PasswordLastSet)" | Out-File -FilePath pwd_last_set.csv -Append
