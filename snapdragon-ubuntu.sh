# makes git config the first
git config --global init.defaultBranch main

sudo apt-get install fonts-font-awesome fish less
# switches shell to fish
chsh -s $(which fish)

sudo apt-get copyq
# Startup copyq on each laptop startup.
# install i3blocks pre-req
sudo apt-get install autoconf
# install i3blocks from
# source (apt is broken)
cd
git clone https://github.com/vivien/i3blocks
cd i3blocks
./autogen.sh
./configure
make
make install
# install disk_usage pre-req (o.g
# python)
sudo apt-get install python-is-python3

# A better cat
sudo apt-get install batcat

# To install fonts & icons...
# Taken from: https://gist.github.com/matthewjberger/7dd7e079f282f8138a9dc3b045ebefa0
# #/bin/bash
# install DroidSansMono Nerd Font --> u can choose another at: https://www.nerdfonts.com/font-downloads
echo "[-] Download fonts [-]"
echo "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/DroidSansMono.zip"
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/DroidSansMono.zip
unzip DroidSansMono.zip -d ~/.fonts
fc-cache -fv
echo "done!"

# installing tmux
sudo apt-get install tmux


