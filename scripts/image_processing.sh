#!/bin/bash

# pass in a path to work the magic
# e.g. ./cmd.sh public/images/maps/eichenwalde/
# assumes you put all the pngs in there already
FILE_PATH="$1"

# Check if an argument was actually passed
if [ -z "$FILE_PATH" ]; then
    echo "Error: No file path provided."
    echo "Usage: $0 <path_to_file>"
    exit 1
fi

# Convert all pngs to webps
for file in "$FILE_PATH"*.png; do cwebp -q 80 "$file" -o "${file%.*}.webp"; done

# Resize all webps to 1920x1080 (if is smaller, it will not be touched)
find "$FILE_PATH"* -type f -iwholename "$FILE_PATH*.webp" -exec convert {} -resize '1920x1080>' {} \;

# Examine resolutions of the webps
identify -format "%wx%h\n" "$FILE_PATH"*.webp

# cleanup
rm "$FILE_PATH"*.png
