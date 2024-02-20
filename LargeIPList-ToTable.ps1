<#
Created by Tom R. 20240220

This script will take a large list of IPs and sort it in to tables.
Useful for "Instances" reporting, for findings, etc.

Currently 28 rows by 5 columns.  If you want to change this, change lines "$table_count for calculations
and row and column values below.

#>

# Path to the text file containing IP addresses
$inputFile = "C:\path\to\ip_addresses.txt"
 
# Path to the output file
$outputFile = "C:\path\to\output.txt"
 
# Read the list of IP addresses from the input file
$ipAddresses = Get-Content $inputFile
 
# Calculate the number of tables needed
$tableCount = [math]::Ceiling($ipAddresses.Count / 140)
 
# Initialize a counter for IP addresses
$ipCounter = 0
 
# Loop through each table
for ($i = 1; $i -le $tableCount; $i++) {
    # Create a table header
    $tableHeader = "Table $i`n`n"
 
    # Initialize an empty table
    $table = @()
 
    # Loop through each row in the table
    for ($row = 1; $row -le 28; $row++) {
        # Initialize an empty row
        $tableRow = @()
 
        # Add IP addresses to the row
        for ($col = 1; $col -le 5; $col++) {
            # Check if there are more IP addresses
            if ($ipCounter -lt $ipAddresses.Count) {
                $tableRow += $ipAddresses[$ipCounter]
                $ipCounter++
            }
        }
 
        # Add the row to the table
        $table += $tableRow -join " | "
    }
 
    # Output the table to the output file
    $tableHeader | Out-File -FilePath $outputFile -Append
    $table | Out-File -FilePath $outputFile -Append
}
