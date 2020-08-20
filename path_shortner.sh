#!/usr/bin/env bash
PATH_SHORTNER(){
    printf "%s\n%s\n%s\n" "$HOME" "$1" "${1/$HOME/'~'}"
    _pwd_="${1/$HOME/~}"
    shrtnd_pth=""
    for((i=0;i<${#_pwd_};i++)){
        [[ "${_pwd_:i:1}" == '~' ]] && {
            shrtnd_pth+="${_pwd_:i:1}/"
        }
        [[ "${_pwd_:i:1}" == '/' ]] && {
            shrtnd_pth+="${_pwd_:i:2}"
        }
        printf "%s" "$shrtnd_pth"
    }

    printf "%s" "$shrtnd_pth"
}

PATH_SHORTNER "$PWD"