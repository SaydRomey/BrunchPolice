#!/bin/bash

# -----------------------------------------------------------------------------
# Script: sanitize_filenames.sh
#
# Description:
#   Renames files in a specified directory so filenames become:
#     - lowercase
#     - ASCII-only
#     - normalized with hyphens between words
#     - stripped of emoji / other non-ASCII chars
#
# Examples:
#   "🧬 Hello___World!!.pdf"
#   -> "hello-world.pdf"
# 
#   "--Strange Name-- .doc"
#    -> "strange-name.doc"
#
# Requirements:
#   bash, iconv, sed, tr
#
# Optional flags:
#   --dry-run       Show what would change without renaming
#   --show-changes  Print each rename as it happens
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

for cmd in iconv sed tr; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
        echo "Required command not found: $cmd"
        exit 1
    fi
done

read -p "Enter directory to process [default: current]: " DIR
DIR=${DIR:-.}

if [ ! -d "$DIR" ]; then
    echo "Directory does not exist: $DIR"
    exit 1
fi

sanitize_name() {
    local name="$1"
    local base ext sanitized

    if [[ "$name" == *.* && "$name" != .* ]]; then
        base="${name%.*}"
        ext=".${name##*.}"
    else
        base="$name"
        ext=""
    fi

    # Normalize common Unicode dash characters to ASCII hyphen before stripping
    # Then transliterate to ASCII where possible, ignoring what cannot be converted
    sanitized=$(
        printf '%s' "$base" |
        sed 's/[‐-‒–—−]/-/g' |
        iconv -f UTF-8 -t ASCII//TRANSLIT 2>/dev/null |
        tr '[:upper:]' '[:lower:]' |
        sed 's/[[:space:]_]/-/g' |
        sed 's/[^a-z0-9-]//g' |
        sed 's/-\{2,\}/-/g; s/^-//; s/-$//'
    )

    # Fallback if name becomes empty
    if [ -z "$sanitized" ]; then
        sanitized="file"
    fi

    # Lowercase extension too
    ext=$(printf '%s' "$ext" | tr '[:upper:]' '[:lower:]')

    printf '%s%s\n' "$sanitized" "$ext"
}

shopt -s nullglob
FILES=("$DIR"/*)
shopt -u nullglob

if [ "${#FILES[@]}" -eq 0 ]; then
    echo "No files found in $DIR"
    exit 0
fi

OLD_FILES=()
NEW_FILES=()

for path in "${FILES[@]}"; do
    [ -f "$path" ] || continue

    old_name="$(basename "$path")"
    dir_name="$(dirname "$path")"
    new_name="$(sanitize_name "$old_name")"

    if [ "$old_name" = "$new_name" ]; then
        continue
    fi

    target="$dir_name/$new_name"

    # Avoid collisions: append -1, -2, ...
    if [ -e "$target" ]; then
        if [[ "$new_name" == *.* && "$new_name" != .* ]]; then
            new_base="${new_name%.*}"
            new_ext=".${new_name##*.}"
        else
            new_base="$new_name"
            new_ext=""
        fi

        n=1
        while [ -e "$dir_name/${new_base}-$n$new_ext" ]; do
            ((n++))
        done
        target="$dir_name/${new_base}-$n$new_ext"
    fi

    OLD_FILES+=("$path")
    NEW_FILES+=("$target")
done

if [ "${#OLD_FILES[@]}" -eq 0 ]; then
    echo "No files need renaming in $DIR"
    exit 0
fi

echo "Planned renames:"
for i in "${!OLD_FILES[@]}"; do
    echo "  $(basename "${OLD_FILES[$i]}")"
    echo "    -> $(basename "${NEW_FILES[$i]}")"
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
for i in "${!OLD_FILES[@]}"; do
    mv -- "${OLD_FILES[$i]}" "${NEW_FILES[$i]}"
    ((RENAMED++))
    if [ "$SHOW_CHANGES" = true ]; then
        echo "Renamed: $(basename "${OLD_FILES[$i]}") -> $(basename "${NEW_FILES[$i]}")"
    fi
done

echo
echo "Renamed $RENAMED file(s)."

# 'iconv -t ASCII//TRANSLIT' tries to convert accented Latin characters:
#   Björk ->  Bjork
#   café  ->  cafe
# 
# The 'sed' step converts Unicode dash variants like '–' and '—' into normal '-'
#  before ASCII cleanup.
# 