#!/bin/bash


ROOT=$PWD
APP_TYPE=$1

# app.sh
bash scripts/app.sh

hover run # --observatory-port=$HOVER_PORT # --omit-embedder

# if [ "$1" = "install_linux" ]; then
#     sudo apt install golang-go
#     GO111MODULE=on go get -u -a github.com/go-flutter-desktop/hover
#     export PATH=$PATH:$HOME/go/bin
#     sudo apt-get install libgl1-mesa-dev
#     sudo apt-get install xorg-dev

#     # video_player support
#     # https://linuxconfig.org/ubuntu-20-04-ffmpeg-installation
#     sudo apt install ffmpeg

#     echo $(hover version)
#     echo $(go version)

#     exit $?
# fi

# if [ "$1" = "install_mac" ]; then
#     brew install golang
#     GO111MODULE=on go get -u -a github.com/go-flutter-desktop/hover
    
#     # don't remember add line below to .bashrc
#     export PATH=$PATH:$HOME/go/bin

#     echo $(hover version)
#     echo $(go version)

#     exit $?
# fi

# echo "./start.sh COMMAND
#         run             - run app
#         install_linux   - install go and hover on ubuntu
# "
