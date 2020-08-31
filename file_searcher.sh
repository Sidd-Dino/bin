#!/usr/bin/env bash
# Write to the command_line (under status_line).
cmd_reply=
# '\r\e[K': Redraw the read prompt on every keypress.
#           This is mimicking what happens normally.
while IFS= read -rsn 1 -p $'\r\e[K'"${1}${cmd_reply}" read_reply; do
        case $read_reply in
            # Backspace.
            $'\177'|$'\b')
                cmd_reply=${cmd_reply%?}

                # Clear tab-completion.
                unset comp c
            ;;

            # Tab.
            $'\t')
                comp_glob="$cmd_reply*"

                # Pass the argument dirs to limit completion to directories.
                [[ $2 == dirs ]] &&
                    comp_glob="$cmd_reply*/"

                # Generate a completion list once.
                [[ -z ${comp[0]} ]] &&
                    IFS=$'\n' read -d "" -ra comp < <(compgen -G "$comp_glob")

                # On each tab press, cycle through the completion list.
                [[ -n ${comp[c]} ]] && {
                    cmd_reply=${comp[c]}
                    ((c=c >= ${#comp[@]}-1 ? 0 : ++c))
                }
            ;;

            # Escape / Custom 'no' value (used as a replacement for '-n 1').
            $'\e'|${3:-null})
                read "${read_flags[@]}" -rsn 2
                cmd_reply=
                break
            ;;

            # Enter/Return.
            "")
                # If there's only one search result and its a directory,
                # enter it on one enter keypress.
                [[ $2 == search && -d ${list[0]} ]] && ((list_total == 0)) && {
                    # '\e[?25l': Hide the cursor.
                    printf '\e[?25l'

                    open "${list[0]}"
                    search_end_early=1

                    # Unset tab completion variables since we're done.
                    unset comp c
                    return
                }

                break
            ;;

            # Replace '~' with '$HOME'.
            "~")
                cmd_reply+=$HOME
            ;;

            # Anything else, add it to read reply.
            *)
                cmd_reply+=$read_reply

                # Clear tab-completion.
                unset comp c
            ;;
        esac
done