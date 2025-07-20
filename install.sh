#!/bin/bash

set -e

echo "==> Checking for root privileges..."
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root."
    exit 1
fi

echo "==> Checking for NVIDIA GPU..."
if ! lspci | grep -i nvidia &> /dev/null; then
    echo "No NVIDIA GPU detected. Aborting."
    exit 1
fi

echo "==> Updating APT sources to enable contrib, non-free, and non-free-firmware..."
sed -i "/^deb http.*main/ s/main.*/main contrib non-free non-free-firmware/" /etc/apt/sources.list

echo "==> Updating APT package index..."
apt update

echo "==> Installing required packages..."
apt install -y linux-headers-$(uname -r) build-essential dkms

echo "==> Installing NVIDIA driver and firmware..."
apt install -y nvidia-driver firmware-misc-nonfree

echo "Installation complete. Please reboot your system."
