$ErrorActionPreference = 'Stop'

$sourceDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$installDir = Join-Path $env:LOCALAPPDATA 'IASType'
$scriptPath = Join-Path $installDir 'iast-windows.ahk'
$stopFile = Join-Path $installDir 'IASType.stop'
$startupDir = [Environment]::GetFolderPath('Startup')
$shortcutPath = Join-Path $startupDir 'IASType.lnk'

function Find-AutoHotkey {
    $candidates = @(
        (Join-Path $env:ProgramFiles 'AutoHotkey\v2\AutoHotkey.exe'),
        (Join-Path $env:ProgramFiles 'AutoHotkey\v2\AutoHotkey64.exe'),
        (Join-Path ${env:ProgramFiles(x86)} 'AutoHotkey\v2\AutoHotkey.exe'),
        (Join-Path ${env:ProgramFiles(x86)} 'AutoHotkey\v2\AutoHotkey32.exe'),
        (Join-Path $env:LOCALAPPDATA 'Programs\AutoHotkey\v2\AutoHotkey.exe'),
        (Join-Path $env:LOCALAPPDATA 'Programs\AutoHotkey\v2\AutoHotkey64.exe')
    )

    foreach ($candidate in $candidates) {
        if ($candidate -and (Test-Path -LiteralPath $candidate -PathType Leaf)) {
            return (Resolve-Path -LiteralPath $candidate).Path
        }
    }

    foreach ($name in @('AutoHotkey64.exe', 'AutoHotkey32.exe')) {
        $command = Get-Command $name -ErrorAction SilentlyContinue
        if ($command) {
            return $command.Source
        }
    }

    return $null
}

$autoHotkey = Find-AutoHotkey
if (-not $autoHotkey) {
    $winget = Get-Command winget.exe -ErrorAction SilentlyContinue
    if ($winget) {
        Write-Host 'AutoHotkey v2 was not found. Installing it with WinGet...'
        & $winget.Source install --id AutoHotkey.AutoHotkey --exact --upgrade --silent --accept-source-agreements --accept-package-agreements
        if ($LASTEXITCODE -ne 0) {
            throw 'WinGet could not install AutoHotkey. Install AutoHotkey v2 from https://www.autohotkey.com/download/2.0/ and run this installer again.'
        }
        $autoHotkey = Find-AutoHotkey
    }
}

if (-not $autoHotkey) {
    Start-Process 'https://www.autohotkey.com/download/2.0/'
    throw 'AutoHotkey v2 is required. Install it from the official download page, then run install-windows.cmd again.'
}

New-Item -ItemType Directory -Path $installDir -Force | Out-Null
Remove-Item -LiteralPath $stopFile -Force -ErrorAction SilentlyContinue
Copy-Item -LiteralPath (Join-Path $sourceDir 'iast-windows.ahk') -Destination $scriptPath -Force

$shell = New-Object -ComObject WScript.Shell
$shortcut = $shell.CreateShortcut($shortcutPath)
$shortcut.TargetPath = $autoHotkey
$shortcut.Arguments = '"' + $scriptPath + '"'
$shortcut.WorkingDirectory = $installDir
$shortcut.Description = 'IASType Sanskrit and ISO 15919 typing'
$shortcut.Save()

Start-Process -FilePath $autoHotkey -ArgumentList ('"' + $scriptPath + '"') -WorkingDirectory $installDir

Write-Host ''
Write-Host 'IASType is installed and running.' -ForegroundColor Green
Write-Host 'Use Alt+A, Alt+R, Alt+S, and the other mapped keys in README.md.'
Write-Host 'It will start automatically when you sign in to Windows.'
