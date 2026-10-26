#!/bin/bash

# -----------------------------------------------------------------------------
# Script: sanitize_filenames.sh
#
# Description:
#   Renames files in a specified directory so filenames become:
#     - lowercase
#     - ASCII-only
#     - space/dash/underscore normalized to hyphens
#     - cleaned of emojis and other non-ASCII characters
#
# Notes:
#   - Preserves file extensions
#   - Does NOT recurse into subdirectories
#   - Uses python3 for robust Unicode handling
#
# Optional flags:
#   --dry-run      Show what would be renamed without changing files
#   --show-changes Print each rename operation
# -----------------------------------------------------------------------------

DRY_RUN=false
SHOW_CHANGES=false

for arg in "$@"; do
    case "$arg" in
        --dry-run)
            DRY_RUN=true
            ;;
        --show-changes)
            SHOW_CHANGES=true
            ;;
        *)
            echo "Unknown option: $arg"
            echo "Usage: $0 [--dry-run] [--show-changes]"
            exit 1
            ;;
    esac
done

if ! command -v python3 &> /dev/null; then
    echo "python3 is required but not installed."
    exit 1
fi

read -p "Enter directory to process [default: current]: " DIR
DIR=${DIR:-.}

if [ ! -d "$DIR" ]; then
    echo "Directory does not exist: $DIR"
    exit 1
fi

shopt -s nullglob
FILES=("$DIR"/*)
shopt -u nullglob

if [ "${#FILES[@]}" -eq 0 ]; then
    echo "No files found in $DIR"
    exit 0
fi

RENAME_OLD=()
RENAME_NEW=()

sanitize_name() {
    python3 - "$1" <<'PY'
import os
import re
import sys
import unicodedata

name = sys.argv[1]

base, ext = os.path.splitext(name)

# Normalize Unicode (helps separate accented letters, etc.)
base = unicodedata.normalize("NFKD", base)

# Drop non-ASCII entirely (removes emoji and other non-ASCII chars)
base = base.encode("ascii", "ignore").decode("ascii")

# Lowercase
base = base.lower()

# Replace spaces, underscores, and runs of hyphen-like chars with a single hyphen
base = re.sub(r"[\s_]+", "-", base)
base = re.sub(r"-+", "-", base)

# Remove anything not a-z, 0-9, dot, or hyphen
base = re.sub(r"[^a-z0-9\-]", "", base)

# Collapse hyphens again after cleanup
base = re.sub(r"-+", "-", base)

# Trim leading/trailing hyphens or dots
base = base.strip("-.")

# Fallback if basename becomes empty
if not base:
    base = "file"

# Normalize extension to lowercase ASCII-ish style
ext = unicodedata.normalize("NFKD", ext).encode("ascii", "ignore").decode("ascii").lower()

print(base + ext)
PY
}

for path in "${FILES[@]}"; do
    [ -f "$path" ] || continue

    old_name="$(basename "$path")"
    dir_name="$(dirname "$path")"
    new_name="$(sanitize_name "$old_name")"

    # Skip if unchanged
    if [ "$old_name" = "$new_name" ]; then
        continue
    fi

    target="$dir_name/$new_name"

    # Avoid collisions by appending -1, -2, etc.
    if [ -e "$target" ]; then
        base="${new_name%.*}"
        ext=""
        if [[ "$new_name" == *.* ]]; then
            ext=".${new_name##*.}"
            base="${new_name%.*}"
        fi

        n=1
        while [ -e "$dir_name/${base}-$n$ext" ]; do
            ((n++))
        done
        new_name="${base}-$n$ext"
        target="$dir_name/$new_name"
    fi

    RENAME_OLD+=("$path")
    RENAME_NEW+=("$target")
done

if [ "${#RENAME_OLD[@]}" -eq 0 ]; then
    echo "No files need renaming in $DIR"
    exit 0
fi

echo "Planned renames:"
for i in "${!RENAME_OLD[@]}"; do
    echo "  $(basename "${RENAME_OLD[$i]}")"
    echo "    -> $(basename "${RENAME_NEW[$i]}")"
done

if [ "$DRY_RUN" = true ]; then
    echo
    echo "Dry run only. No files were renamed."
    exit 0
fi

read -p "Do you want to rename these files? (y/n): " CONFIRM
if [[ ! "$CONFIRM" =~ ^[Yy]$ ]]; then
    echo "Operation cancelled."
    exit 0
fi

RENAMED=0
for i in "${!RENAME_OLD[@]}"; do
    mv -- "${RENAME_OLD[$i]}" "${RENAME_NEW[$i]}"
    ((RENAMED++))
    if [ "$SHOW_CHANGES" = true ]; then
        echo "Renamed: $(basename "${RENAME_OLD[$i]}") -> $(basename "${RENAME_NEW[$i]}")"
    fi
done

echo
echo "Renamed $RENAMED file(s)."
