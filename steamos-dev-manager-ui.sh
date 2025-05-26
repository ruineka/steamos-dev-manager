#!/bin/bash

# SteamOS Dev Management scripts by Matthew Anderson

# Set root password

# Setup SSH

# Update InputPlumber

# Search available kernels

# Install kernel version

# Apply SteamOS-Manager Updates

# Gather all useful logs

while true; do
    CHOICE=$(zenity --list --title="Options menu" \
        --column="Commands" \
        "Set Root Password" \
        "Disable Readonly Mode" \
        "Setup SSH" \
        "Update InputPlumber" \
        "Search Available Kernels" \
        "Install Kernel Version" \
        "Apply SteamOS-Manager Patches" \
        "Grab Logs" \
        --height=400 --width=300)
    if [ $? -ne 0 ]; then
        break
    fi

    case $CHOICE in
        "Set Root Password")
            passwd
            ;;
        "Setup SSH")
            ssh-keygen
            ;;
        "Disable Readonly Mode")
            sudo steamos-readonly disable
            ;;
        "Update InputPlumber")
            # Search for the latest version, extract the package files to the required locations
            wget https://github.com/ShadowBlip/InputPlumber/releases/download/v0.58.1/inputplumber-aarch64.tar.gz
            ;;
        "Search Available Kernels")
            # Search and filter by date here: https://steamdeck-packages.steamos.cloud/archlinux-mirror/jupiter-main/os/x86_64/linux-neptune-611-6.11.11.valve15-1-x86_64.pkg.tar.zst
            ;;
        "Install Kernel Version")
            # Download target kernel version and install the package
            # sudo pacman -U https://steamdeck-packages.steamos.cloud/archlinux-mirror/jupiter-main/os/x86_64/linux-neptune-611-6.11.11.valve15-1-x86_64.pkg.tar.zst
            # sudo update-grub
            ;;
        "Apply SteamOS-Manager Patches")
            # Grab and download Matte-Schwartz changes here https://github.com/matte-schwartz/steamos-manager/tree/staging-next
            ;;
        "Grab Logs")
            # dmesg, journalctl, inputplumber, etc
            ;;
        *)
            zenity --error --text="Invalid option, please try again."
            ;;
    esac
done
