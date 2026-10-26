GIMP img-tools

---

## Remove a white background and make it transparent

To remove a white background and make it transparent in GIMP, 
you must first add an alpha channel to support transparency 
and then use a selection or automated tool to clear the white area.

> in GIMP, open your image, 
> add an alpha channel, 
> select the white background using the Fuzzy Select tool, 
> and press delete

### Step-by-Step Instructions

1. Open the Image: 
Launch GIMP and go to `File > Open` or right-click the image and select "Edit with GIMP". 

To add it as a new layer in an existing project, 
use `File > Open` as Layers. 

2. Add an Alpha Channel: 
Ensure your layer supports transparency by navigating to `Layer > Transparency > Add Alpha Channel`. 
You can also right-click the image in the Layers panel and select Add Alpha Channel. 
If the option is greyed out, transparency is already enabled. 

3. Remove the Background:
   * Method A (Fuzzy Select/Magic Wand): Best for single-color areas.
      * Select the Fuzzy Select Tool (magic wand icon) or press U.
         * Adjust the Threshold in Tool Options; a higher threshold selects more colors, while a lower one is more precise.
         * Click the white background area. Hold Shift and click to add multiple white sections to the selection.
         * Press the Delete key to remove the selection.
      * Method B (Color to Alpha): Best for completely automating white removal.
      * Go to `Colors > Color to Alpha`.
         * Ensure the color block is set to white (`#ffffff`).
         * Click OK to instantly turn all white pixels transparent. 

4. Clean Up Edges (Optional):
   * To catch fringe pixels missed by selection tools, use `Select > Grow` by 1 or 2 pixels before deleting.
      * Use the Eraser Tool (Shift+E) to manually touch up any remaining white specks. 

5. Export as PNG: To preserve the transparency, you must save the file as a PNG. 
Go to `File > Export As`, give the file a `.png` extension, and click `Export`. 

---

## Turn gray lines to true black

### Method 1: The Levels Tool (Best for Text, Line Art, & Thresholds)
This method allows you to define exactly which shade of gray should become absolute black.

1. Go to the top menu and select `Colors** > Levels...`.
2. Look at the **Input Levels** graph (histogram) with three small triangle sliders underneath (Black, Gray, and White).
3. Click and drag the **black triangle slider** (on the far left) toward the right. 
4. Any gray pixels that fall to the left of the slider will instantly turn **100% black**.
5. Click **OK** once you are satisfied with the result.

### Method 2: The Curves Tool (Best for Soft Transitions)
Use this if you want a smoother transition or need to darken specific midtone grays while keeping total control.

1. Select `Colors** > Curves...`.
2. Click on the bottom-left point of the diagonal line 
   and drag it horizontally to the right to map dark grays to pure black.
3. Alternatively, click the middle of the line to create a point 
   and drag it downward to darken all midtone grays.
4. Click **OK**.

### Method 3: Threshold (For Harsh Black & White Only)
Use this if you want to eliminate *all* gray tones completely 
and convert the entire image strictly into pure black and pure white.

1. Select `Colors** > Threshold...`.
2. Move the sliders until the gray areas turn entirely black. 
3. *Note: This removes all gradients, leaving only binary black and white pixels.*

---

