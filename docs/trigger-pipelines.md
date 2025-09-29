# How to Trigger GitHub Actions on Self-Hosted Runner

## 🎯 Your Runner is Ready!
```
Current runner version: '2.328.0'
2025-09-29 10:39:26Z: Listening for Jobs
```

## 📋 Ways to Trigger Workflows

### 1. **Push to Main Branch** (Triggers: `ci-cd.yml`)
```powershell
# From your project directory
git add .
git commit -m "feat: add new feature"
git push origin main
```

### 2. **Create Pull Request** (Triggers: `ci-pr.yml`)
```powershell
# Create a feature branch
git checkout -b feature/your-feature-name
git add .
git commit -m "feat: implement your feature"
git push origin feature/your-feature-name

# Then create PR on GitHub web interface
```

### 3. **Push to Develop Branch** (Triggers: `ci-dev.yml`)
```powershell
# Switch to develop branch (create if doesn't exist)
git checkout -b develop
git add .
git commit -m "feat: development changes"
git push origin develop
```

### 4. **Manual Trigger via GitHub Web UI**
1. Go to: https://github.com/606/rbe-shared-datatypes-datetime/actions
2. Select a workflow
3. Click "Run workflow" button
4. Choose branch and parameters

### 5. **Test Locally Before Pushing**
```powershell
# Run local simulation first
.\scripts\test-runner-local.ps1

# Or with Release configuration
.\scripts\test-runner-local.ps1 -Configuration Release
```

## 🔍 Monitor Your Runner

### Watch Runner Activity:
```powershell
# In your runner terminal, you'll see:
2025-09-29 10:39:26Z: Listening for Jobs
2025-09-29 10:40:15Z: Running job: build-and-test
2025-09-29 10:41:30Z: Job completed: build-and-test
```

### Check Runner Logs:
```powershell
# Navigate to runner directory
cd C:\github-runner

# View recent logs
Get-Content "_diag\Runner_*.log" -Tail 50

# View worker logs
Get-Content "_diag\Worker_*.log" -Tail 50
```

## 🎮 Quick Test Commands

### Trigger CI immediately:
```powershell
# Make a small change
echo "# Test change" >> README.md
git add README.md
git commit -m "test: trigger CI pipeline"
git push origin main
```

### Create test PR:
```powershell
# Create test branch
git checkout -b test/pipeline-trigger
echo "# Testing PR pipeline" >> test-file.md
git add test-file.md
git commit -m "test: PR pipeline trigger"
git push origin test/pipeline-trigger
# Create PR via GitHub web interface
```

## 📊 Expected Workflow Behavior

### On Main Branch Push:
- ✅ Uses self-hosted runner
- ✅ Full CI/CD pipeline
- ✅ Semantic versioning
- ✅ Package publishing
- ✅ Security scanning

### On Pull Request:
- ✅ Uses self-hosted + GitHub runners (matrix)
- ✅ Fast feedback loop
- ✅ Code quality checks
- ✅ Security audit

### On Develop Branch:
- ✅ Comprehensive testing
- ✅ Integration tests
- ✅ Performance tests
- ✅ Preview package creation

## 🐛 Troubleshooting

### Runner Not Picking Up Jobs:
1. **Check runner labels in GitHub**: Settings > Actions > Runners
2. **Verify workflow uses correct labels**: `runs-on: self-hosted`
3. **Check runner connectivity**: Should show "Idle" status on GitHub

### Job Stuck in Queue:
```powershell
# Restart runner
# Press Ctrl+C in runner terminal, then:
./run.cmd
```

### View Real-time Logs:
```powershell
# Open new terminal and tail logs
Get-Content "C:\github-runner\_diag\Runner_*.log" -Wait -Tail 10
```

## 🎯 Next Steps
1. **Commit your current changes** to trigger the pipeline
2. **Watch the runner terminal** for job execution
3. **Check GitHub Actions tab** for workflow progress
4. **Review logs** for any issues

Your runner is ready! Just push some changes to see it in action! 🚀