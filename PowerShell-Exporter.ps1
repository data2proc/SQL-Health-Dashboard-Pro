<# 
    SQL Health Dashboard Pro - PowerShell Exporter with Email
    Author: data2proc
#>

# -----------------------------
# CONFIGURATION
# -----------------------------
$serverName = "localhost"                # SQL Server instance
$databaseName = "master"                 # Database to connect to
$outputFolder = ".\report-output"        # Output folder
$sqlScriptPath = ".\health_dashboard.sql" # SQL file path
$zipPath = ".\SQLHealthReport.zip"       # ZIP file path

# Email settings
$smtpServer = "smtp.yourmail.com"        # Replace with your SMTP server
$smtpPort = 587                          # Usually 587 for TLS
$from = "you@example.com"
$to = "recipient@example.com"
$subject = "SQL Health Dashboard Report"
$body = "Attached is the latest SQL Health Report"
$cred = Get-Credential                   # Will prompt for email credentials

# -----------------------------
# Ensure output folder exists
# -----------------------------
if (!(Test-Path $outputFolder)) {
    New-Item -ItemType Directory -Path $outputFolder | Out-Null
}

# -----------------------------
# Load and split SQL script
# -----------------------------
$sqlQueries = Get-Content $sqlScriptPath -Raw
$queries = ($sqlQueries -split '(?ms)^--\s*Query:\s*(.+?)\s*$') -ne ""

for ($i = 1; $i -lt $queries.Length; $i += 2) {
    $label = $queries[$i].Trim()
    $query = $queries[$i + 1].Trim()

    Write-Host "Running query: $label"
    $csvPath = Join-Path $outputFolder "$label.csv"

    Invoke-Sqlcmd -ServerInstance $serverName -Database $databaseName `
        -Query $query -ErrorAction Stop | Export-Csv -NoTypeInformation -Path $csvPath
}

# -----------------------------
# ZIP the output folder
# -----------------------------
if (Test-Path $zipPath) {
    Remove-Item $zipPath -Force
}
Compress-Archive -Path "$outputFolder\*" -DestinationPath $zipPath

# -----------------------------
# Send Email with attachment
# -----------------------------
Send-MailMessage -From $from -To $to -Subject $subject -Body $body `
    -SmtpServer $smtpServer -Port $smtpPort -UseSsl `
    -Credential $cred -Attachments $zipPath

Write-Host "`n✅ Export, ZIP, and Email complete." -ForegroundColor Green
