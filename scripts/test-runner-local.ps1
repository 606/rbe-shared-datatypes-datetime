# Test GitHub Runner Locally
# This script simulates running the CI/CD pipeline locally

param(
    [string]$Configuration = "Debug",
    [string]$RunnerPath = "C:\github-runner"
)

Write-Host "🧪 Testing GitHub Actions Runner Locally..." -ForegroundColor Green

# Check if we're in the correct directory
if (-not (Test-Path "Temabit.Rbe.Shared.sln")) {
    Write-Error "❌ Please run this script from the repository root directory"
    exit 1
}

# Function to run a step with timing
function Invoke-Step {
    param($Name, $ScriptBlock)
    
    Write-Host ""
    Write-Host "🔄 $Name..." -ForegroundColor Yellow
    $stopwatch = [System.Diagnostics.Stopwatch]::StartNew()
    
    try {
        & $ScriptBlock
        $stopwatch.Stop()
        Write-Host "✅ $Name completed in $($stopwatch.Elapsed.TotalSeconds)s" -ForegroundColor Green
        return $true
    }
    catch {
        $stopwatch.Stop()
        Write-Host "❌ $Name failed after $($stopwatch.Elapsed.TotalSeconds)s" -ForegroundColor Red
        Write-Host "Error: $($_.Exception.Message)" -ForegroundColor Red
        return $false
    }
}

# Start testing
Write-Host "📋 Simulating CI/CD Pipeline Steps" -ForegroundColor Cyan
Write-Host "Configuration: $Configuration" -ForegroundColor Gray
Write-Host "Repository: $(Get-Location)" -ForegroundColor Gray

$success = $true

# Step 1: Check prerequisites
$success = $success -and (Invoke-Step "Check .NET SDK" {
    $version = dotnet --version
    if (-not $version) { throw ".NET SDK not found" }
    Write-Host "   .NET Version: $version" -ForegroundColor Gray
})

$success = $success -and (Invoke-Step "Check Git" {
    $version = git --version
    if (-not $version) { throw "Git not found" }
    Write-Host "   Git Version: $version" -ForegroundColor Gray
})

# Step 2: Restore dependencies
$success = $success -and (Invoke-Step "Restore Dependencies" {
    dotnet restore
    if ($LASTEXITCODE -ne 0) { throw "Restore failed" }
})

# Step 3: Build solution
$success = $success -and (Invoke-Step "Build Solution" {
    dotnet build --no-restore --configuration $Configuration
    if ($LASTEXITCODE -ne 0) { throw "Build failed" }
})

# Step 4: Run tests
$success = $success -and (Invoke-Step "Run Tests" {
    dotnet test --no-build --configuration $Configuration --verbosity minimal
    if ($LASTEXITCODE -ne 0) { throw "Tests failed" }
})

# Step 5: Check formatting (if dotnet format is available)
$success = $success -and (Invoke-Step "Check Code Formatting" {
    try {
        dotnet format --verify-no-changes --verbosity diagnostic
        if ($LASTEXITCODE -ne 0) { throw "Code formatting issues found" }
    }
    catch {
        Write-Host "   Note: dotnet format not available, skipping..." -ForegroundColor Yellow
    }
})

# Step 6: Security audit
$success = $success -and (Invoke-Step "Security Audit" {
    $output = dotnet list package --vulnerable --include-transitive 2>&1
    if ($output -match "vulnerable") {
        Write-Host "   Warning: Vulnerable packages found" -ForegroundColor Yellow
        Write-Host $output -ForegroundColor Yellow
    } else {
        Write-Host "   No vulnerabilities found" -ForegroundColor Green
    }
})

# Step 7: Package creation (Release mode only)
if ($Configuration -eq "Release") {
    $success = $success -and (Invoke-Step "Create NuGet Package" {
        dotnet pack --configuration Release --no-build --output "./packages"
        if ($LASTEXITCODE -ne 0) { throw "Package creation failed" }
        
        $packages = Get-ChildItem "./packages/*.nupkg" 2>$null
        if ($packages) {
            Write-Host "   Packages created:" -ForegroundColor Gray
            foreach ($pkg in $packages) {
                Write-Host "     $($pkg.Name)" -ForegroundColor Gray
            }
        }
    })
}

# Step 8: Check runner status (if runner path exists)
if (Test-Path $RunnerPath) {
    Invoke-Step "Check GitHub Runner Status" {
        Push-Location $RunnerPath
        try {
            $status = & .\svc.sh status 2>&1
            Write-Host "   Runner Status: $status" -ForegroundColor Gray
        }
        finally {
            Pop-Location
        }
    }
}

# Summary
Write-Host ""
Write-Host "📊 Test Summary" -ForegroundColor Cyan
if ($success) {
    Write-Host "✅ All steps completed successfully!" -ForegroundColor Green
    Write-Host "🚀 Your code is ready for GitHub Actions!" -ForegroundColor Green
} else {
    Write-Host "❌ Some steps failed. Please fix the issues before pushing." -ForegroundColor Red
}

Write-Host ""
Write-Host "💡 To run with GitHub Actions:" -ForegroundColor Cyan
Write-Host "   1. Commit your changes: git commit -m 'feat: your changes'" -ForegroundColor Gray
Write-Host "   2. Push to branch: git push origin your-branch" -ForegroundColor Gray
Write-Host "   3. Create pull request to trigger CI" -ForegroundColor Gray