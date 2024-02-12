The secret to being able to run AD enumeration commands from the AD Powershell module on a system without RSAT installed, 
is the DLL located in C:\Windows\Microsoft.NET\assembly\GAC_64\Microsoft.ActiveDirectory.Management 
on a system that has the RSAT installed:

Copy file to computer and import dll directly

Located near
C:\Windows\Microsoft.NET\assembly\GAC_32\Microsoft.ActiveDirectory.Management\v4.0_10.0.0.0__31bf3856ad364e35\Microsoft.ActiveDirectory.Management.dll

Import-Module .\Microsoft.ActiveDirectory.Management.dll

This means that we can just grab the DLL from the system with RSAT and drop it on the system we want to enumerate 
from (that does not have RSAT installed) and simply import that DLL as a module:



Source - https://www.ired.team/offensive-security-experiments/active-directory-kerberos-abuse/active-directory-enumeration-with-ad-module-without-rsat-or-admin-privileges
