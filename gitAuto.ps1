# Stage all changes
git add .

# Prompt for commit message
$commit_message = Read-Host "Enter commit message"
if ([string]::IsNullOrWhiteSpace($commit_message)) {
    $commit_message = "Modified $(Get-Date -Format "yyyy-MM-dd HH:mm:ss")"
}

# Commit the changes
git commit -m "$commit_message"
if ($LASTEXITCODE -ne 0) {
    Write-Host "Commit failed. Exiting."
    exit 1
}

# Push the changes
git push
if ($LASTEXITCODE -ne 0) {
    Write-Host "Push failed. Exiting."
    exit 1
}

Write-Host "Changes successfully committed and pushed!"
