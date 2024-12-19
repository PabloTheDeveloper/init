#!/bin/bash

echo "Init-Me is being run!"
echo "We need to start at the \$HOME directory so we'll cd to that."
cd $HOME

echo "Now we're installing a few packages..."
sudo apt update

sudo apt install \
	vim \
	git \
	gh  \
	curl

#TODO(pablothedeveloper): Check that these packages are actually installed...

echo "Now we're configuring qgh and git...(under construction)"
# imports file to call function which sets the github token.

source $HOME/init-me/lib.sh

set_gh_token_env
# I will see if I can recall them.
# gh auth login # This logs me into github
# TODO(pablothedeveloper): figure out how to add user input
# Navigates gh auth login screen
#echo "\n\nY\n" # this should be an enter keypress 
#echo "\033\n" # down arrow
#read code
#echo "$code\n"

# 
git config --global user.email "pablothedeveloper@gmail.com"
git config --global user.name "pablothedeveloper"

# TODO(pablothedeveloper): This todo is for lots of things.
# 1. I should have a style enforcer on the bash I'm writing. For now, I'll live with wrapped text.
# 2. I should make the history command persist beyond a terminal session.
# 3. I should setup bats to test this bash script.
# 4. Init-Me should actually be done in go or python. I should use bash to install the basics to get me started but nothing after that. Or.. maybe not? I feel that there isn't much to install, that I will need to install here since my plan is to use docker containers to host development environments. Each one of those should have some way of installing their dependent packages. I'm still uncertain of how the vim ecosystem is ... but last time I used it, I used it with zsh and vim-plug. I could use the same. For that, I'd need .zsh in the containers. I could have just one massive vimrc file but I *feel* that is wrong. It will continue to have ever increasing complexity if I do that. It will become foreign to me and not useful for other people. Simple, precise, configurations is what I'm aiming for here. Not just for other people but for myself at later times (which can be considered as other people in a way)

echo "Now we're importing the Init-Me project from github"
if [ -d "$HOME/init-me" ]; then
	echo "Init-Me was already imported so skipping that"
else
	gh repo clone PabloTheDeveloper/init-me
fi

# TODO(pablothedeveloper): installing docker might be tricky (in that there's not one simple command).
# https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository
