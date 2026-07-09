#!/bin/bash
set -e

# Read update text from a file called update.md in this folder
if [ ! -f update.md ]; then
  echo "Error: create update.md with your text first."
  exit 1
fi

# Convert Markdown -> HTML body
BODY=$(python3 -m markdown update.md)

# Write the full page
cat > index.html <<EOF
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Latest Update</title>
  <style>
    body { font-family: system-ui, -apple-system, sans-serif; max-width: 780px;
           margin: 2rem auto; padding: 0 1.25rem; line-height: 1.65; color: #1a1a1a; }
    h1, h2, h3 { line-height: 1.25; }
    code { background: #f4f4f4; padding: 0.1em 0.3em; border-radius: 3px; }
    pre { background: #f4f4f4; padding: 1rem; overflow-x: auto; border-radius: 6px; }
    .updated { color: #666; font-size: 0.9rem; margin-bottom: 2rem; }
  </style>
</head>
<body>
  <p class="updated">Last updated: $(date "+%B %d, %Y at %I:%M %p")</p>
  $BODY
</body>
</html>
EOF

git add index.html
git commit -m "Update $(date +%Y-%m-%d)"
git push
echo "Published. Live in ~1 minute."
