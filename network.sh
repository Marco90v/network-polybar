#!/bin/bash

INTERFACEACTIVE="" #<-- This variable can be used to display the type of interface
STATUS=""
INTERFACETYPE=""
TIMEOLD=0
RED=#FF0000
GREEN=#008000
TIMENOW=0
ICONOFFLINE=""
ICONDOWN=""
ICONUP="祝"

status(){
    if (ping -c 1 google.com || ping -c 1 github.com) &>/dev/null; then
        STATUS="Online"
    else
        STATUS="Offline"
    fi
}

verifyConnection(){
    tempEthernet=$(nmcli device | grep ethernet)
    tempWifi=$(nmcli device | awk '/wifi/ && length($2) == 4 {print}')

    if [[ $(echo "$tempEthernet" | awk '{print $3}') == 'conectado' ]]; then
        INTERFACEACTIVE=$(echo "$tempEthernet" | awk '{print $1}')
        INTERFACETYPE="Ethernet"
        status
    elif [[ $(echo "$tempWifi" | awk '{print $3}') == 'conectado' ]]; then
        INTERFACEACTIVE=$(echo "$tempWifi" | awk '{print $1}')
        INTERFACETYPE="Wifi"
        status
    else
        INTERFACEACTIVE=""
        INTERFACETYPE=""
        STATUS="Disconnected"
    fi
}

transform(){
    value=$1
    total=$(($value/1024))
    if [[ $total -ge 1024 ]]; then
        total=$(($total/1024))
        echo -n "$total Mb/s" 
    else
        echo -n "$total Kb/s" 
    fi
}

speed(){
    line=$(cat /proc/net/dev | grep $INTERFACEACTIVE | cut -d ':' -f 2 | awk '{print "old_received_bytes="$1, "old_transmitted_bytes="$9}')
    eval $line
    sleep 1

    line2=$(cat /proc/net/dev | grep $INTERFACEACTIVE | cut -d ':' -f 2 | awk '{print "received_bytes="$1, "transmitted_bytes="$9}')
    eval $line2

    received=$(($received_bytes-$old_received_bytes))
    transmitted=$(($transmitted_bytes-$old_transmitted_bytes))

    if [[ received -ge 1024 ]]; then
        received=$(transform $received)
    else
        received=$(echo "$received B/s")
    fi
    if [[ transmitted -ge 1024 ]]; then
        transmitted=$(transform $transmitted)
    else
        transmitted=$(echo "$transmitted B/s")
    fi

    echo "%{F$GREEN}$ICONDOWN%{F-}  $received  %{F$RED}$ICONUP%{F-}  $transmitted"
}

view(){
    if [[ "$STATUS" == "Online" ]]; then
        speed
    else
        echo "%{F$RED}$ICONOFFLINE%{F-} $STATUS"
        sleep 10
    fi
}

while [ true ]; do
    if [[ "$TIMEOLD" -ne 0 || "$STATUS" != "" || "$INTERFACETYPE" != "" || "$INTERFACEACTIVE" != "" ]]; then
        TIMENOW=$(date +"%s")

        let seg=$TIMENOW-$TIMEOLD
        if [[ $seg -ge 30 ]]; then
            verifyConnection
        fi
        view
    else
        verifyConnection
        view
    fi
done
