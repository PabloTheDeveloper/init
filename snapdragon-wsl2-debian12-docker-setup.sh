#!/bin/bash
# -------------------------------------------------------------------------------
# Check for Prerequisites
# -------------------------------------------------------------------------------
# Verified on Debian 12 (bookworm). Can't say about other versions.
# Check your debian version through this command: cat /etc/os-release
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
"export PATH=/usr/bin:$PATH" > ~/.bashrc
"export DOCKER_HOST=unix:///run/user/1000/docker.sock" > ~/.bashrc

