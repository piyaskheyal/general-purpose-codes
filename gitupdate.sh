#!/bin/bash

# Stage all changes
git add .

# Prompt for commit message
read -p "Enter commit message: " commit_message
if [ -z "$commit_message" ]; then
  commit_message="Modified $(date +"%Y-%m-%d %H:%M:%S")"
fi

# Commit the changes locally
git commit -m "$commit_message"
if [ $? -ne 0 ]; then
  echo "Commit failed. Exiting."
  exit 1
fi

echo "Changes committed locally."

# Get current branch name
branch_name=$(git symbolic-ref --short HEAD)

# Check if this branch has a remote upstream
git rev-parse --abbrev-ref --symbolic-full-name @{u} >/dev/null 2>&1

if [ $? -ne 0 ]; then
  echo "No upstream branch set for '$branch_name'."
  read -p "Do you want to push this branch and set upstream to origin/$branch_name? (y/n): " answer
  if [[ "$answer" =~ ^[Yy]$ ]]; then
    git push -u origin "$branch_name"
    if [ $? -ne 0 ]; then
      echo "Push failed. Exiting."
      exit 1
    fi
    echo "Branch pushed and upstream set to origin/$branch_name."
  else
    echo "Push skipped. Your changes are committed locally."
    exit 0
  fi
else
  # If upstream exists, just push normally
  git push
  if [ $? -ne 0 ]; then
    echo "Push failed. Exiting."
    exit 1
  fi
  echo "Changes successfully pushed to remote."
fi
