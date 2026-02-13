#!/bin/bash

# Enhanced Install script for Sanuu Command Tool

SCRIPT_NAME="sanuu"
INSTALL_DIR="/usr/local/bin"
USER_BIN_DIR="$HOME/.local/bin"
ACPI_CHOICES="/sys/firmware/acpi/platform_profile_choices"

# ASCII Art
print_ascii() {
    echo -e "\033[0;36m"
    echo "  ___  __ _ _ __  _   _ _   _ "
    echo " / __|/ _\` | '_ \| | | | | | |"
    echo " \__ \ (_| | | | | |_| | |_| |"
    echo " |___/\__,_|_| |_|\__,_|\__,_|"
    echo -e "\033[0m"
    echo -e "\033[1;35m   >> Sanuu Command Tool Installer << \033[0m"
    echo ""
}

print_ascii

# Function to check for sudo
check_sudo() {
    if [[ $EUID -ne 0 ]]; then
        echo -e "\033[1;33m[NOTE] This script requires root privileges to install to $INSTALL_DIR.\033[0m"
        sudo -v
        if [[ $? -ne 0 ]]; then
            echo -e "\033[0;31m[ERROR] Sudo privileges are required. Exiting.\033[0m"
            exit 1
        fi
    fi
}

echo -e "\033[1;34m[INFO] Checking permissions...\033[0m"
check_sudo

echo -e "\033[1;34m[INFO] Installing $SCRIPT_NAME...\033[0m"

# Get current git hash
CURRENT_HASH=$(git rev-parse HEAD 2>/dev/null)
if [[ -z "$CURRENT_HASH" ]]; then
    CURRENT_HASH="manual-install-$(date +%s)"
    echo -e "\033[1;33m[WARN] Could not detect git hash. Using timestamp.\033[0m"
fi

# Prepare temp file with injected hash
TEMP_FILE="/tmp/$SCRIPT_NAME.tmp"
cp "$SCRIPT_NAME" "$TEMP_FILE"
sed -i "s/INSTALLED_HASH=\"Unknown\"/INSTALLED_HASH=\"$CURRENT_HASH\"/" "$TEMP_FILE"

# Copy script with sudo
sudo cp "$TEMP_FILE" "$INSTALL_DIR/$SCRIPT_NAME"
rm "$TEMP_FILE"

# Make executable
sudo chmod +x "$INSTALL_DIR/$SCRIPT_NAME"

# Check for conflict in local bin and warn/remove
if [[ -f "$USER_BIN_DIR/$SCRIPT_NAME" ]]; then
    echo -e "\033[1;33m[WARN] Found existing local installation at $USER_BIN_DIR/$SCRIPT_NAME\033[0m"
    read -p "Do you want to remove the local version to avoid conflicts? (y/n): " choice
    if [[ "$choice" == "y" || "$choice" == "Y" ]]; then
        rm "$USER_BIN_DIR/$SCRIPT_NAME"
        echo -e "\033[0;32m[SUCCESS] Removed local version.\033[0m"
    fi
fi

echo -e "\033[0;32m[SUCCESS] Installation complete!\033[0m"
echo -e "You can now run '\033[1;36m$SCRIPT_NAME\033[0m' from your terminal."
echo ""
echo -e "\033[1;36m[DETECTED PROFILES]\033[0m"
if [[ -f "$ACPI_CHOICES" ]]; then
    PROFILES=$(cat "$ACPI_CHOICES")
    echo "Detected the following supported power profiles on your system:"
    echo -e "\033[0;33m$PROFILES\033[0m"
    echo ""
    echo "You can use these directly as commands:"
    for p in $PROFILES; do
        echo -e "  $ sanuu \033[1;32m$p\033[0m"
    done
else
    echo -e "\033[1;31mNo ACPI platform profiles detected on this system.\033[0m"
fi
echo ""
