<#
    Script Name: FindEOLWindows.ps1

    Description:
    This script identifies all Windows operating systems that have reached their End-of-Life (EOL) status 
    within an Active Directory environment. It outputs the results in a console table and saves them to a CSV file.

    Next Scheduled Update:
    - Update the $EOL_OS array with upcoming EOL dates for new Windows versions.

    Upcoming EOL Dates:
    - Windows 10 (Enterprise, Education, Pro, Home): October 14, 2025
    - Windows Server 2016: January 12, 2027
    - Windows Server 2019: January 9, 2029
    - Windows Server 2022: October 14, 2031

    Recommended Update Schedule:
    - Annually review and update this script to ensure accuracy.
    - Also update if Microsoft announces EOL changes or if new versions reach EOL.
#>

# Define EOL OS patterns
$EOL_OS = @(
    "Windows Server 2003*",
    "Windows Server 2008*",
    "Windows Server 2012*",
    "Windows 7*",
    "Windows 8*",
    "Windows 8.1*"
)

# Build the filter dynamically
$Filter = ($EOL_OS | ForEach-Object { "(OperatingSystem -like '$_')" }) -join " -or "

# Run the search with the combined filter
$Results = Get-ADComputer -Filter $Filter -Property Name, OperatingSystem, OperatingSystemVersion |
    Select-Object Name, OperatingSystem, OperatingSystemVersion

# Output to Table
$Results | Format-Table -AutoSize

# Save to CSV
$Results | Export-Csv -Path ".\EOL_Windows_OS.csv" -NoTypeInformation
