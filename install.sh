#!/bin/bash

echo "The installer for Init-Me is being run!"
echo "We need to start at the \$HOME directory so we'll cd to that.\n"
cd $HOME
echo "current directory:$PWD"

echo "Now we're updating some packages.."
sudo apt update

echo "installing: vim, git, gh, curl"

sudo apt install \
	vim \
	git \
	gh  \
	curl

echo "Now we're configuring gh and git..."

read -p "Enter GH_TOKEN:" gh_token
export GH_TOKEN="$gh_token"

read -p "Enter email (defaults to pablothedeveloper@gmail.com)" email
email=${email:-"pablothedeveloper@gmail.com"}

read -p "Enter username (defaults to pablothedeveloper@gmail.com)" username
username=${username:-"pablothedeveloper"}

git config --global user.email "$email"
git config --global user.name "$username"


echo "Now we're importing the Init-Me project from github"
if [ -d "$HOME/init-me" ]; then
	echo "Init-Me was already imported so skipping that"
else
	gh repo clone PabloTheDeveloper/init-me
fi

# TODO: installing docker might be tricky (in that there's not one simple command).
# https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository
