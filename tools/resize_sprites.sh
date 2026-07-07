#!/usr/bin/env bash
# File: resize_sprites.sh
# 
# Resize pixel-art sprite files from JPEG and/or PNG source images into PNG outputs.
# 
# This script:
#   - Prompts for a source directory.
#   - Defaults to the current directory if no path is entered.
#   - Finds all *.jpeg and *.png files in that source directory.
#   - Displays the number of valid source files found before showing resize options.
#   - Lets you choose one or more output sizes.
#   - Creates size-specific output directories such as:
#       <source-dir>/resized/128x128/
#       <source-dir>/resized/64x64/
#   - Writes resized files as PNG to avoid JPEG compression artifacts.
#   - Keeps the original base filename.
#       Example:
#         enemy_slime.jpeg -> resized/128x128/enemy_slime.png
#         enemy_slime.png  -> resized/128x128/enemy_slime.png
#   - Uses nearest-neighbor scaling for pixel-art-safe resizing.
#   - Warns when source images are not the expected 1024x1024.
#   - Warns when the resize target is not an even integer scale.
#   - If LOG_REPORT is set to true, 
#       writes the per-file report to a log file under resized/, 
#       while keeping only the high-level summary in the terminal.
#   - Prints a source/output report for every generated file.
# 
# Why PNG output?
#   JPEG is lossy and may introduce compression artifacts around sharp pixel-art edges. 
#   PNG is lossless and is usually the safer format for sprites.
# 
# Why nearest-neighbor?
#   Nearest-neighbor scaling avoids anti-aliasing and color blending. 
#   This keeps hard pixel edges crisp, matching the usual behavior expected for pixel art.
# 
# Requirements:
#   ImageMagick must be installed.
# 
# Install ImageMagick:
#   Ubuntu/Debian:
#     sudo apt install imagemagick
# 
#   macOS:
#     brew install imagemagick
# 
# Usage:
#   chmod +x resize_sprites.sh
# 
#   ./resize_sprites.sh
#   (writes the detailed output to a report file.)
# 
#   ./resize_sprites.sh --no-log
#   (prints the detailed output directly in the terminal.)
# 
# Example output for a 1024x1024 source image:
# 
#   Source:      /sprites/enemy_slime.jpeg
#   Output:      /sprites/resized/128x128/enemy_slime.png
#   Source size: 42K
#   Output size: 3.1K
#   Resolution:  1024x1024 -> 128x128
#   Scale:       12.50%
#   Ratio:       8:1
#   Even scale:  yes
# 
# To add more resize targets later, edit AVAILABLE_TARGETS below.

set -euo pipefail

# Add more target sizes here later, for example:
# AVAILABLE_TARGETS=("128x128" "64x64" "32x32")
AVAILABLE_TARGETS=("128x128" "64x64")

# Expected source size.
# The script does not fail if an image differs, but it prints a warning.
EXPECTED_SOURCE_WIDTH=1024
EXPECTED_SOURCE_HEIGHT=1024

# Output format for resized sprites.
# PNG is recommended for pixel art because it is lossless.
OUTPUT_EXTENSION="png"

# Detailed output mode.
# true  = write detailed per-file output to a report file.
# false = print detailed per-file output directly in the terminal.
#
# You can override this from the command line:
#   ./resize_sprites.sh --no-log
LOG_REPORT=true
REPORT_FILE=""

parse_args() {
  for arg in "$@"; do
    case "$arg" in
      --no-log)
        LOG_REPORT=false
        ;;
      --log)
        LOG_REPORT=true
        ;;
      -h|--help)
        echo "Usage: $0 [--log|--no-log]"
        echo
        echo "Options:"
        echo "  --log      Write detailed output to a report file. Default."
        echo "  --no-log   Print detailed output directly in the terminal."
        exit 0
        ;;
      *)
        echo "Error: unknown option: $arg"
        echo "Use --help for usage."
        exit 1
        ;;
    esac
  done
}

prompt_source_dir() {
  read -r -p "Source directory [current directory]: " SRC_DIR
  SRC_DIR="${SRC_DIR:-.}"

  if [[ ! -d "$SRC_DIR" ]]; then
    echo "Error: source directory does not exist: $SRC_DIR"
    exit 1
  fi

  SRC_DIR="$(cd "$SRC_DIR" && pwd)"
}

