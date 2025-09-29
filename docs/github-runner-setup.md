# GitHub Self-Hosted Runner Setup Guide

## Prerequisites
- Windows PowerShell (Admin rights)
- .NET 8.0 SDK installed
- Git installed
- GitHub repository access

## Step 1: Download GitHub Runner
1. Go to your repository: https://github.com/606/rbe-shared-datatypes-datetime
2. Navigate to **Settings** > **Actions** > **Runners**
3. Click **New self-hosted runner**
4. Select **Windows** as OS
5. Copy the download and configuration commands

## Step 2: Setup Runner Directory
```powershell
# Create runner directory
New-Item -ItemType Directory -Path "C:\github-runner" -Force
Set-Location "C:\github-runner"

# Download the runner (replace with latest version URL from GitHub)
Invoke-WebRequest -Uri "https://github.com/actions/runner/releases/download/v2.311.0/actions-runner-win-x64-2.311.0.zip" -OutFile "actions-runner-win-x64.zip"

# Extract the runner
Expand-Archive -Path "actions-runner-win-x64.zip" -DestinationPath "." -Force
Remove-Item "actions-runner-win-x64.zip"
```

## Step 3: Configure Runner
```powershell
# Configure the runner (replace TOKEN with your actual token from GitHub)
.\config.cmd --url https://github.com/606/rbe-shared-datatypes-datetime --token YOUR_TOKEN_HERE

# When prompted:
# - Runner group: Default
# - Runner name: windows-local-runner (or any name you prefer)
# - Work folder: _work (default)
# - Run as service: Y (recommended)
```

## Step 4: Install as Windows Service
```powershell
# Install as Windows service (run as Administrator)
.\svc.sh install

# Start the service
.\svc.sh start

# Check service status
.\svc.sh status
```

## Step 5: Alternative - Run Interactively
```powershell
# If you prefer to run interactively instead of as service
.\run.cmd
```

## Verification Commands
```powershell
# Check if runner is connected
# Go to GitHub repo > Settings > Actions > Runners
# You should see your runner listed as "Idle"

# Test .NET installation
dotnet --version

# Test Git installation
git --version

# Check runner logs (if running as service)
Get-Content "C:\github-runner\_diag\Runner_*.log" -Tail 20
```

## Troubleshooting

### Common Issues:
1. **Permission Errors**: Run PowerShell as Administrator
2. **Token Expired**: Generate new token from GitHub
3. **Firewall**: Ensure GitHub domains are accessible
4. **Service Won't Start**: Check Windows Event Viewer

### Useful Commands:
```powershell
# Stop service
.\svc.sh stop

# Uninstall service
.\svc.sh uninstall

# Remove runner configuration
.\config.cmd remove --token YOUR_TOKEN_HERE

# View runner configuration
Get-Content ".runner"
```

## Runner Labels
Your runner will automatically get these labels:
- `self-hosted`
- `Windows`
- `X64`

You can add custom labels during configuration.

## Security Notes
- Runner has access to your repository secrets
- Ensure the machine is secure and up-to-date
- Consider running in an isolated environment for production use
- Regularly update the runner software

## Running Workflows
Once configured, workflows using `runs-on: self-hosted` will automatically use your local runner.