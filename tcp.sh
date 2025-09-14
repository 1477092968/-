#!/bin/bash

if [ "$#" -ne 3 ]; then
    echo "Usage:  $0 <port> <ip> <timeout>"
    exit 1
fi

PORT=\$1
IP=\$2
TIMEOUT=\$3

nc -zv -w $TIMEOUT $IP $PORT
