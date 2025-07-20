🖥️ NVIDIA Driver Installer Script (Debian 12)

This is a simple and effective shell script to automate the installation of proprietary NVIDIA drivers on a fresh Debian 12 (Bookworm) system.

✅ Features

  - Adds "contrib", "non-free" and "non-free-firmware" to APT sources
  - Updates APT package lists
  - Installs required build tools and kernel headers
  - Installs the official NVIDIA driver via APT
  - Installs firmware for NVIDIA GPUs

⚙️ Requirements

  - Debian 12 (Bookworm)
  - Root permissions
  - Supported NVIDIA GPU 

🚀 How to Use

1- Clone the repository
```
git clone https://github.com/zezocaass/nvidia-drivers.git
```

2- Change directory
```
cd nvidia-drivers
```
3- Run the script with root permissions
```
sudo ./install.sh
```
4- Reboot the system
```
sudo reboot
```
