# prep4pwn.sh

**prep4pwn.sh** is a Kali Linux setup script for quickly getting a fresh attack VM ready for offensive operations.  
Whether you're popping shells or pivoting through networks, this script gives you a strong baseline with essential tools and config tweaks.

## 🔧 Features

- System update / full-upgrade
- Clone and run [PimpMyKali](https://github.com/Dewalt-arch/pimpmykali)
- Install [Ligolo-ng](https://github.com/nicocha30/ligolo-ng) (Linux & Windows binaries) for pivoting and tunneling
- Install Brave Browser (for web-based recon and testing)
- Install Kali legacy wallpaper pack
- Set a custom login screen background

## 🚀 Usage

```bash
chmod +x prep4pwn.sh
./prep4pwn.sh

Follow the interactive menu to select what you want to install/configure.

🔐 Sudo password will be requested at the start. Needed for installs and system changes.

📂 Ligolo-ng Setup
Ligolo-ng components are downloaded to:

bash
Copy
Edit
~/ligolo-ng
Includes both agent and proxy for Linux and Windows (v0.7.5). Archives are cleaned up post-install.
More info on Ligolo-ng: https://github.com/nicocha30/ligolo-ng

🖼️ Custom Login Background
The script validates your image path and format. Supported formats:

.png, .jpg, .jpeg, .bmp, .webp

The selected image will replace the default Kali login background via symbolic link.

⚙️ Requirements
Kali Linux (tested on 2024.1+)

Internet connection

curl, unzip, tar, and other basic GNU tools

💣 Notes
Designed for VirtualBox or fresh local installs

You can run this script multiple times; it will not duplicate actions

Ideal for red teamers, CTFers, and offensive security labs
