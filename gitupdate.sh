#!/bin/bash

# Stage all changes
git add .

# Prompt for commit message (optional)
read -p "Enter commit message: " commit_message
if [ -z "$commit_message" ]; then
  commit_message="Modified $(date +"%Y-%m-%d %H:%M:%S")"
fi

# Commit the changes
git commit -m "$commit_message"
if [ $? -ne 0 ]; then
  echo "Commit failed. Exiting."
  exit 1
fi

# Push the changes
git push
if [ $? -ne 0 ]; then
  echo "Push failed. Exiting."
  exit 1
fi

echo "Changes successfully committed and pushed!"
