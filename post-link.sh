#!/usr/bin/env bash
set -euo pipefail

# post-link.sh - Quick link posting tool for Hugo
# Usage: ./post-link.sh <URL> [DATE]
# Example: ./post-link.sh "https://example.com" "2025-12-25"

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Check arguments
if [ $# -lt 1 ]; then
    echo -e "${RED}Error: URL required${NC}"
    echo "Usage: $0 <URL> [DATE]"
    echo "Example: $0 'https://example.com' '2025-12-25'"
    exit 1
fi

URL="$1"
DATE="${2:-$(date +%Y-%m-%d)}" # Use provided date or today

# Validate URL format
if [[ ! "$URL" =~ ^https?:// ]]; then
    echo -e "${RED}Error: Invalid URL format (must start with http:// or https://)${NC}"
    exit 1
fi

# Extract domain for link_domain field
DOMAIN=$(echo "$URL" | sed -E 's|^https?://([^/]+).*|\1|')

# Fetch page title from HTML
echo "Fetching page title..."
# Store HTML content first to avoid SIGPIPE issues with curl | grep -m1
HTML_CONTENT=$(curl -sL "$URL")
PAGE_TITLE=$(echo "$HTML_CONTENT" | grep -oPm1 '(?<=<title>)[^<]+' | sed 's/&amp;/\&/g; s/&lt;/</g; s/&gt;/>/g; s/&quot;/"/g; s/&#39;/'"'"'/g')

if [ -z "$PAGE_TITLE" ]; then
    echo -e "${RED}Error: Could not fetch page title from URL${NC}"
    exit 1
fi

echo -e "Title: ${GREEN}$PAGE_TITLE${NC}"

# Generate slug from title (lowercase, replace spaces/special chars with dashes)
SLUG=$(echo "$PAGE_TITLE" | tr '[:upper:]' '[:lower:]' | sed -E 's/[^a-z0-9]+/-/g; s/^-+|-+$//g')

# Filename format: YYYY-MM-DD-slug.md
FILENAME="${DATE}-${SLUG}.md"
FILEPATH="content/links/${FILENAME}"

# Check if file already exists
if [ -f "$FILEPATH" ]; then
    echo -e "${RED}Error: File already exists: $FILEPATH${NC}"
    exit 1
fi

# Get current time for timestamp
TIMESTAMP=$(date -d "$DATE" +"%Y-%m-%dT%H:%M:%S%:z" 2>/dev/null || date +"%Y-%m-%dT%H:%M:%S%:z")

# Create markdown file
cat > "$FILEPATH" <<EOF
---
title: "$PAGE_TITLE"
date: $TIMESTAMP
draft: false
link_url: "$URL"
link_domain: "$DOMAIN"
---
EOF

echo -e "${GREEN}✓${NC} Created: $FILEPATH"

# Git operations
git add "$FILEPATH"
git commit -m "Add link: $PAGE_TITLE"
git push

echo -e "${GREEN}✓${NC} Committed and pushed to repository"
echo -e "${GREEN}Done!${NC}"
