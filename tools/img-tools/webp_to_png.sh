#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# Script: webp_to_png.sh
#
# Description:
#   Converts all .webp files in a specified directory (default: current directory)
#   to .png format. Supports the following tools, in this order of preference:
#     - magick (ImageMagick v7+)
#     - convert (ImageMagick v6)
#     - ffmpeg
#
#   Features:
#     - Prompts user for directory (defaults to current)
#     - Lists .webp files and asks for confirmation before converting
#     - Converts each file to .png using the best available tool
#     - Displays a summary of original and newly created files
#     - Handles missing tools with a helpful message
#
# Optional flags:
#   --show-tool    Print the converter selected by the script
# 
# -----------------------------------------------------------------------------

SHOW_TOOL=false

# Parse optional flags
for arg in "$@"; do
    case "$arg" in
        --show-tool)
            SHOW_TOOL=true
            ;;
        *)
            echo "Unknown option: $arg"
            echo "Usage: $0 [--show-tool]"
            exit 1
            ;;
    esac
done

# Determine available conversion tool
if command -v magick &> /dev/null; then
    CONVERT_CMD="magick"
elif command -v convert &> /dev/null; then
    CONVERT_CMD="convert"
elif command -v ffmpeg &> /dev/null; then
    CONVERT_CMD="ffmpeg"
else
    echo "No suitable image conversion tool found."
    echo "Please install one of the following:"
    echo "  sudo apt install imagemagick"
    echo "  or"
    echo "  sudo apt install ffmpeg"
    exit 1
fi

# Optionally show selected converter
if [ "$SHOW_TOOL" = true ]; then
    echo "Using converter: $CONVERT_CMD"
fi

# Ask user for directory (default to current)
read -p "Enter directory to process [default: current]: " DIR
DIR=${DIR:-.}

# Verify directory exists
if [ ! -d "$DIR" ]; then
	echo "Directory does not exist: $DIR"
	exit 1
fi

# Find .webp files
shopt -s nullglob
WEBP_FILES=("$DIR"/*.webp)
shopt -u nullglob

# Check if any .webp files exist
if [ "${#WEBP_FILES[@]}" -eq 0 ]; then
	echo "No .webp files found in $DIR"
	exit 0
fi

# List files and confirm
echo "Found the following .webp files:"
for f in "${WEBP_FILES[@]}"; do
	echo "  $(basename "$f")"
done

read -p "Do you want to convert these files to .png? (y/n): " CONFIRM
if [[ ! "$CONFIRM" =~ ^[Yy]$ ]]; then
	echo "Operation cancelled."
	exit 0
fi

# Convert files
PNG_FILES=()
for file in "${WEBP_FILES[@]}"; do
    png_file="${file%.webp}.png"
    if [[ "$CONVERT_CMD" == "ffmpeg" ]]; then
        ffmpeg -loglevel error -y -i "$file" "$png_file"
    else
        $CONVERT_CMD "$file" "$png_file"
    fi
    PNG_FILES+=("$png_file")
done

# Output results
echo
echo "Original .webp files:"
for f in "${WEBP_FILES[@]}"; do
	echo "  $(basename "$f")"
done

echo
echo "New .png files:"
for f in "${PNG_FILES[@]}"; do
	echo "  $(basename "$f")"
done

# -----------------------------------------------------------------------------
# Explanation of Key Commands and Flags
#
# shopt -s nullglob
#    Enables the nullglob shell option.
#    Prevents globs like *.webp from returning a literal string when no files match.
#    Without this, WEBP_FILES might contain '*.webp' as a literal, causing errors.
#
# command -v <tool>
#    Checks if a command exists in the system’s $PATH.
#    Used to detect if magick, convert, or ffmpeg is available.
#
# read -p
#    Prompts the user for input on the command line.
#    Example: read -p "Enter something: " VAR stores the response in VAR.
#
# ${VAR:-default}
#    Bash parameter expansion.
#    If VAR is unset or empty, use "default" instead.
#    Used to default to '.' (current directory) when user input is empty.
#
# ${file%.webp}.png
#    Removes the .webp suffix from the filename and replaces it with .png.
#
# ffmpeg -loglevel error -y -i input output
#    -loglevel error: suppresses warnings and info output.
#    -y: automatically overwrite output file if it exists.
#
# ${#ARRAY[@]}
#    Returns the number of elements in an array — used to check if it's empty.
# -----------------------------------------------------------------------------
