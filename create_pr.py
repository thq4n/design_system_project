#!/usr/bin/env python3
"""
Script to create GitHub PR
Usage: python3 create_pr.py [GITHUB_TOKEN]
"""

import json
import sys
import os
import urllib.request
import urllib.parse

REPO = "thq4n/design_system_project"
BRANCH = "features/tooltip"
BASE_BRANCH = "master"
TITLE = "feat(tooltip): add DSTooltip component with theming support"
LABELS = ["feature", "ui/ux", "enhancement", "design-system"]

def main():
    # Get token
    if len(sys.argv) > 1:
        token = sys.argv[1]
    elif os.getenv("GITHUB_TOKEN"):
        token = os.getenv("GITHUB_TOKEN")
    else:
        print("Error: GitHub token is required")
        print("Usage: python3 create_pr.py [GITHUB_TOKEN]")
        print("Or set GITHUB_TOKEN environment variable")
        sys.exit(1)
    
    # Read PR description
    try:
        with open("PR_CONTENT.md", "r", encoding="utf-8") as f:
            description = f.read()
    except FileNotFoundError:
        print("Error: PR_CONTENT.md not found")
        sys.exit(1)
    
    # Prepare request
    url = f"https://api.github.com/repos/{REPO}/pulls"
    data = {
        "title": TITLE,
        "head": BRANCH,
        "base": BASE_BRANCH,
        "body": description,
        "labels": LABELS
    }
    
    # Create request
    req = urllib.request.Request(url)
    req.add_header("Accept", "application/vnd.github.v3+json")
    req.add_header("Authorization", f"token {token}")
    req.add_header("Content-Type", "application/json")
    
    try:
        # Send request
        with urllib.request.urlopen(req, json.dumps(data).encode("utf-8")) as response:
            result = json.loads(response.read().decode("utf-8"))
            print("✅ PR created successfully!")
            print(f"🔗 PR URL: {result['html_url']}")
            print(f"📊 PR Number: #{result['number']}")
    except urllib.error.HTTPError as e:
        error_body = e.read().decode("utf-8")
        print(f"❌ Error creating PR: {e.code}")
        print(f"Response: {error_body}")
        sys.exit(1)
    except Exception as e:
        print(f"❌ Error: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main()

