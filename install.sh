#!/usr/bin/bash

set -e

on_exit() {
    [[ $? == 0 ]] || echo -e "\033[91mExiting due to an error.\033[0m"
}

trap on_exit EXIT

echo ROOT_DIR=$(mktemp -d -t linux-ios-debugger-XXXXXXXXXXXX)
mkdir -p $ROOT_DIR
cd $ROOT_DIR

echo -e "\033[93mInstalling Dependencies\033[0m"

echo -e "\033[93mInstalling libplist\033[0m"
apt install -y \
    build-essential \
    checkinstall \
    git \
    autoconf \
    automake \
    libtool-bin \
    doxygen \
    cython

git clone https://github.com/libimobiledevice/libplist.git
cd libplist
./autogen.sh

make

make install

echo -e "\033[93mInstalling libusbmuxd\033[0m"
cd ..
apt install -y \
    libplist-dev \
    usbmuxd
git clone https://github.com/libimobiledevice/libusbmuxd.git
cd libusbmuxd
./autogen.sh

make

make install

echo -e "\033[93mInstalling libimobiledevice\033[0m"
cd ..
apt install -y \
    libusbmuxd-dev \
    libssl-dev
git clone https://github.com/libimobiledevice/libimobiledevice.git
cd libimobiledevice
./autogen.sh

make

make install

echo -e "\033[93mInstalling usbmuxd\033[0m"
cd ..
apt install -y \
    libimobiledevice-dev \
    libusb-1.0-0-dev \
    udev \
    systemd
git clone https://github.com/libimobiledevice/usbmuxd.git
cd usbmuxd
./autogen.sh

make

make install

echo -e "\033[93mInstalling ios-webkit-debug-proxy\033[0m"

cd ..
apt install -y \
    autoconf \
    automake \
    libusb-dev \
    libusb-1.0-0-dev \
    libplist-dev \
    libtool \
    libssl-dev
git clone https://github.com/google/ios-webkit-debug-proxy.git
cd ios-webkit-debug-proxy

./autogen.sh

make

make install

ldconfig

echo -e "\033[93mInstalling remotedebug-ios-webkit-adapter\033[0m"
npm install remotedebug-ios-webkit-adapter -g

# Clean up
rm -rf $ROOT_DIR
