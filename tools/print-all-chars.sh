#!/bin/bash

python3 -c '
import unicodedata
from collections import defaultdict

# Group characters by their Unicode category
categories = defaultdict(list)

# Loop through the entire basic Unicode range
for codepoint in range(0x110000):
    char = chr(codepoint)
    # Get the two-letter category code (e.g., Lu for Uppercase Letter)
    cat_code = unicodedata.category(char)
    categories[cat_code].append(char)

# Friendly display names for common character types
type_names = {
    "Lu": "Uppercase Letters",
    "Ll": "Lowercase Letters",
    "Lt": "Titlecase Letters",
    "Lm": "Modifier Letters",
    "Lo": "Other Letters",
    "Nd": "Decimal Numbers",
    "Nl": "Letter-like Numbers",
    "No": "Other Numbers",
    "Pc": "Connector Punctuation",
    "Pd": "Dash Punctuation",
    "Ps": "Open Punctuation",
    "Pe": "Close Punctuation",
    "Pi": "Initial Punctuation",
    "Pf": "Final Punctuation",
    "Po": "Other Punctuation",
    "Sm": "Math Symbols",
    "Sc": "Currency Symbols",
    "Sk": "Modifier Symbols",
    "So": "Other Symbols (Emojis/Icons)",
    "Zs": "Space Separators"
}

# Print each category on its own line
for code, name in type_names.items():
    if code in categories:
        # Join all characters of this type together into one line
        chars_string = "".join(categories[code])
        print(f"[{name}]: {chars_string}")
'

