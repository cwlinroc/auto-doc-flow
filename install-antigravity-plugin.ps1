# install-antigravity-plugin.ps1
# Build and install the adf-plugin for the Google Antigravity agent on Windows.

$ErrorActionPreference = "Stop"

$ScriptDir = Split-Path -Parent -Path $MyInvocation.MyCommand.Path
$DistDir = Join-Path $ScriptDir "src\antigravity\dist"
$TargetDir = "$env:USERPROFILE\.gemini\config\plugins\adf-plugin"

Write-Host "Building Antigravity plugin ..." -ForegroundColor Cyan

Push-Location $ScriptDir
try {
    & bash "src/antigravity/build.sh"
    if ($LASTEXITCODE -ne 0) { throw "build.sh exited with code $LASTEXITCODE" }
} finally {
    Pop-Location
}

Write-Host "`nInstalling to $TargetDir ..." -ForegroundColor Cyan

if (Test-Path $TargetDir) {
    Remove-Item -Recurse -Force $TargetDir
}
$null = New-Item -ItemType Directory -Force -Path $TargetDir

Copy-Item -Path (Join-Path $DistDir "*") -Destination $TargetDir -Recurse -Force

Write-Host "`nDone. ADF plugin successfully installed in Antigravity." -ForegroundColor Cyan
Write-Host "Please restart or reload Antigravity to activate the plugin." -ForegroundColor Gray
