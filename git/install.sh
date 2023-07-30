#!/bin/bash


# author: Kanav Bhardwaj

# It installs the git config files by creating symlinks at user level ~/
# Takes an optional parameter to specify the destination of install

shopt -s dotglob
for filename in *.gitconfig; do
    src="${PWD}/${filename}"
    dest=${1:-~/}
    ln -s ${src} ${dest}
    echo "Copying ${filename}"
done

echo "Installation completed!"
shopt -u dotglob