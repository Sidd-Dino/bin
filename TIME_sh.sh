#!/usr/bin sh
curl -s en.wttr.in/Sabadell?0T
TIME=$(date +"%H:%M")
BATCAP=$(su -c cat /sys/class/power_supply/battery/capacity)
BATSTA=$(su -c cat /sys/class/power_supply/battery/status)
STAT="${BATSTA:0:1}"

CHAR0=( '  ▄▄▄  ' ' █  ▄█ ' ' █ █ █ ' ' █▀  █ ' '  ▀▀▀  ')
CHAR1=( '  ▄▄   ' '   █   ' '   █   ' '   █   ' '  ▀▀▀  ')
CHAR2=( '  ▄▄▄  ' ' █   █ ' '  ▄▄▄▀ ' ' █     ' ' ▀▀▀▀▀ ')
CHAR3=( '  ▄▄▄  ' ' ▀   █ ' '   ▀▀▄ ' ' ▄   █ ' '  ▀▀▀  ')
CHAR4=( ' ▄   ▄ ' ' █   █ ' ' ▀▀▀▀█ ' '     █ ' '     ▀ ')
CHAR5=( ' ▄▄▄▄▄ ' ' █   ▀ ' ' ▀▀▀▀▄ ' ' █   █ ' '  ▀▀▀  ')
CHAR6=( '  ▄▄▄  ' ' █   ▀ ' ' █▀▀▀▄ ' ' █   █ ' '  ▀▀▀  ')
CHAR7=( ' ▄▄▄▄▄ ' ' ▀  ▄▀ ' '   █   ' '   █   ' '   ▀   ')
CHAR8=( '  ▄▄▄  ' ' █   █ ' ' ▄▀▀▀▄ ' ' █   █ ' '  ▀▀▀  ')
CHAR9=( '  ▄▄▄  ' ' █   █ ' ' ▀▄▄▄█ ' ' ▄   █ ' '  ▀▀▀  ')
CHARC=( '   ' ' ▄ ' '   ' ' ▀ ' '   ')

CHARD=('╚╝ ' '╚╝ ' '╚╝ ')
CHARI=('╔╗ ' '╔╗ ' '╔╗ ')

TS=('' '' '' '' '' )

Q=$(expr ${#TIME} - 1)
for i in $( seq 0 $Q)
do
  #echo "${TIME:$i:1}"
  for index in ${!TS[*]}; do
    case "${TIME:$i:1}" in
    "1")
        TS[$index]=${TS[$index]}${CHAR1[$index]}
        ;;
    "2")
        TS[$index]=${TS[$index]}${CHAR2[$index]}
        ;;
    "3")
        TS[$index]=${TS[$index]}${CHAR3[$index]}
        ;;
    "4")
        TS[$index]=${TS[$index]}${CHAR4[$index]}
        ;;
    "5")
        TS[$index]=${TS[$index]}${CHAR5[$index]}
        ;;
    "6")
        TS[$index]=${TS[$index]}${CHAR6[$index]}
        ;;
    "7")
        TS[$index]=${TS[$index]}${CHAR7[$index]}
        ;;
    "8")
        TS[$index]=${TS[$index]}${CHAR8[$index]}
        ;;
    "9")
        TS[$index]=${TS[$index]}${CHAR9[$index]}
        ;;
    "0")
        TS[$index]=${TS[$index]}${CHAR0[$index]}
        ;;
    ":")
        TS[$index]=${TS[$index]}${CHARC[$index]}
        ;;
    *)
        echo "${TIME:$i:1}"
        ;;
    esac
  done
done

printf "%s\n" "${TS[0]}"
printf "%s\n" "${TS[1]}"
printf "%s\n" "${TS[2]}"
printf "%s\n" "${TS[3]}"
printf "%s\n" "${TS[4]}"

#================================================
B0=( '█▀█ ' '█ █ ' '▀▀▀ ' )
B1=( ' █  ' ' █  ' ' ▀  ' )
B2=( '▀▀█ ' '█▀▀ ' '▀▀▀ ' )
B3=( '▀▀█ ' ' ▀█ ' '▀▀▀ ' )
B4=( '█ █ ' '▀▀█ ' '  ▀ ' )
B5=( '█▀▀ ' '▀▀█ ' '▀▀▀ ' )
B6=( '█▀▀ ' '█▀█ ' '▀▀▀ ' )
B7=( '▀▀█ ' ' █  ' ' ▀  ' )
B8=( '█▀█ ' '█▀█ ' '▀▀▀ ' )
B9=( '█▀█ ' '▀▀█ ' '▀▀▀ ' )

BS=( '' '' '' )

Q=$(expr ${#BATCAP} - 1)
for i in $( seq 0  $Q)
do
  #echo "${TIME:$i:1}"
  for index in ${!BS[*]}; do
    case "${BATCAP:$i:1}" in
    "1")
        BS[$index]=${BS[$index]}${B1[$index]}
        ;;
    "2")
        BS[$index]=${BS[$index]}${B2[$index]}
        ;;
    "3")
        BS[$index]=${BS[$index]}${B3[$index]}
        ;;
    "4")
        BS[$index]=${BS[$index]}${B4[$index]}
        ;;
    "5")
        BS[$index]=${BS[$index]}${B5[$index]}
        ;;
    "6")
        BS[$index]=${BS[$index]}${B6[$index]}
        ;;
    "7")
        BS[$index]=${BS[$index]}${B7[$index]}
        ;;
    "8")
        BS[$index]=${BS[$index]}${B8[$index]}
        ;;
    "9")
        BS[$index]=${BS[$index]}${B9[$index]}
        ;;
    "0")
        BS[$index]=${BS[$index]}${B0[$index]}
        ;;
    *)
        echo "${BATCAP:$i:1}"
        ;;
    esac
  done
done
#================================================


if [ $STAT == 'C' ]
then
  BS[0]=${CHARI[0]}${BS[0]}${CHARI[0]}
  BS[1]=${CHARI[1]}${BS[1]}${CHARI[1]}
  BS[2]=${CHARI[2]}${BS[2]}${CHARI[2]}
fi
if [ $STAT == 'D' ]
then
  BS[0]=${CHARD[0]}${BS[0]}${CHARD[0]}
  BS[1]=${CHARD[1]}${BS[1]}${CHARD[1]}
  BS[2]=${CHARD[2]}${BS[2]}${CHARD[2]}
fi
#==============================================

printf " %s\n" "${BS[0]}"
printf " %s\n" "${BS[1]}"
printf " %s" "${BS[2]}"
