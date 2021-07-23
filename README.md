# Linux iOS Debugger
This program will allow you to run the inspect element tool using the Google Chrome/Chromium browser on your Linux (Debian) machine.

## Installation
1. Install either Google Chrome or Chromium form the software center.
2. Open your iOS, go to **Settings**, navigate to **Safari**, slick on "Advanced" and enable "Web Inspector".
3. Run `./install.sh`
4. Follow the on screen instructions.

## Inspecting Your iOS Device
1. Open the downloaded browser and navigate to `chrome://inspect/#devices`.
2. Run `./start.sh`.
3. You should now be able to see the inspect options which will allow you to open the developer tools on your browser whilst you navigate on your iOS device.

## Credits
This script comes from following compiling the instructions on https://onestepcode.com/debugging-ios-on-linux/ into a single script.
