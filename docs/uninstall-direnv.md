# Uninstall direnv from Windows

## Method 1: Check Installation Method

### If installed via Chocolatey:
```powershell
# Check if installed via Chocolatey
choco list --local-only | findstr direnv

# If found, uninstall:
choco uninstall direnv
```

### If installed via Scoop:
```powershell
# Check if installed via Scoop
scoop list | findstr direnv

# If found, uninstall:
scoop uninstall direnv
```

### If installed via winget:
```powershell
# Check if installed via winget
winget list | findstr direnv

# If found, uninstall:
winget uninstall direnv
```

## Method 2: Manual Removal

### Find direnv installation:
```powershell
# Search for direnv executable
where.exe direnv
Get-Command direnv -ErrorAction SilentlyContinue

# Check common locations
Test-Path "C:\Program Files\direnv\direnv.exe"
Test-Path "C:\Users\$env:USERNAME\AppData\Local\direnv\direnv.exe"
Test-Path "C:\tools\direnv\direnv.exe"
```

### Remove from PATH:
```powershell
# Check current PATH for direnv
$env:PATH -split ';' | Where-Object { $_ -like '*direnv*' }

# Remove from User PATH (run as regular user)
$userPath = [Environment]::GetEnvironmentVariable("PATH", [System.EnvironmentVariableTarget]::User)
$newUserPath = ($userPath -split ';' | Where-Object { $_ -notlike '*direnv*' }) -join ';'
[Environment]::SetEnvironmentVariable("PATH", $newUserPath, [System.EnvironmentVariableTarget]::User)

# Remove from System PATH (run as Administrator)
$systemPath = [Environment]::GetEnvironmentVariable("PATH", [System.EnvironmentVariableTarget]::Machine)
$newSystemPath = ($systemPath -split ';' | Where-Object { $_ -notlike '*direnv*' }) -join ';'
[Environment]::SetEnvironmentVariable("PATH", $newSystemPath, [System.EnvironmentVariableTarget]::Machine)
```

### Remove PowerShell Profile Modifications:
```powershell
# Check PowerShell profiles for direnv
Get-Content $PROFILE -ErrorAction SilentlyContinue | Select-String "direnv"
Get-Content $PROFILE.AllUsersAllHosts -ErrorAction SilentlyContinue | Select-String "direnv"

# Edit profiles to remove direnv lines
notepad $PROFILE
```

## Method 3: Registry Cleanup (if needed)
```powershell
# Check registry for direnv entries (run as Administrator)
Get-ChildItem "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall" | 
    Get-ItemProperty | 
    Where-Object { $_.DisplayName -like "*direnv*" }
```

## Verification
```powershell
# Restart PowerShell and verify removal
Get-Command direnv -ErrorAction SilentlyContinue
# Should return nothing if successfully removed

# Check PATH is clean
$env:PATH -split ';' | Where-Object { $_ -like '*direnv*' }
# Should return nothing if successfully removed
```