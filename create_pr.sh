#!/bin/bash

# Script to create PR via GitHub API
# Usage: ./create_pr.sh [GITHUB_TOKEN]
# If token is not provided, will try to use GITHUB_TOKEN from environment

REPO="thq4n/design_system_project"
BRANCH="features/tooltip"
BASE_BRANCH="master"
TITLE="feat(tooltip): add DSTooltip component with theming support"

# Get token from argument or environment
if [ -z "$1" ]; then
    if [ -z "$GITHUB_TOKEN" ]; then
        echo "Error: GitHub token is required"
        echo "Usage: $0 [GITHUB_TOKEN]"
        echo "Or set GITHUB_TOKEN environment variable"
        exit 1
    fi
    TOKEN="$GITHUB_TOKEN"
else
    TOKEN="$1"
fi

# Read PR description from PR_CONTENT.md
DESCRIPTION=$(cat PR_CONTENT.md)

# Create PR using GitHub API
curl -X POST \
  -H "Accept: application/vnd.github.v3+json" \
  -H "Authorization: token $TOKEN" \
  https://api.github.com/repos/$REPO/pulls \
  -d "{
    \"title\": \"$TITLE\",
    \"head\": \"$BRANCH\",
    \"base\": \"$BASE_BRANCH\",
    \"body\": $(echo "$DESCRIPTION" | jq -Rs .),
    \"labels\": [\"feature\", \"ui/ux\", \"enhancement\", \"design-system\"]
  }"

echo ""
echo "PR created successfully!"

