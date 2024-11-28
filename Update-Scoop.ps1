# Update-Scoop.ps1
# Script to automatically update Scoop packages and perform maintenance

# Load user environment variables
$userEnv = [System.Environment]::GetEnvironmentVariable("Path", "User")
$machineEnv = [System.Environment]::GetEnvironmentVariable("Path", "Machine")
$env:Path = "$userEnv;$machineEnv"

# Set up logging
$LogPath = "$env:USERPROFILE\.scoop\logs"
$LogFile = Join-Path $LogPath "scoop-auto-update-$(Get-Date -Format 'yyyy-MM-dd').log"

# Create log directory if it doesn't exist
if (-not (Test-Path $LogPath)) {
    New-Item -ItemType Directory -Path $LogPath | Out-Null
}

# Rotate logs - keep only last 7 days
Get-ChildItem -Path $LogPath -Filter "scoop-auto-update-*.log" | 
    Sort-Object LastWriteTime -Descending | 
    Select-Object -Skip 7 | 
    Remove-Item -Force

function Write-Log {
    param($Message)
    $TimeStamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    "$TimeStamp - $Message" | Tee-Object -FilePath $LogFile -Append
}

function Invoke-ScoopCommand {
    param($Command, $Description)
    Write-Log $Description
    
    # Run the command and capture output
    $scoopCmd = "$env:USERPROFILE\scoop\shims\scoop.cmd"
    $output = & $scoopCmd $Command.Split(" ") 2>&1 | Out-String
    if ($output.Trim()) {
        Write-Log "Output:`n$output"
    }
    
    if ($LASTEXITCODE -ne 0) {
        throw "Scoop command failed with exit code $LASTEXITCODE"
    }
}

try {
    Write-Log "Starting Scoop auto-update process"
    Write-Log "Path: $env:Path"

    # Update Scoop itself
    Invoke-ScoopCommand "update" "Updating Scoop..."
    
    # Update all installed packages
    Invoke-ScoopCommand "update *" "Updating all packages..."

    # Clean up old versions
    Invoke-ScoopCommand "cleanup *" "Cleaning up old versions..."

    # Clear cache
    Invoke-ScoopCommand "cache rm *" "Clearing cache..."

    Write-Log "Update process completed successfully"
}
catch {
    Write-Log "Error occurred during update process: $_"
    exit 1
}
