$versionsFile = Join-Path $PSScriptRoot "..\service-versions.json"
$versions = Get-Content $versionsFile | ConvertFrom-Json
$version = $versions.tiler
$marker = "$version-windows"

$outputDir = Join-Path $PSScriptRoot "..\services\tiler"
$versionMarker = Join-Path $outputDir ".version"

# Check if already up to date
if (Test-Path $versionMarker) {
    $installedMarker = Get-Content $versionMarker
    if ($installedMarker -eq $marker) {
        Write-Host "Tiler $version (windows) already up to date."

        $buildDirs = @(
            Join-Path $PSScriptRoot "..\build\windows\x64\runner\Debug\services\tiler"
            Join-Path $PSScriptRoot "..\build\windows\x64\runner\Profile\services\tiler"
            Join-Path $PSScriptRoot "..\build\windows\x64\runner\Release\services\tiler"
        )
        foreach ($buildDir in $buildDirs) {
            if (Test-Path $buildDir) {
                $buildMarker = Join-Path $buildDir ".version"
                if (Test-Path $buildMarker) {
                    $buildVersion = Get-Content $buildMarker
                    if ($buildVersion -ne $marker) {
                        Write-Host "Removing outdated build output: $buildDir"
                        Remove-Item $buildDir -Recurse -Force
                    }
                }
            }
        }
        exit 0
    }
}

# Remove existing and re-download
if (Test-Path $outputDir) {
    Remove-Item $outputDir -Recurse -Force
}
New-Item -ItemType Directory -Path $outputDir | Out-Null

$url = "https://github.com/NTNUFrokostklubben/skavl-tiler/releases/download/$version/server-$version-windows.zip"
$zipPath = Join-Path $env:TEMP "tiler-windows.zip"

Write-Host "Downloading tiler $version (windows)..."
curl.exe -L $url -o $zipPath
Expand-Archive -Path $zipPath -DestinationPath $outputDir -Force
Remove-Item $zipPath

Set-Content -Path $versionMarker -Value $marker

# Used to delete old tiler version already moved on build
$buildDirs = @(
    Join-Path $PSScriptRoot "..\build\windows\x64\runner\Debug\services\tiler"
    Join-Path $PSScriptRoot "..\build\windows\x64\runner\Profile\services\tiler"
    Join-Path $PSScriptRoot "..\build\windows\x64\runner\Release\services\tiler"
)
foreach ($buildDir in $buildDirs) {
    if (Test-Path $buildDir) {
        Write-Host "Removing outdated build output: $buildDir"
        Remove-Item $buildDir -Recurse -Force
    }
}

Write-Host "Done. Tiler $version (windows) ready."