#!/bin/bash

NAME_LIST_FILENAME="names.txt"

# Path to the file containing the list of names
input_file=$NAME_LIST_FILENAME

# Check if the file exists before proceeding
if [ ! -f "$input_file" ]; then
    echo "Error: $input_file not found."
    exit 1
fi

echo "Processing names and creating sanitized directories..."

# Read the file line by line
while IFS= read -r line || [ -n "$line" ]; do
    # 1. Strip leading/trailing whitespaces and tabs
    clean_name=$(echo "$line" | xargs)

    # Skip empty lines
    if [ -z "$clean_name" ]; then
        continue
    fi

    # 2. Convert to lowercase
    clean_name=$(echo "$clean_name" | tr '[:upper:]' '[:lower:]')

    # 3. Replace all spaces (and multiple spaces) with a single hyphen
    clean_name=$(echo "$clean_name" | tr -s ' ' '-')

    # 4. Remove special characters (keeps lowercase letters, numbers, and hyphens)
    clean_name=$(echo "$clean_name" | tr -cd 'a-z0-9-')

    # 5. Clean up any trailing/leading hyphens caused by stripped characters
    clean_name=$(echo "$clean_name" | sed 's/^-//;s/-$//')

    # Double check we still have a valid name after sanitizing
    if [ -n "$clean_name" ]; then
        mkdir -p "$clean_name"
        echo "Original: '$line' -> Created: '$clean_name'"
    else
        echo "Skipped: '$line' (Name became empty after sanitization)"
    fi

done < "$input_file"

