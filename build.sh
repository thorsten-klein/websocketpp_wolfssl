#!/bin/bash

if [ $? -ne 0 ]; then /bin/bash -c "$0"; exit; fi

ROOT_DIR=$PWD
DIR_WOLFSSL=$ROOT_DIR/wolfssl/wolfssl-3.13.0

cd $DIR_WOLFSSL
./configure --enable-opensslextra

cd $ROOT_DIR/websocketpp/examples/debug_client
g++ *.cpp -I../.. -I$ROOT_DIR/asio/asio-1.10.8/include -DASIO_STANDALONE  -std=c++11 -lcrypto -I$ROOT_DIR/wolfssl/wolfssl-3.13.0/wolfssl
g++ *.cpp -I../.. -I$ROOT_DIR/asio/asio-1.10.8/include -DASIO_STANDALONE  -std=c++11 -I$DIR_WOLFSSL/wolfssl 


make
make install DESTDIR=$ROOT_DIR/wolfssl/wolfssl-3.13.0/install
g++ -std=c++11 -I$ROOT_DIR/wolfssl/wolfssl-3.13.0 -I$ROOT_DIR/asio/asio-1.10.8/include -I/home/default/GIT/websocketpp/ *.cpp -lboost_system -lcrypto -l$ROOT_DIR/wolfssl/wolfssl-3.13.0/install/usr/local/lib/libwolfssl.so
g++ *.cpp -I../.. -I$ROOT_DIR/asio/asio-1.10.8/include -DASIO_STANDALONE  -std=c++11 -I$ROOT_DIR/wolfssl/wolfssl-3.13.0/wolfssl 
pkg-config --cflags wolfssl -DBOOST_NETWORK_ENABLE_HTTPS
g++ *.cpp -I../.. -I$ROOT_DIR/asio/asio-1.10.8/include -DASIO_STANDALONE  -std=c++11 -I$ROOT_DIR/wolfssl/wolfssl-3.13.0/wolfssl -DBOOST_NETWORK_ENABLE_HTTPS
g++ *.cpp -I../.. -I$ROOT_DIR/asio/asio-1.10.8/include -DASIO_STANDALONE  -std=c++11 -I$ROOT_DIR/wolfssl/wolfssl-3.13.0/wolfssl -lboost_system



echo
echo "----------------------------------------------------"
read -n1 -r -p "Script finalized :-)" key



