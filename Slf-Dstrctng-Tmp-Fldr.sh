#!/usr/bin/env bash
time=$(printf "%(%l%M%S)T\\n" "-1")

mkdir temp_folder_"$time"

__old_pwd__="$PWD"

cd temp_folder_"$time" && "$SHELL"

cd "$__old_pwd__" || exit

rm -rf "temp_folder_$time"
