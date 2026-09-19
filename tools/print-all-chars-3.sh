#!/bin/bash

echo "=========================================="
echo " Select a Script / Language to Display:"
echo "=========================================="

# 1. Present a multiple-choice list to the user
options=(
    "All Available Characters"
    "Latin (English, Western European)"
    "Greek & Coptic"
    "Cyrillic (Russian, Ukrainian, etc.)"
    "Arabic"
    "Hebrew"
    "CJK Unified Ideographs (Chinese, Japanese, Korean)"
    "Hiragana & Katakana (Japanese)"
    "Hangul (Korean)"
    "Devanagari (Hindi, Marathi)"
    "Quit"
)

select opt in "${options[@]}"; do
    case $opt in
        "All Available Characters") script_choice="ALL"; break;;
        "Latin (English, Western European)") script_choice="LATIN"; break;;
        "Greek & Coptic") script_choice="GREEK"; break;;
        "Cyrillic (Russian, Ukrainian, etc.)") script_choice="CYRILLIC"; break;;
        "Arabic") script_choice="ARABIC"; break;;
        "Hebrew") script_choice="HEBREW"; break;;
        "CJK Unified Ideographs (Chinese, Japanese, Korean)") script_choice="CJK"; break;;
        "Hiragana & Katakana (Japanese)") script_choice="KANA"; break;;
        "Hangul (Korean)") script_choice="HANGUL"; break;;
        "Devanagari (Hindi, Marathi)") script_choice="DEVANAGARI"; break;;
        "Quit") echo "Exiting."; exit 0;;
        *) echo "Invalid option. Please choose a number from the menu.";;
    esac
done

echo -e "\nProcessing... please wait...\n"

# 2. Pass the user choice into the character processing engine
python3 -c '
import unicodedata
import shutil
import sys
from collections import defaultdict

choice = "'"$script_choice"'"

# Define Unicode block range filters
def in_selected_script(char, name):
    if choice == "ALL":
        return True
    try:
        char_name = unicodedata.name(char)
    except ValueError:
        return False
        
    if choice == "LATIN" and "LATIN" in char_name: return True
    if choice == "GREEK" and "GREEK" in char_name: return True
    if choice == "CYRILLIC" and "CYRILLIC" in char_name: return True
    if choice == "ARABIC" and "ARABIC" in char_name: return True
    if choice == "HEBREW" and "HEBREW" in char_name: return True
    if choice == "CJK" and "CJK UNIFIED" in char_name: return True
    if choice == "KANA" and ("HIRAGANA" in char_name or "KATAKANA" in char_name): return True
    if choice == "HANGUL" and "HANGUL" in char_name: return True
    if choice == "DEVANAGARI" and "DEVANAGARI" in char_name: return True
    return False

# Get current terminal width dynamically
terminal_width = shutil.get_terminal_size((80, 20)).columns
max_line_len = min(terminal_width - 4, 100)

categories = defaultdict(list)
for codepoint in range(0x110000):
    char = chr(codepoint)
    cat_code = unicodedata.category(char)
    
    # Filter out layout breakers
    if cat_code in ["Cc", "Cf", "Cs", "Co", "Cn"]:
        continue
        
    # Check if character belongs to user-selected language
    if in_selected_script(char, choice):
        categories[cat_code].append(char)

# Structure and print the filtered blocks
type_names = {
    "Lu": "UPPERCASE LETTERS",
    "Ll": "LOWERCASE LETTERS",
    "Lt": "TITLECASE LETTERS",
    "Lm": "MODIFIER LETTERS",
    "Lo": "OTHER LETTERS",
    "Nd": "DECIMAL NUMBERS",
    "Nl": "LETTER-LIKE NUMBERS",
    "No": "OTHER NUMBERS",
    "Pc": "CONNECTOR PUNCTUATION",
    "Pd": "DASH PUNCTUATION",
    "Ps": "OPEN PUNCTUATION",
    "Pe": "CLOSE PUNCTUATION",
    "Pi": "INITIAL PUNCTUATION",
    "Pf": "FINAL PUNCTUATION",
    "Po": "OTHER PUNCTUATION",
    "Sm": "MATH SYMBOLS",
    "Sc": "CURRENCY SYMBOLS",
    "Sk": "MODIFIER SYMBOLS",
    "So": "OTHER SYMBOLS (Symbols & Emojis)",
    "Zs": "SPACE SEPARATORS"
}

printed_any = False
for code, name in type_names.items():
    if code in categories and categories[code]:
        printed_any = True
        print(f"\n=== {name} ({len(categories[code])} chars) ===")
        print("-" * len(name))
        
        current_line = []
        for char in categories[code]:
            current_line.append(char)
            if len(current_line) >= max_line_len:
                print(" ".join(current_line))
                current_line = []
        if current_line:
            print(" ".join(current_line))

if not printed_any:
    print("No characters found for this specific configuration.")
'

