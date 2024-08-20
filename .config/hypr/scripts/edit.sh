#!/bin/bash

# Function to validate a file
function valid_file() {
  if [[ -f "$1" ]]; then
    return 0
  else
    return 1
  fi
}

# Function to validate a directory
function valid_dir() {
  if [[ -d "$1" ]]; then
    return 0
  else
    return 1
  fi
}

# Function to get the directory of a file
function get_dir() {
  dirname "$1"
}

# Get the pasted content from the clipboard
clipboard_content=$(wl-paste)

# Check if the pasted content is a valid file
if valid_file "$clipboard_content"; then
  # Open the file in nvim with the working directory set
  foot --working-directory="$(get_dir "$clipboard_content")" sh -c "nvim "$clipboard_content"; bash"
elif valid_dir "$clipboard_content"; then
  # Set the working directory without opening a file
  foot --working-directory="$clipboard_content"
fi

