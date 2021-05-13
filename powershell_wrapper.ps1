[CmdletBinding()]
Param (
  [parameter(Position=0, ValueFromPipeline, Mandatory=$true)]
  [String]$PowerShellScript,
  [parameter(Position=1, Mandatory=$false)]
  [String]$CmdScript
)

$inputPowerShell = Get-Item $PowerShellScript -ErrorAction Stop
$outputCmd = $CmdScript
if(-not $outputCmd) {
    $outputCmd = ($inputPowerShell.FullName) -replace '\.ps1$', '.cmd'
}
$text = Get-Content $inputPowerShell -Raw
$header = @'
@echo off
%windir%\System32\more +{0} "%~f0" > "%temp%\%~n0.ps1"
powershell -NoProfile -ExecutionPolicy Bypass -File "%temp%\%~n0.ps1" %*
del %temp%\%~n0.ps1
pause
exit /b

*** wrapped PowerShell ***

'@
$header = $header -f ($header.Split("`n").Length - 1)
$text = $header + $text
Set-Content -Path $outputCmd -Value $text 
