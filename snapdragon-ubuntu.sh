sudo apt-get install fonts-font-awesome fish less
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
