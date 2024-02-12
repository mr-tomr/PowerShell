
# Uploaded by Tom R 20240212

# Source - https://techibee.com/active-directory/powershell-get-all-domains-and-domain-controllers-in-whole-forest/2868

 - GET-DCsInForest

function Get-DCsInForest {
[CmdletBinding()]
param(
    [string]$ReferenceDomain = $env:USERDOMAIN
)
$ForestObj = Get-ADForest -Server $ReferenceDomain
foreach($Domain in $ForestObj.Domains) {
    Get-ADDomainController -Filter * -Server $Domain | select Domain,HostName,Site
} 
}

Using .NET

	
[System.DirectoryServices.ActiveDirectory.Forest]::GetCurrentForest().Sites | % { $_.Servers } | select Domain,Name,SiteName



