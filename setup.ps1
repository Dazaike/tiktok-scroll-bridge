$ErrorActionPreference = "Stop"
$sourceRoot = Join-Path $PSScriptRoot "src"
$runtimeRoot = Join-Path $PSScriptRoot "runtime"
$extensionRoot = Join-Path $runtimeRoot "extension"
New-Item -ItemType Directory -Force -Path $extensionRoot | Out-Null

$rng = [System.Security.Cryptography.RandomNumberGenerator]::Create()
$bytes = New-Object byte[] 32
$rng.GetBytes($bytes)
$rng.Dispose()
$token = -join ($bytes | ForEach-Object { $_.ToString("x2") })
$encoding = [System.Text.UTF8Encoding]::new($false)

function Expand-Template([string]$source, [string]$destination) {
    $text = [System.IO.File]::ReadAllText((Join-Path $sourceRoot $source))
    if (-not $text.Contains("__BRIDGE_TOKEN__")) {
        throw "Missing token placeholder in $source"
    }
    $text = $text.Replace("__BRIDGE_TOKEN__", $token)
    [System.IO.File]::WriteAllText((Join-Path $runtimeRoot $destination), $text, $encoding)
}

Expand-Template "tiktok_numpad.ahk.in" "tiktok_numpad.ahk"
Expand-Template "tiktok_scroll_server.js.in" "tiktok_scroll_server.js"
Expand-Template "extension\background.js.in" "extension\background.js"
Copy-Item (Join-Path $sourceRoot "extension\manifest.json") (Join-Path $extensionRoot "manifest.json") -Force
Write-Host "Runtime files created in $runtimeRoot"
Write-Host "Load runtime\extension as an unpacked extension, then run runtime\tiktok_numpad.ahk."
