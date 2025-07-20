#!/bin/bash
# -------------------------------------------------------------------------------
# Check for Prerequisites
# -------------------------------------------------------------------------------
# Verified on Debian 12 (bookworm). Can't say about other versions.
# Check your debian version through this command: cat /etc/os-release
# -------------------------------------------------------------------------------
#  Installing Base Packages
# -------------------------------------------------------------------------------
echo "The installer for Init-Me is being run!"
echo "We need to start at the \$HOME directory so we'll cd to that."
cd $HOME
echo "current directory: $PWD"

echo "Now we're updating some packages."
sudo apt update

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
		sudo apt install vim
    break
	;;
	"2")
		sudo apt install emacs
    break
	;;
	"3")
		sudo apt install nano
    break
	;;
	"4")
		sudo apt install neovim
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
echo "Now installing: git, gh."
while true; do
	read -p "It is required to have a Github account for this next step.\nIn the future other VCSs could be picked but for now it's required. Do you have it? (yes, no): " have_git_github 
case "$have_git_github" in
	"yes")
		echo "Awesome, this will continue."
	break
	;;
	"no")
		echo "This script requires it so it will exit here. Feel free to use your preferred text editor to update it."
		exit 0; # exit 0 means program terminated successfully.
	break;
	;;
	*)
		echo "Invalid choice. Please try again."
	''
esac
done

sudo apt install \
	git \
	gh

echo "This programmed was continued!"
echo "Now we're configuring Github and Git. Make sure to auth through browser for github setup."

# -------------------------------------------------------------------------------
# Setting Git Configs
# -------------------------------------------------------------------------------
read -p "Enter Git Email (defaults to my @noreply.github.com email address):" email
email=${email:-"30012721+pablothedeveloper@users.noreply.github.com"}
git config --global user.email "$email"

read -p "Enter Username (defaults to pablothedeveloper):" username
username=${username:-"pablothedeveloper"}
git config --global user.name "$username"

gh config set editor $editor
# -------------------------------------------------------------------------------
# Setting up SSH & cloning Init-Me 
# -------------------------------------------------------------------------------
echo "Init-Me will generate github projects so we'll need to set up ssh."
echo "Creates a private key & public key."
ssh-keygen -t ed25519 -C "$email"
eval "$(ssh-agent -s)"

# read -p "Enter GH_TOKEN:" gh_token
# export GH_TOKEN="$gh_token"
gh config set git_protocol ssha
echo "Now we'll upload our public ssh key. Say yes to all the defaults."
echo "If the browser doesn't start up, use this link in any browser https://github.com/login/device)."
gh auth login --git-protocol ssh 
# TDoesn't: gh ssh-key add ~/.ssh/id_ed25519.pub --type signing
echo "Now we're importing the Init-Me project from github into the HOME/repos directory (will create if not there)"
if [ -d "$HOME/repos/init-me" ]; then
	echo "Init-Me was already imported so skipping that"
else
  mkdir -p $HOME/repos
  cd $HOME/repos
	gh repo clone git@github.com:PabloTheDeveloper/init-me.git
fi

