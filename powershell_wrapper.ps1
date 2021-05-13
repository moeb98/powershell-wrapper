[CmdletBinding()]
Param (
  [parameter(Position=0, ValueFromPipeline, Mandatory=$true)]
  [String]$PowerShellScript,
  [parameter(Position=1, Mandatory=$false)]
  [String]$CmdScript
)

$input = Get-Item $PowerShellScript -ErrorAction Stop
$output = $CmdScript
if(-not $output) {
    $output = ($input.FullName) -replace '\.ps1$', '.cmd'
}
$text = Get-Content $input -Raw
$header = @'
@echo off
%windir%\System32\more +{0} "%~f0" > "%temp%\%~n0.ps1"
powershell -NoProfile -ExecutionPolicy Bypass -File "%temp%\%~n0.ps1" %*
del %temp%\%~n0.ps1
pause
exit /b

*** PowerShell ***

'@
$header = $header -f ($header.Split("`n").Length - 1)
$text = $header + $text
Set-Content -Path $output -Value $text 
