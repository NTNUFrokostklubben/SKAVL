$versionsFile = Join-Path $PSScriptRoot "..\service-versions.json"
$versions = Get-Content $versionsFile | ConvertFrom-Json
$version = $versions.tiler

$outputDir = Join-Path $PSScriptRoot "..\services\tiler"
$versionMarker = Join-Path $outputDir ".version"

# Check if service already up to date
if (Test-Path $versionMarker) {
    $installedVersion = Get-Content $versionMarker
    if ($installedVersion -eq $version) {
        Write-Host "Tiler $version already up to date."

        # Remove outdated build output directories, needed due to cmake
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
                    if ($buildVersion -ne $version) {
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

Write-Host "Downloading tiler $version..."
curl.exe -L $url -o $zipPath
Expand-Archive -Path $zipPath -DestinationPath $outputDir -Force
Remove-Item $zipPath

# Write version marker
Set-Content -Path $versionMarker -Value $version

# Remove outdated build output directories
$buildDirs = @(
    Join-Path $PSScriptRoot "..\build\windows\x64\runner\Debug\services\tiler"
    Join-Path $PSScriptRoot "..\build\windows\x64\runner\Profile\services\tiler"
    Join-Path $PSScriptRoot "..\build\windows\x64\runner\Release\services\tiler"
)
foreach ($buildDirs in $buildDirs) {
    if (Test-Path $buildDirs) {
        Write-Host "Removing outdated build output: $buildDirs"
        Remove-Item $buildDirs -Recurse -Force
    }
}

Write-Host "Done. Tiler $version ready."