#!/bin/sh

cleanup() {
  echo "Cleaning up..."
  # Clean up the temp directory
  rm -rf "$temp_dir"
  exit 1
}

# Register the cleanup function for signals
trap cleanup EXIT INT TERM

# Check if a source file is provided
if [ $# -ne 1 ]; then
  echo "Usage: $0 <source_file>"
  exit 1
fi

source_file="$1"

# Check if the source file exists
if [ ! -f "$source_file" ]; then
  echo "Source file not found: $source_file"
  exit 1
fi

# Create a temp directory
temp_dir=$(mktemp -d)
if [ ! -d "$temp_dir" ]; then
  echo "Failed to create a temp directory."
  cleanup
fi

# Find the output file name in the "&Output:" comment
output_name=$(grep '&Output:' "$source_file" | awk '{print $2}')

if [ -z "$output_name" ]; then
  echo "No '&Output:' comment found in the source file."
  cleanup
fi

# Compile the source file, place output in the tempdir.
# "g++ -o" to compile the C++ file
g++ -o "$temp_dir/$output_name" "$source_file"

# Move the output file 
mv "$temp_dir/$output_name" "./$output_name"

# Clean up the temporary directory
rm -rf "$temp_dir"

# Build successful
echo "Build successful: &Output: $output_name"
