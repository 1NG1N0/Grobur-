#!/bin/sh
echo -ne '\033c\033]0;Groburo\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/Groburo0.06.2.x86_64" "$@"
