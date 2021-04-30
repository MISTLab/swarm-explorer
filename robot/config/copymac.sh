#!/bin/sh

/sbin/ifconfig bat0 hw ether `/sbin/ifconfig $1 | grep -o -E '([[:xdigit:]]{2}:){5}[[:xdigit:]]{2}' | sed 's/..\(:..:..:..:..:..\)/aa\1/'`
