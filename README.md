# Scoop Auto Update

An automated solution for keeping Scoop packages up to date on Windows systems.

## Project Overview
This tool automates the maintenance of Scoop packages by:
- Running `scoop update *` command automatically via Windows Task Scheduler
- Cleaning up old versions of packages and `scoop cleanup *`
- Managing the Scoop cache to prevent disk space wastage using `scoop cache rm *` 

## Installation

### Prerequisites
- Windows operating system
- [Scoop](https://scoop.sh/) package manager installed
- PowerShell 5.1 or later

### Quick Install
1. Clone this repository or download the files
2. Open PowerShell and navigate to the downloaded directory
3. Run the installer:
```powershell
.\Install-ScoopAutoUpdate.ps1
```

## Usage
Once installed, the script will run automatically according to the schedule. You can:

- View logs in `%USERPROFILE%\.scoop\logs`
- Manually run updates by executing `Update-Scoop.ps1`
- Check Task Scheduler for the "Scoop Auto Update" task to verify installation

## AI Assistant Prompt
To recreate this project from scratch, provide the following prompt to an AI assistant:

```
Create a Windows automation solution to keep Scoop packages updated daily. Requirements:

1. PowerShell script (Update-Scoop.ps1) that:
   - Updates Scoop itself
   - Updates all installed packages
   - Cleans old versions and cache
   - Implements logging with 7-day rotation
   - Stores logs in %USERPROFILE%\.scoop\logs
   - Handles errors gracefully

2. Task Scheduler configuration (ScoopAutoUpdate.xml) that:
   - Runs daily at 3:00 AM
   - Uses interactive token (user context)
   - Runs when user is logged in
   - Catches up on missed updates
   - Uses least privileges
   - No stored credentials

3. Simple installer script (Install-ScoopAutoUpdate.ps1) that:
   - Registers the scheduled task
   - Requires no elevation
   - Provides clear feedback

Key considerations:
- Must work with standard Scoop installation
- Should use native Scoop commands
- Must preserve user environment
- Should be maintainable and well-documented
```
