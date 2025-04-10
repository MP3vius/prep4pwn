#!/bin/bash

# Variables
USER_HOME="/home/${SUDO_USER:-$(whoami)}"
NEW_LINE="\n"
PMK_CLONE="git clone https://github.com/Dewalt-arch/pimpmykali.git $USER_HOME/Downloads/pimpmykali"
PMK_SCRIPT="$USER_HOME/Downloads/pimpmykali/pimpmykali.sh"
LIG_DIR="$USER_HOME/ligolo-ng"

# Prompt for sudo password
read -s -p "Enter your sudo password: " SUDO_PASSWORD

# Greeting screen
printf $NEW_LINE
echo -e "|----------------------------------------------------------------------------------------------------------|"
echo -e "|                                                                                                          |"
echo -e "| Hello there, welcome to the pentest kali virtual box prep script!                                        |"
echo -e "| This script was made to simplify the process of setting up a new kali pentest attack box.                |"   
echo -e "| It combines a few of the processes together, so that you don't have to worry about forgetting something. |"
echo -e "| Happy hacking!                                                                                           |"
echo -e "|                                                                                                          |"
echo -e "|----------------------------------------------------------------------------------------------------------|"
echo -e "                                                                                          ~ Made by MP3vius"
printf "$NEW_LINE%.0s" {1..10}

# Options
echo -e "Available options:"
echo -e "\t1) Regular update and upgrade"
echo -e "\t2) Full update and upgrade"
echo -e "\t3) Clone PimpMyKali repo to Downloads folder"
printf $NEW_LINE
echo -e "\t4) Option 1 & 3"
echo -e "\t5) Option 2 & 3"
printf $NEW_LINE
echo -e "\t6) Exit."
echo -e "\t7) Continue for additional options..."

read -p "Select one of the options: " opt

case $opt in
    "1") echo "$SUDO_PASSWORD" | sudo -S apt update && sudo -S apt upgrade -y ;;
    "2") echo "$SUDO_PASSWORD" | sudo -S apt update && sudo -S apt full-upgrade -y ;;
    "3") echo "$SUDO_PASSWORD" | sudo -S bash -c "$PMK_CLONE" ;;
    "4") echo "$SUDO_PASSWORD" | sudo -S apt update && sudo -S apt upgrade -y && echo "$SUDO_PASSWORD" | sudo -S bash -c "$PMK_CLONE" ;;
    "5") echo "$SUDO_PASSWORD" | sudo -S apt update && sudo -S apt full-upgrade -y && echo "$SUDO_PASSWORD" | sudo -S bash -c "$PMK_CLONE" ;;
    "6") exit 0 ;;
    "7") echo "continue..." && printf $NEW_LINE ;;
esac

# Loop through additional options
while true; do
    printf $NEW_LINE
    echo -e "Additional options:"
    echo -e "\t1) Run PimpMyKali's 'NEW VM SETUP' option"
    echo -e "\t2) Install ligolo-ng (pivot tool)"
    echo -e "\t3) Install brave browser"
    echo -e "\t4) Install kali legacy wallpaper pack"
    echo -e "\t5) Change login screen background"
    printf $NEW_LINE
    echo -e "\t6) Exit.\n"

    read -p "Select one of the options: " opt2

    case $opt2 in
        "1") 
            echo -e "Running PimpMyKali script..."
            echo "$SUDO_PASSWORD" | echo -e "Ny\n" | sudo -S bash "$PMK_SCRIPT"
            ;;
        "2") 
            echo -e "Installing Ligolo-ng..."

            mkdir -p "$LIG_DIR"

            LIG_FILES=(
                "https://github.com/nicocha30/ligolo-ng/releases/download/v0.7.5/ligolo-ng_agent_0.7.5_linux_amd64.tar.gz"
                "https://github.com/nicocha30/ligolo-ng/releases/download/v0.7.5/ligolo-ng_proxy_0.7.5_linux_amd64.tar.gz"
                "https://github.com/nicocha30/ligolo-ng/releases/download/v0.7.5/ligolo-ng_agent_0.7.5_windows_amd64.zip"
                "https://github.com/nicocha30/ligolo-ng/releases/download/v0.7.5/ligolo-ng_proxy_0.7.5_windows_amd64.zip"
            )

            for url in "${LIG_FILES[@]}"; do
                filename=$(basename "$url")
                filepath="$LIG_DIR/$filename"

                echo "Downloading $filename..."
                curl -Ls -o "$filepath" "$url"

                echo "Extracting $filename..."
                if [[ "$filename" == *.tar.gz ]]; then
                    tar -xzf "$filepath" -C "$LIG_DIR"
                elif [[ "$filename" == *.zip ]]; then
                    unzip -q "$filepath" -d "$LIG_DIR"
                fi

                # Clean up unwanted files after each extraction
                rm -f "$LIG_DIR/README.md" "$LIG_DIR/LICENSE"
            done

            # Final cleanup of archive files
            rm -f "$LIG_DIR"/*.zip "$LIG_DIR"/*.tar.gz

            # Set ownership
            echo "$SUDO_PASSWORD" | sudo -S chown -R "$SUDO_USER:$SUDO_USER" "$LIG_DIR"

            echo -e $NEW_LINE
            echo -e "Ligolo-ng installation complete! Files can be found in $LIG_DIR."
            ;;
        "3")
	    echo -e "Installing brave browser"
	    sleep 1
	    printf $NEW_LINE
	    echo "$SUDO_PASSWORD" | sudo -S curl -fsS "https://dl.brave.com/install.sh" | sh 
	    ;;    
        "4")
            echo "$SUDO_PASSWORD" | sudo -S apt install kali-legacy-wallpapers
            ;;
        "5")
            echo -e "Change Kali login screen background"
            read -rp "Please specify the path to the image you want to use on the login screen: " image_path

            # Validate file existence
            if [[ ! -f "$image_path" ]]; then
                echo "Error: File does not exist at specified path."
                continue
            fi

            # Validate image extension (case-insensitive)
            if [[ ! "$image_path" =~ \.(png|jpg|jpeg|bmp|webp)$ ]]; then
                echo "Error: File is not a supported image format (.png, .jpg, .jpeg, .bmp, .webp)."
                continue
            fi

            # Remove existing symlink
            echo "$SUDO_PASSWORD" | sudo -S rm -f /usr/share/desktop-base/kali-theme/login/background

            # Create new symlink
            echo "$SUDO_PASSWORD" | sudo -S ln -s "$image_path" /usr/share/desktop-base/kali-theme/login/background

            printf $NEW_LINE
	    echo "Login screen background successfully updated!"
            sleep 1
	    ;;
	"6")
	    printf $NEW_LINE 
            echo "Exiting setup. Happy hacking!"
	    printf $NEW_LINE
            sleep 0.5
 	    break
            ;; 
	 *) 
            echo "Invalid option. Please try again."
            ;;
    esac
done
