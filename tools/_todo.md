<div align="right">

[Return to previous README][readme-path]

[readme-path]: ./README.md "Tools Info"

</div>

> **I currently do not need this since i use unique names, but for the sake of general usage...**

# `resize_sprites.sh` Improvements

[Resize Pixel-art Sprite Files][resize-sprites]

[resize-sprites]: ./resize_sprites.sh "Pixel-art Safe Conversion Script"

---

## TODO: Duplicate Basename Resolution

> [!WARNING]
> Add a duplicate-basename resolution step 
> after file discovery and before the resize target menu.

This prevents output collisions when 
more than one source file has the same basename.

Example collision:

```text
enemy_slime.jpeg
enemy_slime.png
```

Both files would currently output to:

```text
resized/128x128/enemy_slime.png
```

The script should detect this and ask the user which source file to process.

---

## 1. Add Helper Functions

Add these helper functions before `find_source_files()` or before `main()`:

```bash
get_base_name() {
  local file="$1"
  local filename

  filename="$(basename "$file")"

  # Remove only the final extension.
  # enemy_slime.jpeg -> enemy_slime
  # enemy_slime.png  -> enemy_slime
  echo "${filename%.*}"
}

array_contains() {
  local needle="$1"
  shift

  local item
  for item in "$@"; do
    if [[ "$item" == "$needle" ]]; then
      return 0
    fi
  done

  return 1
}

resolve_duplicate_basenames() {
  local resolved_files=()
  local seen_bases=()
  local duplicate_groups=0

  local src_file
  for src_file in "${files[@]}"; do
    local base_name
    base_name="$(get_base_name "$src_file")"

    # Skip this basename if we already handled it.
    if array_contains "$base_name" "${seen_bases[@]}"; then
      continue
    fi

    seen_bases+=("$base_name")

    # Build a group of all files with this same basename.
    local group=()
    local candidate

    for candidate in "${files[@]}"; do
      local candidate_base_name
      candidate_base_name="$(get_base_name "$candidate")"

      if [[ "$candidate_base_name" == "$base_name" ]]; then
        group+=("$candidate")
      fi
    done

    # No collision. Keep the file.
    if (( ${#group[@]} == 1 )); then
      resolved_files+=("${group[0]}")
      continue
    fi

    ((duplicate_groups++))

    echo
    echo "Duplicate basename found: $base_name"
    echo "These files would overwrite each other after PNG conversion:"

    local i=1
    for candidate in "${group[@]}"; do
      echo "  $i) $candidate"
      ((i++))
    done

    echo "  s) skip this basename"
    echo

    local choice
    while true; do
      read -r -p "Choose which file to process for '$base_name' [1]: " choice
      choice="${choice:-1}"

      if [[ "$choice" == "s" || "$choice" == "S" || "$choice" == "skip" ]]; then
        echo "Skipped basename: $base_name"
        break
      fi

      if [[ "$choice" =~ ^[0-9]+$ ]] && (( choice >= 1 && choice <= ${#group[@]} )); then
        resolved_files+=("${group[$((choice - 1))]}")
        echo "Selected: ${group[$((choice - 1))]}"
        break
      fi

      echo "Invalid choice. Enter a number from 1 to ${#group[@]}, or 's' to skip."
    done
  done

  files=("${resolved_files[@]}")

  if (( duplicate_groups > 0 )); then
    echo
    echo "Duplicate basename groups resolved: $duplicate_groups"
    echo "Files selected for processing:       ${#files[@]}"
  fi

  if (( ${#files[@]} == 0 )); then
    echo
    echo "No files selected for processing."
    exit 0
  fi
}
```

---

## 2. Replace `find_source_files()`

Replace the current `find_source_files()` function with this version:

```bash
find_source_files() {
  shopt -s nullglob

  # Valid source files.
  # Add more extensions here later if needed.
  files=(
    "$SRC_DIR"/*.jpeg
    "$SRC_DIR"/*.jpg
    "$SRC_DIR"/*.png
    "$SRC_DIR"/*.JPEG
    "$SRC_DIR"/*.JPG
    "$SRC_DIR"/*.PNG
  )

  if (( ${#files[@]} == 0 )); then
    echo
    echo "No valid sprite files found in: $SRC_DIR"
    echo "Expected: *.jpeg, *.jpg, or *.png"
    exit 0
  fi

  echo
  echo "Candidate sprite files found: ${#files[@]}"

  resolve_duplicate_basenames

  echo "Valid sprite files selected: ${#files[@]}"
}
```

---

## 3. Expected Flow

```text
Source directory [current directory]: ./enemies

Candidate sprite files found: 108

Duplicate basename found: enemy_slime
These files would overwrite each other after PNG conversion:
  1) /path/enemies/enemy_slime.jpeg
  2) /path/enemies/enemy_slime.png
  s) skip this basename

Choose which file to process for 'enemy_slime' [1]:
Selected: /path/enemies/enemy_slime.jpeg

Duplicate basename groups resolved: 1
Files selected for processing:       107
Valid sprite files selected: 107

Available resize targets:
  1) 128x128
  2) 64x64
  a) all
```

---

## 4. Keep Existing Output Path Logic

Keep the existing `get_output_path()` function unchanged.

This approach prevents overwrites by ensuring 
only one source file per basename reaches the resize loop.
