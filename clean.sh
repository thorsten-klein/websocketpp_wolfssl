#!/bin/bash

if [ $? -ne 0 ]; then /bin/bash -c "$0"; exit; fi

rm -rf ./wolfssl/wolfssl-3.13.0

echo
echo "----------------------------------------------------"
read -n1 -r -p "Script finalized :-)" key



