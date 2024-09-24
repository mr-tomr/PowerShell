# Map drive with credentials
# add Perisist Flag if you need to, on line 10 "-Persist"
# Remove-PSDrive -Name "Z" - to remove

$Username = "username"
$Password = "password"
$SecurePassword = ConvertTo-SecureString $Password -AsPlainText -Force
$Credential = New-Object System.Management.Automation.PSCredential($Username, $SecurePassword)

New-PSDrive -Name "Z" -PSProvider FileSystem -Root "\\10.10.10.1\share"  -Credential $Credential


# One liner

New-PSDrive -Name "Z" -PSProvider FileSystem -Root "\\10.10.10.1\share" -Persist -Credential (New-Object System.Management.Automation.PSCredential("username", (ConvertTo-SecureString "password" -AsPlainText -Force)))
