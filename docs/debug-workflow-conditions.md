# Debug Workflow Conditions

This document explains why jobs might be skipped and how to troubleshoot.

## 🔍 Why "Package and Publish NuGet" Was Skipped

### Original Problematic Conditions:
```yaml
# Semantic Versioning Job
if: github.ref == 'refs/heads/main' && github.event_name == 'push'

# Package and Publish Job  
if: github.ref == 'refs/heads/main' && needs.semantic-versioning.outputs.released == 'true'
```

### Issues:
1. **Semantic versioning was too restrictive** - only ran on direct pushes, not merges
2. **Package publishing required semantic release output** - but semantic release was skipped
3. **Merge commits have different event context** - may not trigger properly

## ✅ Fixed Conditions:

### Semantic Versioning:
```yaml
if: github.ref == 'refs/heads/main' && (github.event_name == 'push' || github.event_name == 'workflow_dispatch')
```

### Package Publishing:
```yaml
if: always() && github.ref == 'refs/heads/main' && needs.build-and-test.result == 'success' && needs.semantic-versioning.result == 'success'
```

## 🚀 How to Trigger Package Publishing

### Method 1: Direct Push
```bash
# Make a change and push directly
git add .
git commit -m "feat: add new feature"
git push origin main
```

### Method 2: Manual Workflow Dispatch
1. Go to: https://github.com/606/rbe-shared-datatypes-datetime/actions
2. Select "CI/CD Pipeline" 
3. Click "Run workflow"
4. Choose branch: `main`
5. Optionally check "Force create a release"

### Method 3: Create a Release
```bash
# Push code first, then create release via GitHub UI
# Or use GitHub CLI:
gh release create v1.0.1 --title "Release v1.0.1" --notes "Release notes here"
```

## 📋 Troubleshooting Checklist

### If Semantic Versioning Skips:
- ✅ Check you're on `main` branch
- ✅ Verify it's a `push` event (not PR)
- ✅ Ensure previous jobs succeeded
- ✅ Check commit follows conventional format (feat:, fix:, etc.)

### If Package Publishing Skips:
- ✅ Semantic versioning must complete successfully  
- ✅ Build and test must pass
- ✅ Must be on `main` branch
- ✅ Check semantic release actually created a release

### If No Release is Created:
- ✅ Commit message must follow conventional commits (feat:, fix:, BREAKING CHANGE:)
- ✅ Previous commit was already released (no new changes)
- ✅ Check semantic-release configuration in .releaserc.json

## 🎯 Debug Commands

### Check Workflow Context:
```bash
# View recent workflow runs
gh run list --limit 5

# View specific run details  
gh run view [RUN_ID]

# View job logs
gh run view [RUN_ID] --log
```

### Check Git History:
```bash
# Check recent commits and their format
git log --oneline -10

# Check if commits follow conventional format
git log --grep="^feat:" --grep="^fix:" --grep="^chore:" --oneline -10
```

### Manual Package Creation:
```bash
# Create package manually for testing
dotnet pack --configuration Release --output ./packages
```

## ⚡ Quick Fix for Next Run

Since semantic versioning was skipped this time, you can:

1. **Make a small change** with conventional commit:
   ```bash
   echo "# Quick fix" >> README.md
   git add README.md  
   git commit -m "docs: update README with workflow info"
   git push origin main
   ```

2. **Or trigger manually** via GitHub Actions UI with the workflow_dispatch trigger

The updated conditions should now work properly! 🎉