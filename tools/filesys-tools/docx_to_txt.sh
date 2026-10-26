#!/bin/bash

# -----------------------------------------------------------------------------
# Script: docx_to_txt.sh
#
# Description:
#   Converts all .docx files in a specified directory (default: current directory)
#   to .txt format. Supports the following tools, in this order of preference:
#     - pandoc
#     - docx2txt
#     - libreoffice (headless mode)
#
#   Features:
#     - Prompts user for directory (defaults to current)
#     - Lists .docx files and asks for confirmation before converting
#     - Converts each file to .txt using the best available tool
#     - Displays a summary of original and newly created files
#     - Handles missing tools with a helpful message
#
# Optional flags:
#   --show-tool    Print the converter selected by the script
# 
# Notes:
#   - Formatting, images, tables, headers/footers, and tracked changes may not
#     survive cleanly in plain text output.
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
if command -v pandoc &> /dev/null; then
    CONVERT_CMD="pandoc"
elif command -v docx2txt &> /dev/null; then
    CONVERT_CMD="docx2txt"
elif command -v libreoffice &> /dev/null; then
    CONVERT_CMD="libreoffice"
else
    echo "No suitable .docx to .txt conversion tool found."
    echo "Please install one of the following:"
    echo "  sudo apt install pandoc"
    echo "  or"
    echo "  sudo apt install docx2txt"
    echo "  or"
    echo "  sudo apt install libreoffice"
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

# Find .docx files
shopt -s nullglob
DOCX_FILES=("$DIR"/*.docx)
shopt -u nullglob

# Check if any .docx files exist
if [ "${#DOCX_FILES[@]}" -eq 0 ]; then
    echo "No .docx files found in $DIR"
    exit 0
fi

# List files and confirm
echo "Found the following .docx files:"
for f in "${DOCX_FILES[@]}"; do
    echo "  $(basename "$f")"
done

read -p "Do you want to convert these files to .txt? (y/n): " CONFIRM
if [[ ! "$CONFIRM" =~ ^[Yy]$ ]]; then
    echo "Operation cancelled."
    exit 0
fi

# Convert files
TXT_FILES=()
for file in "${DOCX_FILES[@]}"; do
    txt_file="${file%.docx}.txt"

    if [[ "$CONVERT_CMD" == "pandoc" ]]; then
        pandoc "$file" -t plain -o "$txt_file"

    elif [[ "$CONVERT_CMD" == "docx2txt" ]]; then
        docx2txt "$file" - > "$txt_file"

    elif [[ "$CONVERT_CMD" == "libreoffice" ]]; then
        outdir="$(dirname "$file")"
        libreoffice --headless --convert-to txt:Text --outdir "$outdir" "$file" > /dev/null 2>&1
    fi

    if [ -f "$txt_file" ]; then
        TXT_FILES+=("$txt_file")
    else
        echo "Failed to convert: $(basename "$file")"
    fi
done

# Output results
echo
echo "Original .docx files:"
for f in "${DOCX_FILES[@]}"; do
    echo "  $(basename "$f")"
done

echo
echo "New .txt files:"
for f in "${TXT_FILES[@]}"; do
    echo "  $(basename "$f")"
done
