#!/bin/sh
echo -ne '\033c\033]0;Platform\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/dashdemon.x86_64" "$@"
