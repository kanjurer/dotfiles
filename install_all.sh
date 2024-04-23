# author: Kanav Bhardwaj

# It installs all the configs by creating symlinks at user level ~/
# Takes an optional parameter to specify the destination of install

windows() { [[ -n "$WINDIR" ]]; }
echo ""
# Check operating system
if windows; then
    dest=$(cygpath -w "${1:-"$HOME"}")
    echo "Windows detected"
else
    dest=$(realpath "${1:-"$HOME"}")
    echo "Linux detected"
fi

echo "Installing git configuration"
if ! ./git/install.sh $dest; then
    echo "Error: Failed to install git configuration"
    exit 1
fi

echo "Installing linux configuration"
if ! ./linux/install.sh $dest; then
    echo "Error: Failed to install linux configuration"
    exit 1
fi

echo "Successfully installed all the config files. Happy coding!"