find_source_files() {
  shopt -s nullglob

  # Valid source files.
  # We can add more extensions here later if needed.
  files=(
  "$SRC_DIR"/*.jpeg
  "$SRC_DIR"/*.jpg
  "$SRC_DIR"/*.png
  "$SRC_DIR"/*.JPEG
  "$SRC_DIR"/*.JPG
  "$SRC_DIR"/*.PNG
  )
  # files=("$SRC_DIR"/*.jpeg "$SRC_DIR"/*.png)


  if (( ${#files[@]} == 0 )); then
    echo
    echo "No valid sprite files found in: $SRC_DIR"
    echo "Expected: *.jpeg, *.jpg, or *.png"
    exit 0
  fi

  echo
  echo "Valid sprite files found: ${#files[@]}"
}

detect_imagemagick() {
  # ImageMagick v7 uses `magick`.
  # ImageMagick v6 often uses `convert` and `identify`.
  if command -v magick >/dev/null 2>&1; then
    IM_CONVERT=("magick")
    IM_IDENTIFY=("magick" "identify")
  elif command -v convert >/dev/null 2>&1 && command -v identify >/dev/null 2>&1; then
    IM_CONVERT=("convert")
    IM_IDENTIFY=("identify")
  else
    echo "Error: ImageMagick is not installed."
    echo
    echo "Install it with:"
    echo "  Ubuntu/Debian: sudo apt install imagemagick"
    echo "  macOS:         brew install imagemagick"
    exit 1
  fi
}

print_target_menu() {
  echo
  echo "Available resize targets:"

  local i=1
  for target in "${AVAILABLE_TARGETS[@]}"; do
    echo "  $i) $target"
    ((i++))
  done

  echo "  a) all"
  echo
  echo "Enter one number, multiple numbers separated by commas, or 'a'."
  echo "Example: 1,2"
}

select_targets() {
  local choice
  print_target_menu
  read -r -p "Resize target(s) [a]: " choice
  choice="${choice:-a}"

  SELECTED_TARGETS=()

  if [[ "$choice" == "a" || "$choice" == "A" || "$choice" == "all" ]]; then
    SELECTED_TARGETS=("${AVAILABLE_TARGETS[@]}")
    return
  fi

  IFS=',' read -ra indexes <<< "$choice"

  for raw_index in "${indexes[@]}"; do
    # Trim whitespace around menu choices.
    local index
    index="$(echo "$raw_index" | xargs)"

    if ! [[ "$index" =~ ^[0-9]+$ ]]; then
      echo "Error: invalid choice '$index'."
      exit 1
    fi

    local array_index=$((index - 1))

    if (( array_index < 0 || array_index >= ${#AVAILABLE_TARGETS[@]} )); then
      echo "Error: choice '$index' is out of range."
      exit 1
    fi

    SELECTED_TARGETS+=("${AVAILABLE_TARGETS[$array_index]}")
  done
}

get_dimensions() {
  local file="$1"

  # Prints: width height
  # The trailing newline is important because `read` expects one.
  "${IM_IDENTIFY[@]}" -format "%w %h\n" "$file"
}

get_file_size() {
  local file="$1"

  # `du -h` is available on macOS and Linux.
  # It prints a human-readable file size such as 42K, 1.2M, etc.
  du -h "$file" | awk '{print $1}'
}

parse_target_size() {
  local target="$1"

  TARGET_WIDTH="${target%x*}"
  TARGET_HEIGHT="${target#*x}"

  if ! [[ "$TARGET_WIDTH" =~ ^[0-9]+$ && "$TARGET_HEIGHT" =~ ^[0-9]+$ ]]; then
    echo "Error: invalid target size '$target'. Expected format like 128x128."
    exit 1
  fi

  if (( TARGET_WIDTH <= 0 || TARGET_HEIGHT <= 0 )); then
    echo "Error: target size must be greater than zero: $target"
    exit 1
  fi
}

get_output_path() {
  local src_file="$1"
  local target="$2"

  local filename
  filename="$(basename "$src_file")"

  # Remove only the final extension.
  # enemy_slime.jpeg -> enemy_slime
  local base_name="${filename%.*}"

  local out_dir="$SRC_DIR/resized/$target"

  echo "$out_dir/$base_name.$OUTPUT_EXTENSION"
}

format_scale_info() {
  local src_w="$1"
  local src_h="$2"
  local target_w="$3"
  local target_h="$4"

  WIDTH_PERCENT="$(awk "BEGIN { printf \"%.2f\", ($target_w / $src_w) * 100 }")"
  HEIGHT_PERCENT="$(awk "BEGIN { printf \"%.2f\", ($target_h / $src_h) * 100 }")"

  if (( src_w % target_w == 0 && src_h % target_h == 0 )); then
    WIDTH_RATIO=$((src_w / target_w))
    HEIGHT_RATIO=$((src_h / target_h))

    if (( WIDTH_RATIO == HEIGHT_RATIO )); then
      RATIO="${WIDTH_RATIO}:1"
    else
      RATIO="${WIDTH_RATIO}:1 width, ${HEIGHT_RATIO}:1 height"
    fi

    EVEN_SCALE="yes"
  else
    RATIO="non-integer"
    EVEN_SCALE="no"
  fi
}

warn_if_needed() {
  local src_file="$1"
  local src_w="$2"
  local src_h="$3"
  local target_w="$4"
  local target_h="$5"

  if (( src_w != EXPECTED_SOURCE_WIDTH || src_h != EXPECTED_SOURCE_HEIGHT )); then
    {
      echo "Warning: '$src_file' is ${src_w}x${src_h}, expected ${EXPECTED_SOURCE_WIDTH}x${EXPECTED_SOURCE_HEIGHT}."
    } | write_report
  fi

  if (( src_w % target_w != 0 || src_h % target_h != 0 )); then
    {
      echo "Warning: '$src_file' does not divide evenly into ${target_w}x${target_h}."
      echo "         This is not a pixel-perfect integer scale."
    } | write_report
  fi
}

# If LOG_REPORT is true, 
# Write the per-file report to a log file under resized/, 
# while keeping only the high-level summary in the terminal.
setup_report_output() {
  if [[ "$LOG_REPORT" == true ]]; then
    local report_dir="$SRC_DIR/resized"
    mkdir -p "$report_dir"

    local timestamp
    timestamp="$(date +"%Y%m%d-%H%M%S")"

    REPORT_FILE="$report_dir/resize-report-$timestamp.txt"

    {
      echo "Resize sprites report"
      echo "Generated:        $(date)"
      echo "Source directory: $SRC_DIR"
      echo "Output base dir:  $SRC_DIR/resized"
      echo "Output format:    .$OUTPUT_EXTENSION"
      echo "Files found:      ${#files[@]}"
      echo "Selected targets: ${SELECTED_TARGETS[*]}"
      echo
    } > "$REPORT_FILE"
  fi
}

write_report() {
  if [[ "$LOG_REPORT" == true ]]; then
    cat >> "$REPORT_FILE"
  else
    cat
  fi
}

resize_file() {
  local src_file="$1"
  local target="$2"

  parse_target_size "$target"

  local out_dir="$SRC_DIR/resized/$target"
  local dest_file
  dest_file="$(get_output_path "$src_file" "$target")"

  local src_w
  local src_h

  if ! read -r src_w src_h < <(get_dimensions "$src_file"); then
    echo "Error: could not read dimensions for: $src_file"
    return 1
  fi

  mkdir -p "$out_dir"

  local source_size
  source_size="$(get_file_size "$src_file")"

  format_scale_info "$src_w" "$src_h" "$TARGET_WIDTH" "$TARGET_HEIGHT"
  warn_if_needed "$src_file" "$src_w" "$src_h" "$TARGET_WIDTH" "$TARGET_HEIGHT"

  # Pixel-art-safe resize:
  #   -filter Point uses nearest-neighbor sampling.
  #   -resize WIDTHxHEIGHT! forces the exact target size.
  #
  # The exclamation mark is intentional. It tells ImageMagick to force the
  # output to the requested dimensions instead of preserving aspect ratio.
  # Since the expected source files are square and the targets are square,
  # this is safe for the intended 1024x1024 -> 128x128 / 64x64 workflow.
  "${IM_CONVERT[@]}" "$src_file" \
    -filter Point \
    -resize "${TARGET_WIDTH}x${TARGET_HEIGHT}!" \
    "$dest_file"

  local output_size
  output_size="$(get_file_size "$dest_file")"

  {
    printf "%-13s %s\n" "Source:" "$src_file"
    printf "%-13s %s\n" "Output:" "$dest_file"
    printf "%-13s %s\n" "Source size:" "$source_size"
    printf "%-13s %s\n" "Output size:" "$output_size"
    printf "%-13s %sx%s -> %sx%s\n" "Resolution:" "$src_w" "$src_h" "$TARGET_WIDTH" "$TARGET_HEIGHT"

    if [[ "$WIDTH_PERCENT" == "$HEIGHT_PERCENT" ]]; then
      printf "%-13s %s%%\n" "Scale:" "$WIDTH_PERCENT"
    else
      printf "%-13s width %s%%, height %s%%\n" "Scale:" "$WIDTH_PERCENT" "$HEIGHT_PERCENT"
    fi

    printf "%-13s %s\n" "Ratio:" "$RATIO"
    printf "%-13s %s\n" "Even scale:" "$EVEN_SCALE"
    echo
  } | write_report
}

main() {
  parse_args "$@"

  prompt_source_dir
  detect_imagemagick

  find_source_files

  select_targets
  setup_report_output

  echo
  echo "Source directory: $SRC_DIR"
  echo "Output base dir:  $SRC_DIR/resized"
  echo "Output format:    .$OUTPUT_EXTENSION"
  echo "Files found:      ${#files[@]}"
  echo "Selected targets: ${SELECTED_TARGETS[*]}"

  if [[ "$LOG_REPORT" == true ]]; then
    echo "Report mode:      file"
    echo "Report file:      $REPORT_FILE"
  else
    echo "Report mode:      terminal"
  fi

  echo
  echo "Processing..."

  for src_file in "${files[@]}"; do
    for target in "${SELECTED_TARGETS[@]}"; do
      resize_file "$src_file" "$target"
    done
  done

  echo "Done."

  if [[ "$LOG_REPORT" == true ]]; then
    echo "Report written to: $REPORT_FILE"
  fi
}

main "$@"
