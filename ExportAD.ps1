Get-ADUser -filter * -properties passwordlastset | select name, passwordlastset | Export-csv "passwordsLastSet.csv"

Select-Object GivenName, Surname, Title, SamAccountName, Manager, DisplayName, City, EmailAddress, EmployeeID, Enabled, Department, OfficePhone, MobilePhone, LockedOut, LockOutTime, AccountExpirationDate, PasswordExpired, PasswordLastSet, LastLogonDate


Get-ADUser -filter * |Select GivenName, Surname, Title, SamAccountName, Manager, DisplayName, City, EmailAddress, EmployeeID, Enabled, Department, OfficePhone, MobilePhone, LockedOut, LockOutTime, AccountExpirationDate, PasswordExpired, PasswordLastSet, LastLogonDate

| Export-csv "passwordsLastSetFull.csv" 
