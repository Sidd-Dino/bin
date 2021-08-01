#!/usr/bin/env bash
#
# char_disp_len.sh
# A simple script that measures the number of columns
# it consumes trying to display a character in a string.

get_cursor_pos() {
    # Usage: get_cursor_pos
    IFS='[;' read -p $'\e[6n' -d R -rs _ y x _
}

main() {
    A="✊🏿"$'\t'"Dark Fist"
    len_list=()
    for ((i=0;i<${#A};i++)); do
        printf "%s" "${A:i:1}"
        get_cursor_pos
        len_list=("${len_list[@]}" $((x-1)) )
        printf "\e[2K\r"
    done

    for ((i=0;i<${#A};i++)); do
        printf "|%s|-->[%s]\n" "${A:i:1}" "${len_list[i]}"
    done

    printf "%s\n" "$A"
}

main "$@"