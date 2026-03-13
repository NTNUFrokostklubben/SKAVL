$versionsFile = Join-Path $PSScriptRoot "..\service-versions.json"
$versions = Get-Content $versionsFile | ConvertFrom-Json
$version = $versions.tiler

$outputDir = Join-Path $PSScriptRoot "..\services\tiler"
if (Test-Path $outputDir) {
    Remove-Item $outputDir -Recurse -Force
}
New-Item -ItemType Directory -Path $outputDir | Out-Null

$url = "https://github.com/NTNUFrokostklubben/skavl-tiler/releases/download/$version/server-$version-windows.zip"
$zipPath = Join-Path $env:TEMP "tiler-windows.zip"

Write-Host "Downloading tiler $version..."
Invoke-WebRequest -Uri $url -OutFile $zipPath
Expand-Archive -Path $zipPath -DestinationPath $outputDir -Force
Remove-Item $zipPath

Write-Host "Done. Tiler extracted to $outputDir"