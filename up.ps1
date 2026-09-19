<#
Starts the docker-compose stack, auto-generating a .env file with a random
SEARXNG_SECRET on first run (SearXNG uses this to override secret_key in
data/searxng/config/settings.yml, so the real secret never has to be committed).
Any arguments passed to this script are forwarded to `docker-compose up`.
#>

$repoRoot = $PSScriptRoot
$envFile = Join-Path $repoRoot ".env"

if (-not (Test-Path $envFile)) {
    $bytes = [byte[]]::new(32)
    [System.Security.Cryptography.RandomNumberGenerator]::Fill($bytes)
    $secret = -join ($bytes | ForEach-Object { $_.ToString("x2") })
    "SEARXNG_SECRET=$secret" | Set-Content -Path $envFile -NoNewline -Encoding utf8
    Write-Host "Generated new $envFile with a random SEARXNG_SECRET."
}

Push-Location $repoRoot
try {
    docker-compose up @args
}
finally {
    Pop-Location
}
