
# Tools for Directory Bundle Creation

## Using the script

1. create the `names.txt` file containing the list of names
2. launch the [bundle directory creating script][script-create-dirs-from-file]

[script-create-dirs-from-file]: ./create-dir-with-text-file.sh "Now featuring sanitization!"

## Using a text file

### CLI one-liner: 
`while IFS= read -r name; do mkdir -p "$name"; done < names.txt`

### Script
```bash
#!/bin/bash

# Path to the file containing the list of names
input_file="names.txt"

# Check if the file exists
if [ ! -f "$input_file" ]; then
    echo "Error: $input_file not found."
    exit 1
fi

echo "Processing names and creating sanitized directories..."

# Read the file line by line
while IFS= read -r line || [ -n "$line" ]; do
    # 1. Strip leading/trailing whitespaces and tabs
    clean_name=$(echo "$line" | xargs)
    
    # Skip empty lines
    if [ -z "$clean_name" ]; then
        continue
    fi
    
    # 2. Convert to lowercase
    clean_name=$(echo "$clean_name" | tr '[:upper:]' '[:lower:]')
    
    # 3. Replace all spaces (and multiple spaces) with a single hyphen
    clean_name=$(echo "$clean_name" | tr -s ' ' '-')
    
    # 4. Remove special characters (keeps lowercase letters, numbers, and hyphens)
    clean_name=$(echo "$clean_name" | tr -cd 'a-z0-9-')
    
    # 5. Clean up any trailing/leading hyphens caused by stripped characters
    clean_name=$(echo "$clean_name" | sed 's/^-//;s/-$//')

    # Double check we still have a valid name after sanitizing
    if [ -n "$clean_name" ]; then
        mkdir -p "$clean_name"
        echo "Original: '$line' -> Created: '$clean_name'"
    else
        echo "Skipped: '$line' (Name became empty after sanitization)"
    fi

done < "$input_file"
```


### Example list of filenames
```txt
"abyssal-current"
"alchemical-echo"
"ambercoil-asp"
"ashweaver-recluse"
"ashwrought-colossus"
"bannerbound-revenant"
"bloodroot-effigy"
"bloomrot-titan"
"bloomveil-widow"
"boglight-mimic"
"caput-marionette"
"chartreuse-husk"
"chronopollen-sprite"
"cinnabar-scarab"
"citrine-golem"
"crimson-echo"
"doppelshade"
"fandancer-fragment"
"fangbloom-wyrm"
"feathered-null"
"fox-mirage"
"fractal-shardling"
"funeral-dancer"
"gamboge-djinnling"
"glassborne-echo"
"glasslash-serpent"
"glittering-grimoire"
"grovebound-sentinel"
"heliotropic-lurker"
"hollow-prophet"
"hue-leeches"
"huefractals"
"lava-fused-behemoth"
"lilyborn-mirage"
"limeroot-trickster"
"memory-grafter"
"memory-husk"
"memory-leech"
"mirage-revenant"
"mirrorwake-duelist"
"mirrorthirst-wyrm"
"mossgrave-revenant"
"moth-witch-of-the-verdant-spiral"
"null-root"
"nullborn-husk"
"nullshade-echo"
"nullshade-revenant"
"ochre-golem"
"phylactery-swarm"
"prism-unform"
"razzflare-imp"
"red-widow"
"rustworn-judge"
"sapborn-stalker"
"searblood-cultist"
"shatterglass-choir"
"silence-incarnate"
"skycall-wraith"
"sootshade-collector"
"sorrowwing"
"spectral-harvester"
"sporekin"
"stormwrit-hound"
"sunburnt-jackal"
"sundial-scarwalker"
"sunflare-marionette"
"tapestry-watcher-nullshade"
"tapestry-watcher"
"tempest-marionette"
"the-bound"
"the-colorless-shape"
"the-seventh-hue"
"the-unhued-choir"
"thornwrithe-beast"
"thulian-vowkeeper"
"tideworn-apostle"
"tyrian-echo"
"veilshift-matron"
"verdant-maw"
"whisperglass-wyrm"
"wickbone-lantern"
"wickerborn"
"wound-remnant"
```


