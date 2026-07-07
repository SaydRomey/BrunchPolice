#!/usr/bin/env bash

################
# mkdir -p fixed

# for f in *.png; do
#   convert "$f" -colorspace Gray -level 75%,98% "fixed/$f"
# done
###############

# -----------------------------------------------------------------------------
# Script: fix-white-background.sh
#
# Description:
#   Cleans up light-gray / off-white backgrounds so they print closer to pure white. 
#   Especially useful for scanned line art, sketches, and grayscale images 
#   that should have a clean white paper background.
#
#   Supported ImageMagick tools, in this order:
#     - magick   (ImageMagick v7+)
#     - convert  (ImageMagick v6)
#
#   Features:
#     - Prompts user for directory (default: current directory)
#     - Finds supported image files
#     - Lists files before processing
#     - Lets user choose a cleanup strength:
#         gentle / normal / strong
#     - Optional "force white" pass for near-white backgrounds
#     - Writes results into an output directory (default: fixed/)
#     - Verifies output files were created
#     - Prints a summary at the end
#
# Optional flags:
#   --show-tool   Print the ImageMagick command selected
#   --dry-run     Show what would be done, but do not modify/create files
#   --help        Show usage
#
# Notes:
#   - This script converts the image to grayscale using -colorspace Gray.
#   - If you want to preserve color images, remove: -colorspace Gray
#
# -----------------------------------------------------------------------------

SHOW_TOOL=false
DRY_RUN=false

# Parse optional flags
for arg in "$@"; do
    case "$arg" in
        --show-tool)
            SHOW_TOOL=true
            ;;
        --dry-run)
            DRY_RUN=true
            ;;
        --help|-h)
            echo "Usage: $0 [--show-tool] [--dry-run]"
            exit 0
            ;;
        *)
            echo "Unknown option: $arg"
            echo "Usage: $0 [--show-tool] [--dry-run]"
            exit 1
            ;;
    esac
done

# Determine available ImageMagick tool
if command -v magick &> /dev/null; then
    IM_CMD="magick"
elif command -v convert &> /dev/null; then
    IM_CMD="convert"
else
    echo "No suitable ImageMagick command found."
    echo "Please install ImageMagick:"
    echo "  sudo apt install imagemagick"
    exit 1
fi

# Optionally show selected tool
if [ "$SHOW_TOOL" = true ]; then
    echo "Using ImageMagick command: $IM_CMD"
fi

# Helper function so the same script works with magick or convert
run_im() {
    if [[ "$IM_CMD" == "magick" ]]; then
        magick "$@"
    else
        convert "$@"
    fi
}

# 
echo
echo "Choose output mode:"
echo "  1) preserve color"
echo "  2) grayscale"
echo "  3) black and white (pure black/white, no gray)"
read -p "Enter choice [default: 1]: " MODE_CHOICE
MODE_CHOICE=${MODE_CHOICE:-1}

BW_THRESHOLD="55%"

case "$MODE_CHOICE" in
    1)
        MODE_NAME="preserve color"
        ;;
    2)
        MODE_NAME="grayscale"
        ;;
    3)
        MODE_NAME="black and white"
        read -p "Enter black/white threshold [default: 55%]: " BW_THRESHOLD_INPUT
        BW_THRESHOLD=${BW_THRESHOLD_INPUT:-55%}
        ;;
    *)
        echo "Invalid choice: $MODE_CHOICE"
        exit 1
        ;;
esac
# 

# Ask user for directory
read -p "Enter directory to process [default: current]: " DIR
DIR=${DIR:-.}

# Verify directory exists
if [ ! -d "$DIR" ]; then
    echo "Directory does not exist: $DIR"
    exit 1
fi

# Ask user for output directory
read -p "Enter output directory [default: $DIR/fixed]: " OUT_DIR
OUT_DIR=${OUT_DIR:-"$DIR/fixed"}

# Create output directory if needed
if [ "$DRY_RUN" = false ]; then
    mkdir -p "$OUT_DIR" || {
        echo "Could not create output directory: $OUT_DIR"
        exit 1
    }
fi

