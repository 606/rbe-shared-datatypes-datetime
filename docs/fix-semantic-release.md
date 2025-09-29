# Fix Semantic Release Permissions

This document explains how to fix the semantic release permission issues.

## ✅ What I've Fixed:

### 1. **Added Workflow Permissions**
```yaml
permissions:
  contents: write      # Required to push tags and releases
  issues: write        # Required to create/update issues
  pull-requests: write # Required for PR operations
  packages: write      # Required for package publishing
  actions: read        # Required to read workflow info
  security-events: write # Required for security scanning
```

### 2. **Updated Semantic Release Job**
- Changed to use **GitHub runners** (more reliable for permissions)
- Added proper Git configuration
- Updated to use latest semantic-release versions
- Simplified the release configuration

### 3. **Fixed Repository Settings**
You may also need to check these repository settings:

#### GitHub Repository Settings:
1. Go to: https://github.com/606/rbe-shared-datatypes-datetime/settings
2. Navigate to **Actions > General**
3. Under **Workflow permissions**, select:
   - ✅ **"Read and write permissions"**
   - ✅ **"Allow GitHub Actions to create and approve pull requests"**

#### Branch Protection (if enabled):
1. Go to **Settings > Branches**
2. If you have branch protection on `main`:
   - ✅ Allow force pushes for administrators
   - ✅ Include administrators in restrictions (temporarily)
   - Or add `semantic-release-bot` as an exception

## 🔧 Alternative: Personal Access Token Method

If the above doesn't work, create a Personal Access Token:

### Step 1: Create PAT
1. Go to GitHub Settings > Developer settings > Personal access tokens > Tokens (classic)
2. Generate new token with these scopes:
   - `repo` (Full control of private repositories)
   - `write:packages` (Upload packages to GitHub Package Registry)

### Step 2: Add to Repository Secrets
1. Go to repository Settings > Secrets and variables > Actions
2. Add new secret:
   - Name: `SEMANTIC_RELEASE_TOKEN`
   - Value: Your PAT

### Step 3: Update Workflow
Replace `GITHUB_TOKEN` with `SEMANTIC_RELEASE_TOKEN` in the workflow:
```yaml
env:
  GITHUB_TOKEN: ${{ secrets.SEMANTIC_RELEASE_TOKEN }}
```

## 🚀 Test the Fix

After making these changes:

1. **Commit and push** the updated workflow
2. **Check the Actions tab** for the new workflow run
3. **Monitor the semantic-versioning job** for success

## 📝 Expected Behavior

With these fixes, semantic-release should:
- ✅ Create version tags
- ✅ Generate CHANGELOG.md
- ✅ Create GitHub releases
- ✅ Trigger NuGet package publishing

## 🆘 If Still Failing

Check the workflow logs for specific error messages and ensure:
- Repository permissions are correctly set
- No branch protection is blocking the push
- The commit message follows conventional format (feat:, fix:, etc.)