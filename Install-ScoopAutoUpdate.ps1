# Install-ScoopAutoUpdate.ps1
# Script to install and configure Scoop Auto Update

# Get the script's directory path dynamically
$ScriptPath = $PSScriptRoot
if (!$ScriptPath) {
    $ScriptPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
}

# Configuration
$TaskName = "Scoop Auto Update"

# Register the scheduled task
$TaskPath = Join-Path $ScriptPath "ScoopAutoUpdate.xml"
if (Test-Path $TaskPath) {
    Write-Host "Registering scheduled task..." -ForegroundColor Green
    Register-ScheduledTask -TaskName $TaskName -Xml (Get-Content $TaskPath | Out-String) -Force
    Write-Host "Task registered successfully!" -ForegroundColor Green
} else {
    Write-Host "Task XML file not found!" -ForegroundColor Red
    exit 1
}

Write-Host "Installation completed successfully!" -ForegroundColor Green
Write-Host "Scoop will automatically update daily at 3:00 AM" -ForegroundColor Yellow