##############################################
# # Find supported image files (non-recursive)
# shopt -s nullglob nocaseglob
# IMAGE_FILES=(
#     "$DIR"/*.png
#     "$DIR"/*.jpg
#     "$DIR"/*.jpeg
#     "$DIR"/*.webp
#     "$DIR"/*.tif
#     "$DIR"/*.tiff
# )
# shopt -u nullglob nocaseglob
##############################################

# Find supported image files recursively
mapfile -d '' IMAGE_FILES < <(
    find "$DIR" -type f \( \
        -iname "*.png"  -o \
        -iname "*.jpg"  -o \
        -iname "*.jpeg" -o \
        -iname "*.webp" -o \
        -iname "*.tif"  -o \
        -iname "*.tiff" \
    \) -print0
)
shopt -u nullglob nocaseglob

# Check if any files exist
if [ "${#IMAGE_FILES[@]}" -eq 0 ]; then
    echo "No supported image files found in $DIR"
    exit 0
fi

# Let user choose preset
echo
# echo "Choose background cleanup strength:"
# echo "  1) gentle  - safer, preserves faint lines better     (-level 85%,99%)"
# echo "  2) normal  - good default for most line-art images   (-level 75%,98%)"
# echo "  3) strong  - more aggressive cleanup                 (-level 60%,97%)"
echo "  1) gentle  - light background cleanup                (-level 0%,94%)"
echo "  2) normal  - good default for tinted paper           (-level 0%,88%)"
echo "  3) strong  - stronger paper whitening                (-level 0%,82%)"
read -p "Enter choice [default: 2]: " PRESET
PRESET=${PRESET:-2}

# case "$PRESET" in
#     1)
#         LEVELS="85%,99%"
#         PRESET_NAME="gentle"
#         ;;
#     2)
#         LEVELS="75%,98%"
#         PRESET_NAME="normal"
#         ;;
#     3)
#         LEVELS="60%,97%"
#         PRESET_NAME="strong"
#         ;;
#     *)
#         echo "Invalid choice: $PRESET"
#         exit 1
#         ;;
# esac

# (softer options)
case "$PRESET" in
    1)
        LEVELS="0%,94%"
        PRESET_NAME="gentle"
        ;;
    2)
        LEVELS="0%,88%"
        PRESET_NAME="normal"
        ;;
    3)
        LEVELS="0%,82%"
        PRESET_NAME="strong"
        ;;
    *)
        echo "Invalid choice: $PRESET"
        exit 1
        ;;
esac

# Optional near-white-to-white pass
echo
# read -p "Force near-white pixels to pure white after cleanup? (y/n) [default: n]: " FORCE_WHITE
# FORCE_WHITE=${FORCE_WHITE:-n}

# FUZZ="6%"
# if [[ "$FORCE_WHITE" =~ ^[Yy]$ ]]; then
#     read -p "Enter fuzz percentage [default: 6%]: " FUZZ_INPUT
#     FUZZ=${FUZZ_INPUT:-6%}
# fi
read -p "Force very light pixels to pure white? (y/n) [default: n]: " FORCE_WHITE
FORCE_WHITE=${FORCE_WHITE:-n}

WHITE_THRESHOLD="97%"
if [[ "$FORCE_WHITE" =~ ^[Yy]$ ]]; then
    read -p "Enter white threshold [default: 97%]: " WHITE_THRESHOLD_INPUT
    WHITE_THRESHOLD=${WHITE_THRESHOLD_INPUT:-97%}
fi

# Overwrite behavior
echo
read -p "Overwrite existing output files if they already exist? (y/n) [default: n]: " OVERWRITE
OVERWRITE=${OVERWRITE:-n}

# List files and settings
echo
echo "Found the following image files:"
for f in "${IMAGE_FILES[@]}"; do
    echo "  $(basename "$f")"
done

echo
echo "Settings:"
echo "  Tool:              $IM_CMD"
echo "  Output mode:       $MODE_NAME"
if [[ "$MODE_CHOICE" == "3" ]]; then
    echo "  B/W threshold:     $BW_THRESHOLD"
