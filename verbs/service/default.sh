#!/bin/sh

#1 - Name

[ -d "etc/sv/$1" ] || (echo "no such service"; exit 1)
ln -sf "etc/sv/$1" "/var/service"
