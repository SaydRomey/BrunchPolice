
# Tools & Converters

<!-- - [Tools \& Converters](#tools--converters)
  - [File Conversion Tools](#file-conversion-tools)
    - [Resize Pixel-art Sprite Files](#resize-pixel-art-sprite-files)
    - [\[Making sure the "white" background is not gray\]\[fix-white-background\]](#making-sure-the-white-background-is-not-grayfix-white-background)
  - [Misc](#misc)
    - [Download a 1x1 Pixel PNG file of any color](#download-a-1x1-pixel-png-file-of-any-color)
  - [Dependencies](#dependencies) -->


---

## File Conversion Tools


### Script: [Resize Pixel-art Sprite Files][resize-sprites]  
For **pixel-art safe** conversions.

Features:
- Prompt for source directory
- Detect `ImageMagick`
- Find `*.jpeg` and `*.png` files
- Print valid file count
- Show resize target menu
- Create resized `<target>` folders
- Resize each file to **PNG** using nearest-neighbor scaling
- Logs/Print source/output details (logs by default)

> [!NOTE] Update Script  
> For additional resize targets, 
> edit `AVAILABLE_TARGETS` variable in the sript.

> Upgrades to the scripts can be found in [this file][resize-sprite-todo-md]


<!--
Convert and keep ratio:
convert input.jpg -resize 256x256 output.jpg

Convert without keeping ratio:
convert input.jpg -resize 256x256! output.jpg
-->

---

### Script: [Making sure the "white" background is not gray][fix-white-background]

Features:
- Prompts user for directory (default: current directory)
- Finds supported image files
- Lists files before processing
- Lets user choose a cleanup strength:
  gentle / normal / strong
- Optional "force white" pass for near-white backgrounds
- Writes results into an output directory (default: fixed/)
- Verifies output files were created
- Prints a summary at the end

> [!NOTE] To Print Clean Images  
> To make the background truly white for printing...

---

## Misc

### Script: [Download a 1x1 Pixel PNG file of any color][download-1x1]
  - Select a color from a list or input a specific HEX color code 
    *(e.g., c9e2b3ff)*

> [!TIP] Simple Asset  
> This file can be used as a simple scalable asset in **Godot**

---

## Dependencies

- [ImageMagick][url-imagemagick]
- ...


<details><summary>Installing Dependencies</summary>

<b>Ubuntu/Debian:</b>
```bash
sudo apt install imagemagick
```

<b>macOS:</b>
```bash
brew install imagemagick
```

</details>

---

<!-- Links -->
[url-imagemagick]: https://imagemagick.org/ "Mastering Digital Image Alchemy"  
[resize-sprites]: ./resize_sprites.sh "Pixel-art Safe Conversion"  
[resize-sprite-todo-md]: ./_todo.md "Upgrade For `resize-sprites.sh`"  
[download-1x1]: ./download-1x1.js "Minimal Color Pixel Asset Generator"  

[fix-white-background]: ./fix_white_background.sh "Non-grey 'White' Background For Printing"  
