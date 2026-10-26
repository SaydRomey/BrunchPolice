#!/usr/bin/env bash
# File: sprite_file_utils.sh
#
# Utility script for batch-moving and batch-renaming generated sprite PNG files.
#
# Features:
#   - Flatten nested PNG files into a target directory.
#   - Rename batches by removing redundant filename fragments.
#   - Normalize broken animation frame filenames.
#   - Dry-run by default.
#   - Collision-safe: skips moves/renames when the destination already exists
#     or when multiple source files would map to the same output path.
#
# Requirements:
#   Bash 4+
#
# Usage:
#   chmod +x sprite_file_utils.sh
#
#   Preview flattening nested files:
#     ./sprite_file_utils.sh flatten
#
#   Actually move nested files:
#     ./sprite_file_utils.sh flatten --apply
#
#   Preview removing a redundant filename fragment:
#     ./sprite_file_utils.sh remove-substring \
#       --glob 'bacon_strip_*_bacon_strip_unknown.png' \
#       --remove '_bacon_strip_unknown'
#
#   Actually rename:
#     ./sprite_file_utils.sh remove-substring \
#       --glob 'bacon_strip_*_bacon_strip_unknown.png' \
#       --remove '_bacon_strip_unknown' \
#       --apply
#
#   Preview normalizing animation frame filenames:
#     ./sprite_file_utils.sh normalize-frame \
#       --glob 'bacon_strip_bacon_strip_animations_*_frame_*.png_frame_*.png' \
#       --prefix 'bacon_strip_animation'
#
#   Actually normalize:
#     ./sprite_file_utils.sh normalize-frame \
#       --glob 'bacon_strip_bacon_strip_animations_*_frame_*.png_frame_*.png' \
#       --prefix 'bacon_strip_animation' \
#       --apply
#
#   Run the known cleanup rules from this script:
#     ./sprite_file_utils.sh normalize-known
#     ./sprite_file_utils.sh normalize-known --apply

set -euo pipefail
IFS=$'\n\t'

APPLY=false

DEFAULT_ROOT_DIR="objects"
DEFAULT_DEST_DIR="."

DEFAULT_PATTERNS=(
  "objects/*/*/rotations/*.png"
  "objects/*/*/animations/*/*/*.png"
)

die() {
  echo "Error: $*" >&2
  exit 1
}

usage() {
  cat <<'EOF'
Usage:
  sprite_file_utils.sh <command> [options]

Commands:
  flatten
      Move nested PNG files into a target directory with flattened names.

  remove-substring
      Rename matching files by removing a fixed substring from the filename.

  normalize-frame
      Rename broken animation frame filenames into a clean frame sequence.

  normalize-known
      Run the known cleanup rules currently defined in this script.

Global safety:
  All commands are dry-run by default.
  Add --apply to actually move or rename files.

Examples:
  ./sprite_file_utils.sh flatten
  ./sprite_file_utils.sh flatten --apply

  ./sprite_file_utils.sh flatten \
    --pattern 'objects/*/*/rotations/*.png' \
    --pattern 'objects/*/*/animations/*/*/*.png' \
    --dest '.'

  ./sprite_file_utils.sh remove-substring \
    --glob 'bacon_strip_*_bacon_strip_unknown.png' \
    --remove '_bacon_strip_unknown'

  ./sprite_file_utils.sh normalize-frame \
    --glob 'flying_sausage_link_2_*_frame_*.png_frame_*.png' \
    --prefix 'flying_sausage_link_2'

EOF
}

set_apply_option() {
  case "$1" in
    --apply)
      APPLY=true
      ;;
    --dry-run)
      APPLY=false
      ;;
    *)
      return 1
      ;;
  esac
}

print_mode() {
  if [[ "$APPLY" == true ]]; then
    echo "Mode: APPLY"
  else
    echo "Mode: DRY RUN"
    echo "No files will be changed. Re-run with --apply to perform changes."
  fi
  echo
}

expand_glob() {
  local pattern="$1"

  # compgen expands a glob pattern stored in a variable.
  # The `|| true` prevents set -e from exiting when there are no matches.
  compgen -G "$pattern" | sort || true
}

collect_files_from_patterns() {
  local patterns=("$@")
  local pattern
  local file
  local matches=()

  declare -A seen=()

  for pattern in "${patterns[@]}"; do
    mapfile -t matches < <(expand_glob "$pattern")

    for file in "${matches[@]}"; do
      [[ -f "$file" ]] || continue

      if [[ -z "${seen[$file]+x}" ]]; then
        seen["$file"]=1
        printf '%s\n' "$file"
      fi
    done
  done
}

