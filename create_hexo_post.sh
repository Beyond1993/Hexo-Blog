#!/bin/bash

# Check if a name is provided
if [ -z "$1" ]; then
  echo "Usage: ./create_hexo_post.sh <post-name>"
  exit 1
fi

# Extract the post name
post_name="$1"

# Replace hyphens with underscores in the post path
post_path=$(echo "$post_name" | sed -E 's/-/_/g')

# Capitalize every word in the post path and prepend 'LeetCode/'
post_path="LeetCode/$(echo "$post_path" | awk -F'_' '{for(i=1;i<=NF;i++) $i=toupper(substr($i,1,1)) tolower(substr($i,2));}1' OFS='_')"

# Replace underscores with spaces in the post name and capitalize each word
formatted_post_name=$(echo "$post_name" | sed 's/-/ /g' | sed 's/_/ /g' | awk '{for(i=1;i<=NF;i++) $i=toupper(substr($i,1,1)) tolower(substr($i,2));}1')

# Create the post using hexo new with the formatted name and path
hexo new "$formatted_post_name" --path "$post_path"

# Confirm the creation of the post
echo "New Hexo post '$formatted_post_name' created in the path '$post_path'."

