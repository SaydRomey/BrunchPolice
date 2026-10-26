
# Tools & Converters

- [File Conversion Tools](#file-conversion-tools)
    - [Pixel-art Image Resizing](#pixel-art-image-resizing)
    - [Fixing White Backgrounds](#fixing-white-backgrounds)
    - [WebP to PNG Conversion](#webp-to-png-conversion)
- [Sprite File Utilities](#sprite-file-utilities)
    - [Moving and Renaming Files](#moving-and-renaming-files)
- [Misc](#misc)
    - [Pixel PNG Generator](#pixel-png-generator)
- [Dependencies](#dependencies)

---

## File Conversion Tools

### Pixel-art Image Resizing

Script: [Resize Pixel-art Sprite Files][resize-sprites]

For **pixel-art safe** image resizing.

Features:
- Prompts for a source directory
- Defaults to the current directory if no path is entered
- Detects `ImageMagick`
- Finds `*.jpeg`, `*.jpg`, and `*.png` files, including uppercase variants
- Displays the number of valid source files found before showing resize options
- Lets you choose one or more output sizes
- Creates size-specific output directories such as:
  - `<source-dir>/resized/128x128/`
  - `<source-dir>/resized/64x64/`
- Resizes each file to **PNG** using nearest-neighbor scaling
- Writes detailed source/output information to a report file by default
- Can print detailed output directly in the terminal with `--no-log`

> [!NOTE] Update Script  
> To add more resize targets, edit the `AVAILABLE_TARGETS` variable in the script.

> [!WARNING] TODO  
> Planned upgrades for this script can be found in [this file][resize-sprite-todo-md].

Usage:

```bash
chmod +x resize_sprites.sh

./resize_sprites.sh
# Writes the detailed output to a report file.

./resize_sprites.sh --no-log
# Prints the detailed output directly in the terminal.
```

Example output for a `1024x1024` source image:

```text
Source:       /sprites/enemy_slime.jpeg
Output:       /sprites/resized/128x128/enemy_slime.png
Source size:  42K
Output size:  3.1K
Resolution:   1024x1024 -> 128x128
Scale:        12.50%
Ratio:        8:1
Even scale:   yes
```

---

### Fixing White Backgrounds

Script: [Fix White Background][fix-white-background]

For making near-white image backgrounds truly white.

Features:
- Prompts for a source directory
- Defaults to the current directory if no path is entered
- Finds supported image files
- Lists files before processing
- Lets the user choose a cleanup strength:
  - gentle
  - normal
  - strong
- Supports an optional “force white” pass for near-white backgrounds
- Writes results into an output directory
- Verifies output files were created
- Prints a summary at the end

> [!NOTE] Clean Image Printing  
> Useful when generated “white” backgrounds are slightly gray 
> or off-white and need to be cleaned for printing or compositing.

---

### WebP to PNG Conversion

Script: [WebP to PNG Converter][webp-to-png]

For converting `.webp` image files into `.png` files.

> [!NOTE]
> Check the script itself for supported options and output behavior.

---

## Sprite File Utilities

### Moving and Renaming files

Script: [Sprite File Utilities][sprite-file-utils]

Batch utilities for moving and renaming generated sprite PNG files.

Features:
- Flatten nested PNG files into a target directory
- Remove redundant filename fragments
- Normalize broken animation frame filenames
- Dry-run by default
- Applies changes only when `--apply` is passed
- Detects and skips output collisions

Usage examples:

```bash
chmod +x sprite-file-utils.sh

./sprite-file-utils.sh flatten
# Preview flattening nested files.

./sprite-file-utils.sh flatten --apply
# Actually move nested files.

./sprite-file-utils.sh remove-substring \
  --glob 'bacon_strip_*_bacon_strip_unknown.png' \
  --remove '_bacon_strip_unknown'

./sprite-file-utils.sh normalize-frame \
  --glob 'bacon_strip_bacon_strip_animations_*_frame_*.png_frame_*.png' \
  --prefix 'bacon_strip_animation'

./sprite-file-utils.sh normalize-known
# Preview known cleanup rules.

./sprite-file-utils.sh normalize-known --apply
# Apply known cleanup rules.
```

---

## Misc

### Pixel PNG Generator

Script: [Download a 1x1 Pixel PNG File of Any Color][download-1x1]

Creates a simple `1x1` PNG file using a selected or custom color.

Features:
- Select a color from a list
- Input a specific HEX color code
- Useful for quick placeholder or utility assets

Example HEX value:

```text
c9e2b3ff
```

> [!TIP] Simple Asset for *Godot*  
> This file can be used as a simple scalable asset in **Godot**.

---

## Dependencies

- [ImageMagick][url-imagemagick]
- [Node.js][url-nodejs]

<details>
<summary>Installing Dependencies</summary>

<b>Ubuntu/Debian:</b>

```bash
sudo apt install imagemagick nodejs
```

<b>macOS:</b>

```bash
brew install imagemagick node
```

</details>

---

<!-- Links -->

[url-imagemagick]: https://imagemagick.org/ "Mastering Digital Image Alchemy"
[url-nodejs]: https://nodejs.org/ "JavaScript Runtime"

[resize-sprites]: ./resize_sprites.sh "Pixel-art Safe Conversion"
[resize-sprite-todo-md]: ./_todo.md "Upgrade Notes For resize_sprites.sh"
[fix-white-background]: ./fix-white-background.sh "Non-gray White Background Cleanup"
[webp-to-png]: ./webp_to_png.sh "WebP to PNG Converter"
[sprite-file-utils]: ./sprite-file-utils.sh "Sprite File Batch Move and Rename Utilities"
[download-1x1]: ./download-1x1.js "Minimal Color Pixel Asset Generator"

