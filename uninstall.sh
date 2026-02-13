#!/bin/bash

# Enhanced Uninstall script for Sanuu Command Tool

SCRIPT_NAME="sanuu"
INSTALL_DIRS=("/usr/local/bin" "/usr/bin" "/bin" "$HOME/.local/bin")

# ASCII Art
print_ascii() {
    echo -e "\033[0;31m"
    echo "  ___  __ _ _ __  _   _ _   _ "
    echo " / __|/ _\` | '_ \| | | | | | |"
    echo " \__ \ (_| | | | | |_| | |_| |"
    echo " |___/\__,_|_| |_|\__,_|\__,_|"
    echo -e "\033[0m"
    echo -e "\033[1;35m   >> Sanuu Command Tool Uninstaller << \033[0m"
    echo ""
}

print_ascii

# Function to check for sudo
check_sudo() {
    if [[ $EUID -ne 0 ]]; then
        echo -e "\033[1;33m[NOTE] This script requires root privileges to remove system-wide files.\033[0m"
        sudo -v
        if [[ $? -ne 0 ]]; then
            echo -e "\033[0;31m[ERROR] Sudo privileges are required. Exiting.\033[0m"
            exit 1
        fi
    fi
}

echo -e "\033[1;34m[INFO] Checking permissions...\033[0m"
check_sudo

echo -e "\033[1;34m[INFO] Searching for installations of $SCRIPT_NAME...\033[0m"

FOUND=0

for DIR in "${INSTALL_DIRS[@]}"; do
    FILE="$DIR/$SCRIPT_NAME"
    if [[ -f "$FILE" ]]; then
        echo -e "\033[1;33m[FOUND] Removing $FILE...\033[0m"
        if [[ "$DIR" == "$HOME/.local/bin" ]]; then
             rm "$FILE"
        else
             sudo rm "$FILE"
        fi
        
        if [[ $? -eq 0 ]]; then
             echo -e "\033[0;32m[REMOVED] $FILE\033[0m"
             FOUND=1
        else
             echo -e "\033[0;31m[FAILED] Could not remove $FILE\033[0m"
        fi
    fi
done

if [[ $FOUND -eq 0 ]]; then
    echo -e "\033[1;33m[INFO] No installation found in standard paths.\033[0m"
    # Check if accessible via PATH
    if command -v "$SCRIPT_NAME" &> /dev/null; then
        LOC=$(command -v "$SCRIPT_NAME")
        echo -e "\033[1;31m[WARN] however, '$SCRIPT_NAME' is still in your PATH at: $LOC\033[0m"
        read -p "Do you want to force remove this file? (y/n): " choice
        if [[ "$choice" == "y" || "$choice" == "Y" ]]; then
            sudo rm "$LOC"
            echo -e "\033[0;32m[REMOVED] $LOC\033[0m"
        fi
    fi
else
    echo -e "\033[0;32m[SUCCESS] Uninstallation complete.\033[0m"
fi
