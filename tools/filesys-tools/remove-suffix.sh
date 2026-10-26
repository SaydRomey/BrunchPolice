#!/usr/bin/env bash

set -u

printf "Enter the suffix to remove (example: _backup): "
IFS= read -r suffix

if [[ -z "$suffix" ]]; then
    echo "The suffix cannot be empty."
    exit 1
fi

script_name=$(basename "$0")

# Include hidden files and safely handle spaces in filenames.
shopt -s nullglob dotglob

files=()

# Return the filename with the suffix removed from the same position where
# append_suffix.sh adds it: immediately before the final extension, or at the
# end for extensionless files and simple dotfiles.
new_name() {
    local filename=$1
    local base extension

    # Preserve dotfiles without extensions, such as ".gitignore".
    if [[ "$filename" == .* && "$filename" != *.*.* ]]; then
        [[ "$filename" == *"$suffix" ]] || return 1
        printf '%s' "${filename:0:${#filename}-${#suffix}}"
    elif [[ "$filename" == *.* ]]; then
        base=${filename%.*}
        extension=${filename##*.}
        [[ "$base" == *"$suffix" ]] || return 1
        printf '%s.%s' "${base:0:${#base}-${#suffix}}" "$extension"
    else
        [[ "$filename" == *"$suffix" ]] || return 1
        printf '%s' "${filename:0:${#filename}-${#suffix}}"
    fi
}

for path in ./*; do
    [[ -f "$path" ]] || continue

    filename=${path#./}

    # Do not process the running script.
    [[ "$filename" == "$script_name" ]] && continue

    # Only include files whose suffix is in the position this script removes.
    if new_name "$filename" >/dev/null; then
        files+=("$filename")
    fi
done

if (( ${#files[@]} == 0 )); then
    echo "No files ending with suffix '$suffix' were found in the expected filename position."
    exit 0
fi

echo
echo "Planned filename changes:"
printf '%-40s -> %s\n' "CURRENT NAME" "NEW NAME"
printf '%-40s    %s\n' "------------" "--------"

for filename in "${files[@]}"; do
    printf '%-40s -> %s\n' "$filename" "$(new_name "$filename")"
done

echo
echo "Choose an operation:"
echo "  1) Rename the original files"
echo "  2) Copy the files with new names into a subfolder"
echo "  3) Cancel"
printf "Selection [1-3]: "
IFS= read -r operation

case "$operation" in
    1)
        destination="."
        action="rename"
        ;;
    2)
        printf "Enter the subfolder name [renamed_files]: "
        IFS= read -r destination
        destination=${destination:-renamed_files}

        if [[ -e "$destination" && ! -d "$destination" ]]; then
            echo "Error: '$destination' exists and is not a directory."
            exit 1
        fi

        action="copy"
        ;;
    3)
        echo "Cancelled."
        exit 0
        ;;
    *)
        echo "Invalid selection."
        exit 1
        ;;
esac

# Check for filename conflicts before changing anything.
conflicts=0

for filename in "${files[@]}"; do
    renamed=$(new_name "$filename")

    if [[ "$action" == "rename" ]]; then
        target="./$renamed"
    else
        target="$destination/$renamed"
    fi

    if [[ -e "$target" ]]; then
        echo "Conflict: '$target' already exists."
        conflicts=1
    fi
done

if (( conflicts )); then
    echo "No files were changed because filename conflicts were found."
    exit 1
fi

echo
printf "Proceed with the %s operation? [y/N]: " "$action"
IFS= read -r confirmation

if [[ ! "$confirmation" =~ ^[Yy]$ ]]; then
    echo "Cancelled."
    exit 0
fi

if [[ "$action" == "copy" ]]; then
    mkdir -p -- "$destination"
fi

for filename in "${files[@]}"; do
    renamed=$(new_name "$filename")

    if [[ "$action" == "rename" ]]; then
        mv -- "./$filename" "./$renamed"
        printf "Renamed: %s -> %s\n" "$filename" "$renamed"
    else
        cp -p -- "./$filename" "$destination/$renamed"
        printf "Copied:  %s -> %s/%s\n" "$filename" "$destination" "$renamed"
    fi
done

echo "Done."
