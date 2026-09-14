param([string]$DatabaseUser = 'postgres', [string]$Server = 'localhost', [int]$Port = 5432)
$ErrorActionPreference = 'Stop'
$psqlPath = 'C:\Program Files\PostgreSQL\18\bin\psql.exe'
if (-not (Test-Path -LiteralPath $psqlPath)) { throw 'PostgreSQL 18 psql was not found. Update psqlPath in setup.ps1.' }
Push-Location $PSScriptRoot
try {
    & $psqlPath -X -h $Server -p $Port -U $DatabaseUser -d postgres -W -f 'sql/setup.psql'
    if ($LASTEXITCODE -ne 0) { throw 'Setup stopped. Read the database error above before retrying.' }
    Write-Host 'Database loaded and SQL checks passed. Next: docs/POWER_BI_GUIDE.md'
} finally { Pop-Location }
