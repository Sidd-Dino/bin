#!/usr/bin/env bash
key_cap_1() {
    for ((;;)) do
        read -rsn 1
        printf "R1:%q %d\n" "${REPLY}" "${#REPLY}"

        [[ ${REPLY} == $'\e' ]] && {
            special_keys+=${REPLY}

            # \e A
            # \e [ A
            # \e [ 6 ~
            # \e [ 2 0 ~
            # \e [ 1 ; 5~
            # \e [ 1 ; 5C
            # -- - - - --
            #  1 2 3 4 5

            #* read 2
            read "${read_flags[@]}" -srn 1
            printf "R2:%q\n" "${REPLY}"
            special_keys+=${REPLY}

            [[ $REPLY == $'[' ]] && {
                #* read 3
                read "${read_flags[@]}" -srn 1
                printf "R3:%q\n" "${REPLY}"
                special_keys+=${REPLY}

                [[ ${REPLY} == [0-9] ]] && {
                    #* read 4
                    read "${read_flags[@]}" -srn 1
                    printf "R4:%q\n" "${REPLY}"
                    special_keys+=${REPLY}

                    [[ ${REPLY} == [[:digit:]] ]] && {
                        read "${read_flags[@]}" -srn 1 _
                        printf "R5:%q\n" "${REPLY}"
                        special_keys+="~"
                    }

                    [[ ${REPLY} == ";" ]] && {
                        read "${read_flags[@]}" -srn 2
                        printf "R5:%q\n" "${REPLY}"
                        special_keys+=${REPLY}
                    }
                }
            }

            printf "RESULT:%q\n" "$special_keys"
            special_keys=
        }

    done
}

key_cap_2() {
    for((;;)){
        read -rsn 1
        
    }
}

key_cap_1
