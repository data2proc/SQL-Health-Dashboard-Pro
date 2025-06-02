<# 
    SQL Health Dashboard Pro - PowerShell Exporter
    Author: data2proc
    Description: Executes the health_dashboard.sql and exports result sets to CSV
#>

# -----------------------------
# CONFIGURATION
# -----------------------------
$serverName = "localhost"           # Change to your SQL Server name or IP
$databaseName = "master"            # A safe database to connect to
$outputFolder = ".\report-output"  # Folder to store CSVs
$sqlScriptPath = ".\health_dashboard.sql"  # Path to your SQL script

# -----------------------------
# Ensure output directory exists
# -----------------------------
if (!(Test-Path -Path $outputFolder)) {
    New-Item -ItemType Directory -Path $outputFolder | Out-Null
}

# -----------------------------
# Load SQL script content
# -----------------------------
$sqlQueries = Get-Content $sqlScriptPath -Raw

# -----------------------------
# Split script into batches by comments (optional)
# Each query must end with a comment like: -- Query: BackupStatus
# -----------------------------
$queries = ($sqlQueries -split '(?ms)^--\s*Query:\s*(.+?)\s*$') -ne ""

# -----------------------------
# Loop through each query section
# -----------------------------
for ($i = 1; $i -lt $queries.Length; $i += 2) {
    $label = $queries[$i].Trim()
    $query = $queries[$i + 1].Trim()

    Write-Host "Running query: $label"

    $csvPath = Join-Path $outputFolder "$label.csv"

    Invoke-Sqlcmd -ServerInstance $serverName -Database $databaseName `
        -Query $query -ErrorAction Stop | Export-Csv -NoTypeInformation -Path $csvPath
}

Write-Host "`n✅ Export complete. Check $outputFolder for results." -ForegroundColor Green
