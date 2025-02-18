<#
This script checks whether user accounts in accounts.txt have Kerberos delegation enabled in Active Directory. 

Specifically, it checks for:
    Unconstrained Delegation (TrustedForDelegation) – The account can impersonate users on any service.
    Constrained Delegation (TrustedToAuthForDelegation) – The account can impersonate users for specific services only.

Why does this matter?
    Unconstrained Delegation → High risk; attackers can abuse it for lateral movement.
    Constrained Delegation → Less risky but still a concern for privilege escalation.


#>

param (
    [string]$AccountName,  # Single account name
    [string]$FilePath,     # Path to file containing account names
    [switch]$AllUsers      # Confirm to check all AD users
)
 
# Function to check delegation status
function Get-DelegationStatus {
    param ($Account)
 
    $user = Get-ADUser -Identity $Account -Properties TrustedForDelegation, TrustedToAuthForDelegation -ErrorAction SilentlyContinue
 
    if ($user) {
        [PSCustomObject]@{
            Username      = $user.SamAccountName
            Unconstrained = if ($user.TrustedForDelegation) { "YES" } else { "NO" }
            Constrained   = if ($user.TrustedToAuthForDelegation) { "YES" } else { "NO" }
        }
    } else {
        [PSCustomObject]@{
            Username      = $Account
            Unconstrained = "Not Found"
            Constrained   = "Not Found"
        }
    }
}
 
# Function to display usage instructions
function Show-Usage {
    Write-Host "Usage:"
    Write-Host "  .\delegation_check.ps1 -AccountName <username>       # Check a single user"
    Write-Host "  .\delegation_check.ps1 -FilePath <path_to_file>      # Check users from a file"
    Write-Host "  .\delegation_check.ps1 -AllUsers                    # Check all AD users (confirmation required)"
    exit
}
 
# Initialize results array
$results = @()
 
# Case 1: Check a single user
if ($AccountName) {
    $results += Get-DelegationStatus -Account $AccountName
}
 
# Case 2: Check from a file
elseif ($FilePath) {
    if (Test-Path $FilePath) {
        $accounts = Get-Content $FilePath
        foreach ($account in $accounts) {
            $results += Get-DelegationStatus -Account $account
        }
    } else {
        Write-Host "Error: File not found: $FilePath" -ForegroundColor Red
        exit
    }
}
 
# Case 3: Check all AD users (requires confirmation)
elseif ($AllUsers) {
    $confirmation = Read-Host "Are you sure you want to scan all AD users? This may take a long time. (yes/no)"
    if ($confirmation -ne "yes") {
        Write-Host "Operation canceled."
        exit
    }
    $allUsers = Get-ADUser -Filter * -Properties TrustedForDelegation, TrustedToAuthForDelegation
    foreach ($user in $allUsers) {
        $results += [PSCustomObject]@{
            Username      = $user.SamAccountName
            Unconstrained = if ($user.TrustedForDelegation) { "YES" } else { "NO" }
            Constrained   = if ($user.TrustedToAuthForDelegation) { "YES" } else { "NO" }
        }
    }
}
 
# If no parameters were given, show usage info
else {
    Show-Usage
}
 
# Display results in table format
$results | Format-Table -AutoSize
