#!/usr/bin/env bash
for ((i=0;i<256;i++)); {
	printf "\e[38;5;%sm%s\n\e[m" "$i" "$i=lol";
}
