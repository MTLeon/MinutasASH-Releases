[CmdletBinding()]
param(
    [string]$Tag = 'v2.3.5',
    [string]$Destination = (Join-Path $env:USERPROFILE 'Downloads\MinutasASH'),
    [switch]$NoLaunch
)

$ErrorActionPreference = 'Stop'
$repository = 'MTLeon/MinutasASH-Releases'
$headers = @{ 'User-Agent' = 'MinutasASH-Installer' }
$release = Invoke-RestMethod -Headers $headers -Uri "https://api.github.com/repos/$repository/releases/tags/$Tag"
$assets = @($release.assets)
$parts = @($assets | Where-Object { $_.name -match '^MinutasASH_Setup_.+\.exe\.part\d+$' } | Sort-Object {
    [int]([regex]::Match($_.name, '\.part(\d+)$').Groups[1].Value)
})
$hashAsset = $assets | Where-Object { $_.name -match 'SHA256\.(txt|sha256)$' } | Select-Object -First 1
if ($parts.Count -eq 0 -or -not $hashAsset) { throw 'La release no contiene todas las partes o su archivo SHA-256.' }

New-Item -ItemType Directory -Force -Path $Destination | Out-Null
$hashText = (Invoke-WebRequest -Headers $headers -Uri $hashAsset.browser_download_url).Content
$expected = [regex]::Match($hashText, '\b[a-fA-F0-9]{64}\b').Value.ToLowerInvariant()
if (-not $expected) { throw 'El archivo SHA-256 publicado no es válido.' }
$installerName = ($parts[0].name -replace '\.part\d+$', '')
$installer = Join-Path $Destination $installerName
$temporary = "$installer.download"
Remove-Item -LiteralPath $temporary -ErrorAction SilentlyContinue

try {
    $stream = [System.IO.File]::Create($temporary)
    try {
        foreach ($part in $parts) {
            Write-Host "Descargando $($part.name)..."
            $response = Invoke-WebRequest -Headers $headers -Uri $part.browser_download_url
            $stream.Write($response.Content, 0, $response.Content.Length)
        }
    } finally { $stream.Dispose() }
    $actual = (Get-FileHash -LiteralPath $temporary -Algorithm SHA256).Hash.ToLowerInvariant()
    if ($actual -ne $expected) { throw 'La verificación SHA-256 falló; el instalador fue descartado.' }
    Move-Item -LiteralPath $temporary -Destination $installer -Force
} catch {
    Remove-Item -LiteralPath $temporary -ErrorAction SilentlyContinue
    throw
}

Write-Host "Instalador verificado: $installer" -ForegroundColor Green
if (-not $NoLaunch) { Start-Process -FilePath $installer }