fi
echo "  Directory:         $DIR"
echo "  Output directory:  $OUT_DIR"
echo "  Preset:            $PRESET_NAME"
echo "  Levels:            $LEVELS"
if [[ "$FORCE_WHITE" =~ ^[Yy]$ ]]; then
    echo "  Force white:       yes"
    echo "  Fuzz:              $FUZZ"
else
    echo "  Force white:       no"
fi
if [[ "$OVERWRITE" =~ ^[Yy]$ ]]; then
    echo "  Overwrite outputs: yes"
else
    echo "  Overwrite outputs: no"
fi
if [ "$DRY_RUN" = true ]; then
    echo "  Dry run:           yes"
else
    echo "  Dry run:           no"
fi

echo
read -p "Do you want to process these files? (y/n): " CONFIRM
if [[ ! "$CONFIRM" =~ ^[Yy]$ ]]; then
    echo "Operation cancelled."
    exit 0
fi

# Process files
CREATED_FILES=()
SKIPPED_FILES=()
FAILED_FILES=()

for file in "${IMAGE_FILES[@]}"; do
    ############################## (old non-recurive version)
    # base="$(basename "$file")"
    # out_file="$OUT_DIR/$base"
    ##############################

    ############################## (preserve the folder structure)
    rel_path="${file#$DIR/}"
    out_file="$OUT_DIR/$rel_path"
    base="$(basename "$file")"

    if [ "$DRY_RUN" = false ]; then
        mkdir -p "$(dirname "$out_file")"
    fi
    ##############################

    if [ -e "$out_file" ] && [[ ! "$OVERWRITE" =~ ^[Yy]$ ]]; then
        echo "Skipping (exists): $base"
        SKIPPED_FILES+=("$out_file")
        continue
    fi

    # Build command
    CMD_ARGS=(
        "$file"
        # # -colorspace Gray # (uncomment for black and white line art)
        # -level "$LEVELS"
    )

    # Output mode
case "$MODE_CHOICE" in
    1)
        # preserve color
        ;;
    2)
        CMD_ARGS+=(
            -colorspace Gray
        )
        ;;
    3)
        CMD_ARGS+=(
            -colorspace Gray
        )
        ;;
esac

# Background cleanup
CMD_ARGS+=(
    -level "$LEVELS"
)

# Optional whitening pass
if [[ "$FORCE_WHITE" =~ ^[Yy]$ ]]; then
    CMD_ARGS+=(
        -white-threshold "$WHITE_THRESHOLD"
    )
fi

# True black-and-white conversion
if [[ "$MODE_CHOICE" == "3" ]]; then
    CMD_ARGS+=(
        -threshold "$BW_THRESHOLD"
    )
fi

CMD_ARGS+=("$out_file")

    if [ "$DRY_RUN" = true ]; then
        echo "Would process: $base"
        CREATED_FILES+=("$out_file")
        continue
    fi

    echo "Processing: $base"
    if run_im "${CMD_ARGS[@]}"; then
        if [ -f "$out_file" ]; then
            CREATED_FILES+=("$out_file")
        else
            echo "Failed: output not created for $base"
            FAILED_FILES+=("$file")
        fi
    else
        echo "Failed: $base"
        FAILED_FILES+=("$file")
    fi
done

# Summary
echo
echo "--------------------------------------------------"
echo "Summary"
echo "--------------------------------------------------"
echo "Original files found: ${#IMAGE_FILES[@]}"
echo "Created/processed:    ${#CREATED_FILES[@]}"
echo "Skipped:              ${#SKIPPED_FILES[@]}"
echo "Failed:               ${#FAILED_FILES[@]}"

if [ "${#CREATED_FILES[@]}" -gt 0 ]; then
    echo
    echo "Created/processed files:"
    for f in "${CREATED_FILES[@]}"; do
        echo "  $(basename "$f")"
    done
fi

if [ "${#SKIPPED_FILES[@]}" -gt 0 ]; then
    echo
    echo "Skipped files:"
    for f in "${SKIPPED_FILES[@]}"; do
        echo "  $(basename "$f")"
    done
fi

if [ "${#FAILED_FILES[@]}" -gt 0 ]; then
    echo
    echo "Failed files:"
    for f in "${FAILED_FILES[@]}"; do
        echo "  $(basename "$f")"
    done
fi
