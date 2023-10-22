#!/bin/sh

# providing source file
if [ $# -ne 1 ]; then
  echo "Usage: $0 <source_file>"
  exit 1
fi

source_file="$1"

# Check the source file exists
if [ ! -f "$source_file" ]; then
  echo "Source file not found: $source_file"
  exit 1
fi

# Create a temporary directory
temp_dir=$(mktemp -d)
if [ ! -d "$temp_dir" ]; then
  echo "Failed to create a temporary directory."
  # cleanup and remove the temporary directory
  rm -rf "$temp_dir"
  exit 1
fi

# Find the output file name in the "&Output:" comment
output_name=$(grep '&Output:' "$source_file" | awk '{print $2}')

if [ -z "$output_name" ]; then
  echo "No '&Output:' comment found in the source file."
  # cleanup and remove the temporary directory
  rm -rf "$temp_dir"
  exit 1
fi

# Compile source file, place output in the temporary directory. "touch" to simulate a compilation
touch "$temp_dir/$output_name"

# Move the output file to the current directory
mv "$temp_dir/$output_name" ./

# Clean up the temporary directory
rm -rf "$temp_dir"

# Build sucssesfull
echo "Build successful: &Output: $output_name"