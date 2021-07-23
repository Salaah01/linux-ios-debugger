#!/usr/bin/bash
port=$1

usage() {
  echo "Usage ${0} [-p]" >&2
  echo 'Prepares for a iOS Web Debugging Session.' >&2
  echo '  -p  PORT    Port to liten on.' >&2
  exit 1
}

while getopts p:h OPTION; do
  case ${OPTION} in
  p)
    port="${OPTARG}"
    ;;
  h)
    usage
    ;;
  ?)
    usage
    ;;
  esac
done

if [[ -z "${port}" ]]; then
  port=9000
fi

read -n 1 -rsp $'\033[92mPlease connect your iOS device and press any key to continue...\033[0m\n'
idevicepair pair

read -n 1 -rsp $'\033[92mPlease confirm that you want to trust the device on your iOS device and press any key to continue...\033[0m\n'

remotedebug_ios_webkit_adapter --port=$port
