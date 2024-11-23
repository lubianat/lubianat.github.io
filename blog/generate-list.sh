#!/bin/bash

output="list.json"
echo "[" > $output
first=true

# Loop through all HTML files except index.html
for file in *.html; do
  if [[ "$file" == "index.html" ]]; then
    continue
  fi

  # Extract date from filename (assumes YYYY-MM-DD-title.html format)
  date=$(echo "$file" | cut -d'-' -f1-3)

  # Extract title from the <title> tag
  title=$(grep -oP '(?<=<title>).*?(?=</title>)' "$file")

  # Extract tags from a <meta name="tags"> tag (optional)
  tags=$(grep -oP '(?<=<meta name="tags" content=").*?(?=")' "$file" || echo "")

  # Add comma for JSON if not the first entry
  if [ "$first" = true ]; then
    first=false
  else
    echo "," >> $output
  fi

  # Write to JSON
  echo "  { \"title\": \"$title\", \"url\": \"$file\", \"date\": \"$date\", \"tags\": \"$tags\" }" >> $output
done

echo "]" >> $output
