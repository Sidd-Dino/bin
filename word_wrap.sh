#!/usr/bin/env bash

TEXT=("")
buffer=
MAX_WIDTH=36

get_text() {
    while read -ru 0 -n 1; do
        read_reply="${REPLY}"
        case $read_reply in
            # Backspace.
            $'\177'|$'\b')
                TEXT[${#TEXT}-1]=${TEXT[${#TEXT}-1]: -1}
                printf "\e[K%s" "TEXT[${#TEXT}-1]"
            ;;
            
            '')
                if [[ $buffer == '' ]]; then
                    TEXT=( "${TEXT[@]}" "" )
                    buffer=
                else
                    buffer=''
                fi
            ;;

            " ")
                if [[ $buffer != ' ' ]]; then
                    TEXT[${#TEXT[@]}-1]+=" "
                    buffer=' '
                fi
            ;;

            $'\004')
                printf "\n"
                break
            ;;

            [[:alnum:]] |\
            [[:punct:]] )
                buffer=
                TEXT[${#TEXT[@]}-1]+="$read_reply"
            ;;
        esac
    done
}

wrap_text() {
    local current_line_num=0
    while :; do
        LENGTH_OF_LINE=${#TEXT[current_line_num]}
        #printf "%s\n" "$LENGTH_OF_LINE"
        if (( LENGTH_OF_LINE > MAX_WIDTH )); then
            for (( i=MAX_WIDTH;i>=0;i-- ));do
                (( i==0 )) && {
                    TEXT=( "${TEXT[@]::current_line_num}"
                           "${TEXT[current_line_num]::MAX_WIDTH}"
                           "${TEXT[current_line_num]:MAX_WIDTH}"
                           "${TEXT[@]:current_line_num+1}"
                         )
                    break
                }
                [[ " !#$.,;]})" == *${TEXT[current_line_num]:i:1}* ]] && {
                    TEXT=( "${TEXT[@]::current_line_num}"
                           "${TEXT[current_line_num]::i}"
                           "${TEXT[current_line_num]:i}"
                           "${TEXT[@]:current_line_num+1}"
                         )
                    break
                }
            done
        fi

        printf "%s\n" "${TEXT[current_line_num]}"

        (( current_line_num+=1 ))
        (( current_line_num==${#TEXT[@]} )) && break
    done
}

get_text
printf "%s\n" "${TEXT[@]}"
printf "%s\n" "---------------"
wrap_text
