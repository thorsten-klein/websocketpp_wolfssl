#!/bin/bash

if [ $? -ne 0 ]; then /bin/bash -c "$0"; exit; fi

# clean this repository
git clean -d -f
git reset --hard
rm -rf ./wolfssl/wolfssl-3.13.0

# clean submodule websocketpp
cd websocketpp
git clean -d -f
git reset --hard

echo
echo "----------------------------------------------------"
read -n1 -r -p "Script finalized :-)" key



