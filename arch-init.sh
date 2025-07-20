#!/bin/bash
# -------------------------------------------------------------------------------
# Check for Prerequisites
# -------------------------------------------------------------------------------
# Verified on Arch Linux 202504
# -------------------------------------------------------------------------------
#  Installing Base Packages
# -------------------------------------------------------------------------------
echo "The installer for Init-Me is being run!"
echo "We need to start at the \$HOME directory so we'll cd to that."
cd $HOME
echo "current directory: $PWD"

echo "Now we're installing required packages for some typical apps."
sudo pacman -Sy
# Need foot, a terminal emulator specialized for wayland.
# Need kanshi for monitor management.
# Swaylock as a login screen w/ i3blocks as a status bar.
# git & base-devel are requirements to yay.
# openssh for ssh connections.
# github cli to use github in the terminal.
# acpi for power tracking which allows usage of the status bar.
# wlsunset for nightshift mode.
# desktop-file-utils can tell us if a desktop file is
# built correctly.
sudo pacman -S sway foot kanshi swaylock i3blocks base-devel git openssh github-cli acpi wlsunset desktop-file-utils
# Installing AUR package manager.
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..
rm -rf yay

# Installing browser.
yay -S brave-browser

timedatectl set-ntp true

# Get fast mirrors.
sudo pacman -S reflector
sudo reflector --country US --latest 5 --save /etc/pacman.d/mirrorlist --sort rate --verbose

# Intel specific packages.
sudo pacman -S intel-ucode
sudo pacman -S mesa vulkan-intel 

# Remove unused blocks weekly for SSID access improvements.
sudo systemctl enable fstrim.timer

# clone config repo.
gh repo clone PabloTheDeveloper/carbon

# copy contents over.
# (sets up brave on wayland as well.)
cp -R carbon/. ./

echo "Installing packages to setup audio. It will work after restarting."
# https://wiki.archlinux.org/title/PipeWire for details.
# installing the below and rebooting works though.
sudo pacman -S pipewire pipewire-docs wireplumber pipewire-audio sof-firmware pipewire-pulse pavucontrol
# -------------------------------------------------------------------------------
#  Installing Base Packages
# -------------------------------------------------------------------------------
source ~/.bashrc

echo "We require installing a text editor. Select one from the below options."

while true; do
	echo "Choose an option:"
	echo "1. Vim"
	echo "2. Emacs"
	echo "3. Nano"
  echo "4. NeoVim"
	echo "5. Quit."
	read -p "Enter your choice (1,2,3,4): " editor
case "$editor" in
	"1")
		sudo pacman -S vim
    break
	;;
	"2")
		sudo pacman -S emacs
    break
	;;
	"3")
		sudo pacman -S nano
    break
	;;
	"4")
		sudo pacman -S neovim
    break
	;;
	"5")
		exit	
	;;
	*)
	echo "Invalid choice. Please try again."
	;;
esac
done

echo "Installed preferred text editor!"
while true; do
	read -p "It is required to have a Github account for this next step.\nIn the future other VCSs could be picked but for now it's required. Do you have it? (yes, no): " response

	if [[ "$response" == "yes" ]]; then
		echo "Awesome, this will continue."
		break
	elif [[ "$response" == "no" ]]; then
		echo "This script requires it so it will exit here. Feel free to use your preferred text editor to update it."
		exit 0; # exit 0 means program terminated successfully.
	else
		echo "Invalid choice. Please try again."
	fi
done

echo "This programmed was continued!"
echo "Now we're configuring Github and Git. Make sure to auth through browser for github setup."
echo "Since this is the first script to run after setting arch, we need to install a browser."
echo "Installing Brave Browser by first installing the yay AUR package manager and brave from that."
echo "Installing first some requirements for yay."
# -------------------------------------------------------------------------------
# Setting Git Configs
# -------------------------------------------------------------------------------
read -p "Enter Git Email (defaults to my @noreply.github.com email address):" email
email=${email:-"30012721+PabloTheDeveloper@users.noreply.github.com"}
git config --global user.email "$email"

read -p "Enter Username (defaults to PabloTheDeveloper):" username
username=${username:-"PabloTheDeveloper"}
git config --global user.name "$username"

gh config set editor $editor
# -------------------------------------------------------------------------------
# Setting up SSH & cloning Init-Me 
# -------------------------------------------------------------------------------
echo "Init-Me will generate github projects so we'll need to set up ssh."
echo "Creates a private key & public key."
echo "Installing some required packages first."

ssh-keygen -t ed25519 -C "$email"
eval "$(ssh-agent -s)"

gh config set git_protocol ssha
echo "Now we'll upload our public ssh key."
gh auth login --git-protocol ssh 
echo "Now we're importing the Init-Me project from github into the HOME/repos directory (will create if not there)"
if [ -d "$HOME/repos/init-me" ]; then
	echo "Init-Me was already imported so skipping that"
else
  mkdir -p $HOME/repos
  cd $HOME/repos
	gh repo clone git@github.com:PabloTheDeveloper/init-me.git
fi
