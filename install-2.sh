#!/bin/bash
# -------------------------------------------------------------------------------
# Check for Prerequisites
# -------------------------------------------------------------------------------
# TODO: Ensure Debian 12 is used.
# On WSL 2 this is known through the command 
# -------------------------------------------------------------------------------
#  Installing Github & Git
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

read -p "Enter GH_TOKEN:" gh_token
export GH_TOKEN="$gh_token"
# -------------------------------------------------------------------------------
# Installing Init-Me Project
# -------------------------------------------------------------------------------
read -p "Enter email (defaults to pablothedeveloper@gmail.com)" email
email=${email:-"pablothedeveloper@gmail.com"}
git config --global user.email "$email"

read -p "Enter username (defaults to pablothedeveloper@gmail.com)" username
username=${username:-"pablothedeveloper"}
git config --global user.name "$username"

echo "Now we're importing the Init-Me project from github."
if [ -d "$HOME/init-me" ]; then
	echo "Init-Me was already imported so skipping that"
else
	gh repo clone PabloTheDeveloper/init-me
fi

# -------------------------------------------------------------------------------
# Installing Docker
# -------------------------------------------------------------------------------
echo "Now we install Docker to run our development environments in."
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
rm get-docker.sh # No need for the file anymore

echo "We'll now setup rootless mode. Docker requires a unix socket connection."
echo "The root user owns the unix socket. Rather than using sudo all the time "
echo "for docker commands, rootless mode will allow us to skip that."
echo "See https://docs.docker.com/engine/security/rootless/#known-limitations"
echo "for more details. The key takeaway? Don't use in production."
echo "We need a few more packages ot make this work... Installing now."
# taken from above link shamlessly.
sudo apt install uidmap
sudo apt-get install -y dbus-user-session
# -------------------------------------------------------------------------------
# Build Init-Me & Add To Path
# -------------------------------------------------------------------------------
