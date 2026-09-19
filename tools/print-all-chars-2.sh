#!/bin/bash

### Improvements ###
# 
# Terminal-Aware Width: 
# Uses shutil.get_terminal_size to automatically detect
# screen width and wrap text before it spills over messily.
# 
# Separated Blocks: 
# Each category is now cleanly isolated with a 
# header underline, a descriptive label, and padding newlines.
# 
# Invisible Characters Filtered: 
# Explicitly skips system codes, unassigned code points, 
# and terminal control characters (Cc, Cf, Cs)
# that would otherwise render as broken question marks or blank gaps.
# 
# Spaced Grid Alignment: 
# Characters are separated by a space on the line, 
# making them vastly easier to distinguish visually.

python3 -c '
import unicodedata
import shutil
from collections import defaultdict

# 1. Get current terminal width dynamically, default to 80
terminal_width = shutil.get_terminal_size((80, 20)).columns
max_line_len = min(terminal_width - 4, 100) # Leave a margin

# 2. Group characters by Unicode category
categories = defaultdict(list)
for codepoint in range(0x110000):
    char = chr(codepoint)
    cat_code = unicodedata.category(char)
    
    # Skip control characters and surrogates that break terminal rendering
    if cat_code in ["Cc", "Cf", "Cs", "Co", "Cn"]:
        continue
    categories[cat_code].append(char)

# 3. Define mapping for readable headers
type_names = {
    "Lu": "UPPERCASE LETTERS",
    "Ll": "LOWERCASE LETTERS",
    "Lt": "TITLECASE LETTERS",
    "Lm": "MODIFIER LETTERS",
    "Lo": "OTHER LETTERS (Global Alphabets)",
    "Nd": "DECIMAL NUMBERS",
    "Nl": "LETTER-LIKE NUMBERS (e.g., Roman Numerals)",
    "No": "OTHER NUMBERS (e.g., Fractions)",
    "Pc": "CONNECTOR PUNCTUATION (e.g., Underscores)",
    "Pd": "DASH PUNCTUATION",
    "Ps": "OPEN PUNCTUATION (e.g., Brackets)",
    "Pe": "CLOSE PUNCTUATION (e.g., Brackets)",
    "Pi": "INITIAL PUNCTUATION (Quotes)",
    "Pf": "FINAL PUNCTUATION (Quotes)",
    "Po": "OTHER PUNCTUATION",
    "Sm": "MATH SYMBOLS",
    "Sc": "CURRENCY SYMBOLS",
    "Sk": "MODIFIER SYMBOLS",
    "So": "OTHER SYMBOLS (Symbols & Emojis)",
    "Zs": "SPACE SEPARATORS"
}

# 4. Print structured output
for code, name in type_names.items():
    if code in categories and categories[code]:
        # Print a bold subtitle section divider
        print(f"\n=== {name} ({len(categories[code])} chars) ===")
        print("-" * len(name))
        
        # Print characters wrapped to the terminal width
        current_line = []
        for char in categories[code]:
            current_line.append(char)
            if len(current_line) >= max_line_len:
                print(" ".join(current_line))
                current_line = []
        if current_line:
            print(" ".join(current_line))
'

