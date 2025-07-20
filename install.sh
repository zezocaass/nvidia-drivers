#!/bin/bash

set -e

#Check for root privileges
echo "==> Checking for root privileges..."
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root."
    exit 1
fi

#Check if an NVIDIA GPU is present
echo "==> Checking for NVIDIA GPU..."
if ! lspci | grep -i nvidia &> /dev/null; then
    echo "No NVIDIA GPU detected. Aborting."
    exit 1
fi

#Check if the NVIDIA driver is already installed
echo "==> Checking if NVIDIA driver is already installed..."
if command -v nvidia-smi &> /dev/null; then
    echo "NVIDIA driver is already installed:"
    nvidia-smi
    exit 0
fi

# Backup the current sources.list in case changes need to be reverted
echo "==> Creating backup of /etc/apt/sources.list..."
cp /etc/apt/sources.list /etc/apt/sources.list.bak

#Update sources.list to enable contrib, non-free, and non-free-firmware repositories
echo "==> Updating APT sources to enable contrib, non-free, and non-free-firmware..."
sed -i "/^deb http.*main/ s/main.*/main contrib non-free non-free-firmware/" /etc/apt/sources.list

echo "==> Updating APT package index..."
apt update

echo "==> Installing required packages..."
apt install -y linux-headers-$(uname -r) build-essential dkms

echo "==> Installing NVIDIA driver and firmware..."
apt install -y nvidia-driver firmware-misc-nonfree

echo "Installation complete. Please reboot your system."
