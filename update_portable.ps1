param (
    [string]$TargetDir = "C:\Users\user\Desktop\LumiGram_Portable"
)

Write-Host "Updating LumiGram Portable at $TargetDir..."

if (-not (Test-Path $TargetDir)) {
    New-Item -ItemType Directory -Force -Path $TargetDir | Out-Null
}

$tempExtract = Join-Path $env:TEMP "LumiGram-Extract"

try {
    Write-Host "Downloading latest Windows Portable release..."
    gh release download --repo F1arLesss/LumiGram --pattern "*.zip" --dir $env:TEMP --clobber
    
    $zipFile = Get-ChildItem $env:TEMP -Filter "*LumiGram*.zip" | Sort-Object LastWriteTime -Descending | Select-Object -First 1
    if (-not $zipFile) {
        throw "Could not find downloaded LumiGram zip file."
    }

    if (Test-Path $tempExtract) { Remove-Item $tempExtract -Recurse -Force }
    New-Item -ItemType Directory -Path $tempExtract | Out-Null
    Expand-Archive -Path $zipFile.FullName -DestinationPath $tempExtract -Force

    # Copy files, explicitly excluding tdata to preserve user login sessions
    Get-ChildItem $tempExtract | Where-Object { $_.Name -ne "tdata" } | ForEach-Object {
        Copy-Item -Path $_.FullName -Destination $TargetDir -Recurse -Force
        Write-Host "Updated: $($_.Name)"
    }

    # Update language files in tdata/ayu/languages without touching any user session files
    $ruSource = Join-Path $tempExtract "tdata\ayu\languages\ru.json"
    if (Test-Path $ruSource) {
        $destLang = Join-Path $TargetDir "tdata\ayu\languages"
        New-Item -ItemType Directory -Force -Path $destLang | Out-Null
        Copy-Item $ruSource (Join-Path $destLang "ru.json") -Force
        Copy-Item $ruSource (Join-Path $destLang "ru-raw.json") -Force
        Write-Host "Updated languages in tdata without touching account session data."
    }

    Write-Host "`nLumiGram Portable successfully updated!" -ForegroundColor Green
    Write-Host "Your session and account login (tdata) were safely preserved." -ForegroundColor Cyan
} finally {
    if (Test-Path $tempExtract) { Remove-Item $tempExtract -Recurse -Force -ErrorAction SilentlyContinue }
}
