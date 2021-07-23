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
