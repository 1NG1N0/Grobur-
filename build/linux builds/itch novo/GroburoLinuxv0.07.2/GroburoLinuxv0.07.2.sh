#!/bin/sh
echo -ne '\033c\033]0;Groburo\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/GroburoLinuxv0.07.2.x86_64" "$@"
