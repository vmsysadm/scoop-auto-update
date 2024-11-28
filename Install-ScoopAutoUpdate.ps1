# Install-ScoopAutoUpdate.ps1
# Script to install and configure Scoop Auto Update

# Configuration
$ProjectDir = "$env:USERPROFILE\CascadeProjects\projects\scoop-auto-update"
$TaskName = "Scoop Auto Update"

# Register the scheduled task
$TaskPath = Join-Path $ProjectDir "ScoopAutoUpdate.xml"
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
