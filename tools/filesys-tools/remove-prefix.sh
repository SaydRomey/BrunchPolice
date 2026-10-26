#!/usr/bin/env bash

set -u

printf "Enter the prefix to remove (example: backup_): "
IFS= read -r prefix

if [[ -z "$prefix" ]]; then
    echo "The prefix cannot be empty."
    exit 1
fi

script_name=$(basename "$0")

# Include hidden files and safely handle spaces in filenames.
shopt -s nullglob dotglob

files=()

for path in ./*; do
    [[ -f "$path" ]] || continue

    filename=${path#./}

    # Do not process the running script.
    [[ "$filename" == "$script_name" ]] && continue

    # ONLY include files that actually start with the specified prefix
    if [[ "$filename" == "$prefix"* ]]; then
        files+=("$filename")
    fi
done

if (( ${#files[@]} == 0 )); then
    echo "No files starting with prefix '$prefix' were found in the current directory."
    exit 0
fi

# Function to calculate the new filename by removing the prefix
new_name() {
    local filename=$1
    # Strip the prefix from the beginning of the filename
    printf '%s' "${filename#$prefix}"
}

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

