#!/bin/bash

# author: Kanav Bhardwaj

# It installs the git config files by creating symlinks at the user level ~/
# Takes an optional parameter to specify the destination of install

windows() { false; }
echo ""
# Check operating system
if windows; then
    src=$(cygpath -w "$(dirname "$0")")
    dest=$(cygpath -w "${1:-"$HOME"}")
    echo "Windows detected"
else
    src=$(realpath "$(dirname "$0")")
    dest=$(realpath "${1:-"$HOME"}")
    echo "Linux detected"
fi
echo ""
shopt -s dotglob
for filepath in "$src"/*.gitconfig; do
    filename=$(basename "$filepath")
    echo "Copying ${filename}"
    if windows; then
        if [ ! -e "${dest%/}/${filename}" ]; then
            if ! cmd <<< "mklink \"${dest%/}/${filename}\" \"${src%/}/${filename}\"" > /dev/null; then
                echo " Error: Failed to create symlink for ${filename}"
                exit 1
            fi
        else
            echo " Skipping ${filename} as symlink already exists in ${dest}"
        fi
    else
        if [ ! -e "${dest}/${filename}" ]; then
            if ! ln -s "${src}/${filename}" "${dest}/${filename}"; then
                echo " Error: Failed to create symlink for ${filename}"
                exit 1
            fi
        else
            echo " Skipping ${filename} as symlink already exists in ${dest}"
        fi
    fi
done
shopt -u dotglob

echo ""
echo "Installation completed!"
