#!/usr/bin/bash

echo ROOT_DIR="/tmp/linux-ios-debugger/"
mkdir -p $ROOT_DIR
cd $ROOT_DIR

exit_on_error() {
    error=$?
    if [[ $error -ne 0 ]]; then
        echo -e "\033[91mExiting due to an error.\033[0m"
        exit $error
    fi
}

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
exit_on_error

git clone https://github.com/libimobiledevice/libplist.git
cd libplist
./autogen.sh
exit_on_error
make
exit_on_error
make install
exit_on_error

echo -e "\033[93mInstalling libusbmuxd\033[0m"
cd ..
apt install -y \
    libplist-dev \
    usbmuxd
git clone https://github.com/libimobiledevice/libusbmuxd.git
cd libusbmuxd
./autogen.sh
exit_on_error
make
exit_on_error
make install
exit_on_error

echo -e "\033[93mInstalling libimobiledevice\033[0m"
cd ..
apt install -y \
    libusbmuxd-dev \
    libssl-dev
git clone https://github.com/libimobiledevice/libimobiledevice.git
cd libimobiledevice
./autogen.sh
exit_on_error
make
exit_on_error
make install
exit_on_error

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
exit_on_error
make
exit_on_error
make install
exit_on_error

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
exit_on_error
./autogen.sh
exit_on_error
make
exit_on_error
make install

ldconfig

echo -e "\033[93mInstalling remotedebug-ios-webkit-adapter\033[0m"
npm install remotedebug-ios-webkit-adapter -g

read -n 1 -rsp $'\033[92mPlease connect your iOS device and press any key to continue...\033[0m\n'
idevicepair pair

read -n 1 -rsp $'\033[92mPlease confirm that you want to trust the device on your iOS device and press any key to continue...\033[0m\n'
