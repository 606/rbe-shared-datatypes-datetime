# GitHub Runner Setup Script
# Run this as Administrator

param(
    [Parameter(Mandatory=$true)]
    [string]$Token,
    [string]$RunnerName = "windows-local-runner",
    [string]$RunnerPath = "C:\github-runner",
    [string]$RepoUrl = "https://github.com/606/rbe-shared-datatypes-datetime"
)

Write-Host "🚀 Setting up GitHub Self-Hosted Runner..." -ForegroundColor Green

# Check if running as Administrator
$currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
if (-not $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Error "❌ This script must be run as Administrator!"
    exit 1
}

# Create runner directory
Write-Host "📁 Creating runner directory: $RunnerPath" -ForegroundColor Yellow
New-Item -ItemType Directory -Path $RunnerPath -Force | Out-Null
Set-Location $RunnerPath

# Check if runner already exists
if (Test-Path ".\config.cmd") {
    Write-Host "⚠️  Runner already configured. Remove existing configuration? (y/n)" -ForegroundColor Yellow
    $response = Read-Host
    if ($response -eq 'y') {
        Write-Host "🗑️  Removing existing configuration..." -ForegroundColor Yellow
        .\config.cmd remove --token $Token
    } else {
        Write-Host "✅ Using existing configuration" -ForegroundColor Green
        exit 0
    }
}

# Download latest runner
Write-Host "⬇️  Downloading GitHub Actions Runner..." -ForegroundColor Yellow
$latestRelease = Invoke-RestMethod -Uri "https://api.github.com/repos/actions/runner/releases/latest"
$downloadUrl = $latestRelease.assets | Where-Object { $_.name -like "*win-x64*.zip" } | Select-Object -First 1 -ExpandProperty browser_download_url

if (-not $downloadUrl) {
    Write-Error "❌ Could not find Windows x64 runner download URL"
    exit 1
}

$zipFile = "actions-runner-win-x64.zip"
Invoke-WebRequest -Uri $downloadUrl -OutFile $zipFile

# Extract runner
Write-Host "📦 Extracting runner..." -ForegroundColor Yellow
Expand-Archive -Path $zipFile -DestinationPath "." -Force
Remove-Item $zipFile

# Configure runner
Write-Host "⚙️  Configuring runner..." -ForegroundColor Yellow
$configArgs = @(
    "--url", $RepoUrl,
    "--token", $Token,
    "--name", $RunnerName,
    "--work", "_work",
    "--replace"
)

& .\config.cmd @configArgs

if ($LASTEXITCODE -ne 0) {
    Write-Error "❌ Runner configuration failed!"
    exit 1
}

# Install as Windows Service
Write-Host "🔧 Installing as Windows Service..." -ForegroundColor Yellow
& .\svc.sh install

if ($LASTEXITCODE -ne 0) {
    Write-Error "❌ Service installation failed!"
    exit 1
}

# Start the service
Write-Host "▶️  Starting runner service..." -ForegroundColor Yellow
& .\svc.sh start

if ($LASTEXITCODE -ne 0) {
    Write-Error "❌ Service start failed!"
    exit 1
}

# Verify installation
Write-Host "✅ Runner setup complete!" -ForegroundColor Green
Write-Host ""
Write-Host "📊 Runner Status:" -ForegroundColor Cyan
& .\svc.sh status

Write-Host ""
Write-Host "🔗 Check your runner at: $RepoUrl/settings/actions/runners" -ForegroundColor Cyan
Write-Host ""
Write-Host "📝 Useful Commands:" -ForegroundColor Cyan
Write-Host "   Stop service:      .\svc.sh stop" -ForegroundColor Gray
Write-Host "   Start service:     .\svc.sh start" -ForegroundColor Gray
Write-Host "   Check status:      .\svc.sh status" -ForegroundColor Gray
Write-Host "   View logs:         Get-Content '_diag\Runner_*.log' -Tail 20" -ForegroundColor Gray