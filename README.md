# init-me
init-me installs all needed packages for a frictionless development environment. Customized for me if ever I need to switch to another laptop or machine.

# Development Roadmap
1. Setup BATS to test bash script (using bash since most distro have it by default).
    * [x] Need to install basic packages (vim, git, gh, sway)
    * [x] Need to run basic configuration for those packages (git.configs)
    * [ ] Need to setup basic vimrc so I can edit these install scripts more easily.
    * [ ] Setup docker configuration for golang dev environment (w/ vim scripts)

# Quickstart

## Step 1: Download and execute the bash script
Either:
```
curl -s https://raw.githubusercontent.com/PabloTheDeveloper/init-me/main/install.sh | bash
```
Or just copy and run the following script:
```
#!/bin/bash

echo "The installer for Init-Me is being run!"
echo "We need to start at the \$HOME directory so we'll cd to that."
cd $HOME
echo "current directory: $PWD"

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

```