safe_move() {
  local src="$1"
  local dest="$2"

  if [[ "$src" == "$dest" ]]; then
    echo "SKIP same path: $src"
    return 0
  fi

  if [[ -e "$dest" ]]; then
    echo "SKIP destination exists:"
    echo "  Source:      $src"
    echo "  Destination: $dest"
    return 0
  fi

  if [[ "$APPLY" == true ]]; then
    mkdir -p "$(dirname "$dest")"
    mv -- "$src" "$dest"
    echo "MOVED:"
    echo "  Source:      $src"
    echo "  Destination: $dest"
  else
    printf 'DRY-RUN: mv -- %q %q\n' "$src" "$dest"
  fi
}

flatten_name_from_path() {
  local src="$1"
  local root_dir="$2"

  local rel="$src"
  root_dir="${root_dir%/}"

  if [[ "$rel" == "$root_dir/"* ]]; then
    rel="${rel#"$root_dir"/}"
  fi

  rel="${rel#./}"

  # Replace nested path separators with underscores.
  # Example:
  #   objects/foo/bar/rotations/frame.png
  # becomes:
  #   foo_bar_rotations_frame.png
  printf '%s\n' "${rel//\//_}"
}

flatten_command() {
  local root_dir="$DEFAULT_ROOT_DIR"
  local dest_dir="$DEFAULT_DEST_DIR"
  local patterns=()
  local user_pattern=""

  while (( $# > 0 )); do
    case "$1" in
      --apply|--dry-run)
        set_apply_option "$1"
        ;;
      --root)
        shift
        [[ $# -gt 0 ]] || die "--root requires a value"
        root_dir="$1"
        ;;
      --dest)
        shift
        [[ $# -gt 0 ]] || die "--dest requires a value"
        dest_dir="$1"
        ;;
      --pattern)
        shift
        [[ $# -gt 0 ]] || die "--pattern requires a value"
        patterns+=("$1")
        ;;
      -h|--help)
        usage
        exit 0
        ;;
      *)
        die "Unknown flatten option: $1"
        ;;
    esac
    shift
  done

  if (( ${#patterns[@]} == 0 )); then
    echo "Default source patterns:"
    local p
    for p in "${DEFAULT_PATTERNS[@]}"; do
      echo "  $p"
    done
    echo
    read -r -p "Source files pattern [use defaults]: " user_pattern

    if [[ -n "$user_pattern" ]]; then
      patterns=("$user_pattern")
    else
      patterns=("${DEFAULT_PATTERNS[@]}")
    fi
  fi

  print_mode

  local files=()
  mapfile -t files < <(collect_files_from_patterns "${patterns[@]}")

  if (( ${#files[@]} == 0 )); then
    echo "No files matched."
    return 0
  fi

  echo "Matched files: ${#files[@]}"
  echo "Root dir:      $root_dir"
  echo "Destination:   $dest_dir"
  echo

  declare -A planned_destinations=()

  local src
  local name
  local dest

  for src in "${files[@]}"; do
    name="$(flatten_name_from_path "$src" "$root_dir")"
    dest="$dest_dir/$name"

    if [[ -n "${planned_destinations[$dest]+x}" ]]; then
      echo "SKIP collision:"
      echo "  Existing source: ${planned_destinations[$dest]}"
      echo "  New source:      $src"
      echo "  Destination:     $dest"
      echo
      continue
    fi

    planned_destinations["$dest"]="$src"
    safe_move "$src" "$dest"
  done
}

remove_substring_batch() {
  local pattern="$1"
  local remove_text="$2"

  local files=()
  mapfile -t files < <(collect_files_from_patterns "$pattern")

  if (( ${#files[@]} == 0 )); then
    echo "No files matched: $pattern"
    return 0
  fi

  echo "Matched files: ${#files[@]}"
  echo "Remove text:   $remove_text"
  echo

  declare -A planned_destinations=()

  local src
  local dir
  local base
  local new_base
  local dest

  for src in "${files[@]}"; do
    dir="$(dirname "$src")"
    base="$(basename "$src")"
    new_base="${base/$remove_text/}"

    if [[ "$new_base" == "$base" ]]; then
      echo "SKIP no change: $src"
      continue
    fi

    dest="$dir/$new_base"

    if [[ -n "${planned_destinations[$dest]+x}" ]]; then
      echo "SKIP collision:"
      echo "  Existing source: ${planned_destinations[$dest]}"
      echo "  New source:      $src"
      echo "  Destination:     $dest"
      echo
      continue
    fi

    planned_destinations["$dest"]="$src"
    safe_move "$src" "$dest"
  done
}

remove_substring_command() {
  local pattern=""
  local remove_text=""

  while (( $# > 0 )); do
    case "$1" in
      --apply|--dry-run)
        set_apply_option "$1"
        ;;
      --glob)
        shift
        [[ $# -gt 0 ]] || die "--glob requires a value"
        pattern="$1"
        ;;
      --remove)
        shift
        [[ $# -gt 0 ]] || die "--remove requires a value"
        remove_text="$1"
        ;;
      -h|--help)
        usage
        exit 0
        ;;
      *)
        die "Unknown remove-substring option: $1"
        ;;
    esac
    shift
  done

  if [[ -z "$pattern" ]]; then
    read -r -p "File glob: " pattern
  fi

  if [[ -z "$remove_text" ]]; then
    read -r -p "Text to remove from filenames: " remove_text
  fi

  [[ -n "$pattern" ]] || die "No glob provided"
  [[ -n "$remove_text" ]] || die "No remove text provided"

  print_mode
  remove_substring_batch "$pattern" "$remove_text"
}

normalize_frame_batch() {
  local pattern="$1"
  local prefix="$2"

  local files=()
  mapfile -t files < <(collect_files_from_patterns "$pattern")

  if (( ${#files[@]} == 0 )); then
    echo "No files matched: $pattern"
    return 0
  fi

  echo "Matched files: ${#files[@]}"
  echo "Prefix:        $prefix"
  echo

  declare -A planned_destinations=()

  local src
  local dir
  local frame
  local dest

  for src in "${files[@]}"; do
    if [[ "$src" != *_frame_* ]]; then
      echo "SKIP no frame marker: $src"
      continue
    fi

    dir="$(dirname "$src")"

    # Gets the part after the last "_frame_".
    # Example:
    #   bacon_strip_..._frame_000.png_frame_000.png
    # becomes:
    #   000.png
    frame="${src##*_frame_}"

    dest="$dir/${prefix}_frame_$frame"

    if [[ -n "${planned_destinations[$dest]+x}" ]]; then
      echo "SKIP collision:"
      echo "  Existing source: ${planned_destinations[$dest]}"
      echo "  New source:      $src"
      echo "  Destination:     $dest"
      echo
      continue
    fi

    planned_destinations["$dest"]="$src"
    safe_move "$src" "$dest"
  done
}

normalize_frame_command() {
  local pattern=""
  local prefix=""

  while (( $# > 0 )); do
    case "$1" in
      --apply|--dry-run)
        set_apply_option "$1"
        ;;
      --glob)
        shift
        [[ $# -gt 0 ]] || die "--glob requires a value"
        pattern="$1"
        ;;
      --prefix)
        shift
        [[ $# -gt 0 ]] || die "--prefix requires a value"
        prefix="$1"
        ;;
      -h|--help)
        usage
        exit 0
        ;;
      *)
        die "Unknown normalize-frame option: $1"
        ;;
    esac
    shift
  done

  if [[ -z "$pattern" ]]; then
    read -r -p "File glob: " pattern
  fi

  if [[ -z "$prefix" ]]; then
    read -r -p "Output filename prefix: " prefix
  fi

  [[ -n "$pattern" ]] || die "No glob provided"
  [[ -n "$prefix" ]] || die "No prefix provided"

  print_mode
  normalize_frame_batch "$pattern" "$prefix"
}

normalize_known_command() {
  while (( $# > 0 )); do
    case "$1" in
      --apply|--dry-run)
        set_apply_option "$1"
        ;;
      -h|--help)
        usage
        exit 0
        ;;
      *)
        die "Unknown normalize-known option: $1"
        ;;
    esac
    shift
  done

  print_mode

  echo "Rule 1: remove redundant bacon substring"
  remove_substring_batch \
    "bacon_strip_*_bacon_strip_unknown.png" \
    "_bacon_strip_unknown"

  echo
  echo "Rule 2: normalize bacon animation frames"
  normalize_frame_batch \
    "bacon_strip_bacon_strip_animations_*_frame_*.png_frame_*.png" \
    "bacon_strip_animation"

  echo
  echo "Rule 3: normalize flying_sausage_link_2 frames"
  normalize_frame_batch \
    "flying_sausage_link_2_*_frame_*.png_frame_*.png" \
    "flying_sausage_link_2"

  echo
  echo "Rule 4: normalize flying_sausage_link frames"
  normalize_frame_batch \
    "flying_sausage_link_*_frame_*.png_frame_*.png" \
    "flying_sausage_link"
}

main() {
  local command="${1:-}"

  if [[ -z "$command" || "$command" == "-h" || "$command" == "--help" ]]; then
    usage
    exit 0
  fi

  shift

  case "$command" in
    flatten)
      flatten_command "$@"
      ;;
    remove-substring)
      remove_substring_command "$@"
      ;;
    normalize-frame)
      normalize_frame_command "$@"
      ;;
    normalize-known)
      normalize_known_command "$@"
      ;;
    *)
      die "Unknown command: $command"
      ;;
  esac
}

main "$@"
