#!/usr/bin/env bash

while IFS=$'\n' read -sr line; do
    echo "${line}"        
done < <(ls -l && read -rt "2" <> <(:) || :)