$ErrorActionPreference = 'Stop'

$installDir = Join-Path $env:LOCALAPPDATA 'IASType'
$stopFile = Join-Path $installDir 'IASType.stop'
$startupDir = [Environment]::GetFolderPath('Startup')
$shortcutPath = Join-Path $startupDir 'IASType.lnk'

if (Test-Path -LiteralPath $installDir -PathType Container) {
    New-Item -ItemType File -Path $stopFile -Force | Out-Null
    Start-Sleep -Milliseconds 600
}

Remove-Item -LiteralPath $shortcutPath -Force -ErrorAction SilentlyContinue
Remove-Item -LiteralPath $installDir -Recurse -Force -ErrorAction SilentlyContinue

Write-Host 'IASType was removed. AutoHotkey was left installed because other scripts may use it.' -ForegroundColor Green
