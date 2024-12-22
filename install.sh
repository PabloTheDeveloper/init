#!/bin/bash
# -------------------------------------------------------------------------------
# Check for Prerequisites
# -------------------------------------------------------------------------------
# TODO: Ensure Debian 12 (bookworm) is used.
# I've only verified it on this distro on WSL2
# Check your debian version through this command: cat /etc/os-release
# -------------------------------------------------------------------------------
#  Installing Base Packages
# -------------------------------------------------------------------------------
echo "The installer for Init-Me is being run!"
echo "We need to start at the \$HOME directory so we'll cd to that."
cd $HOME
echo "current directory: $PWD"

echo "Now we're updating some packages.."
sudo apt update

echo "installing: git, gh"

sudo apt install \
	git \
	gh

echo "Now we're configuring gh and git..."

# -------------------------------------------------------------------------------
# Setting Git Configs
# -------------------------------------------------------------------------------
read -p "Email: (defaults to my @noreply.github.com email address)" email
email=${email:-"30012721+PabloTheDeveloper@users.noreply.github.com"}
git config --global user.email "$email"

read -p "Enter username (defaults to PabloTheDeveloper)" username
username=${username:-"PabloTheDeveloper"}
git config --global user.name "$username"

gh config set editor vim
# -------------------------------------------------------------------------------
# Setting up SSH & cloning Init-Me 
# -------------------------------------------------------------------------------
echo "Init-Me will generate github projects so we'll need to set up ssh." 
ssh-keygen -t ed25519 -C "$email"
eval "$(ssh-agent -s)"
gh ssh-key add ~/.ssh/id_ed25519.pub --type signing


read -p "Enter GH_TOKEN:" gh_token
export GH_TOKEN="$gh_token"
gh auth login

echo "Now we're importing the Init-Me project from github."
if [ -d "$HOME/init-me" ]; then
	echo "Init-Me was already imported so skipping that"
else
	gh repo clone PabloTheDeveloper/init-me
fi
# -------------------------------------------------------------------------------
# Installing Docker
# -------------------------------------------------------------------------------
echo "Now we install Docker to run our development environments."
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
rm get-docker.sh # No need for the file anymore

echo "We'll now setup rootless mode. Docker requires a unix socket connection."
echo "The root user owns the unix socket. Rather than using sudo all the time "
echo "for docker commands, rootless mode will allow us to skip that."
echo "See https://docs.docker.com/engine/security/rootless/#known-limitations"
echo "for more details. The key takeaway? Don't use in production."
echo "We need a few more packages to make this work... Installing now."
# taken from above link shamlessly.
sudo apt-get install -y uidmap
sudo apt-get install -y dbus-user-session
sudo apt-get install -y slirp4netns

# TODO:Make sure that: sudo grep ^$(whoami): /etc/subuid
# Has the form: <user>:<some number>:65536
echo "There are technical limitations with this approach. Be wary."
dockerd-rootless-setuptool.sh install

echo "Adding two environment variables to ~/bashrc"
touch ~/.bashrc
"export PATH=/usr/bin:$PATH" \
"export DOCKER_HOST=unix:///run/user/1000/docker.sock" > ~/.bashrc
# -------------------------------------------------------------------------------
# Build Init-Me & Add To Path
# -------------------------------------------------------------------------------

