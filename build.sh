#!/bin/bash

if [ $? -ne 0 ]; then /bin/bash -c "$0"; exit; fi

ROOT_DIR=$PWD

WEBSOCKETPP_DIR=$ROOT_DIR/websocketpp
ASIO_DIR=$ROOT_DIR/asio/asio-1.10.8

WOLFSSL_SRC_DIR=$ROOT_DIR/wolfssl_github
WOLFSSL_INSTALL_DIR=$WOLFSSL_SRC_DIR/installed

# initialize submodules
git submodule update --init --recursive

# compile wolfssl
cd $WOLFSSL_SRC_DIR
./autogen.sh
./configure --enable-opensslextra --prefix=$WOLFSSL_INSTALL_DIR
make install


# compile websockettpp example
EXAMPLE_DIR=$ROOT_DIR/examples/debug_client

# using openssl
cd $EXAMPLE_DIR
mkdir with_openssl
cd with_openssl
echo "++++++++++++++++++++++++++++++++++++++++++++++"
echo "Compiling $PWD ..."
echo "++++++++++++++++++++++++++++++++++++++++++++++"
g++ ../*.cpp -std=c++11 -I$WEBSOCKETPP_DIR -I$ASIO_DIR/include -lcrypto -lboost_system -lpthread -lssl -DASIO_STANDALONE

# using wolfssl
cd $EXAMPLE_DIR
mkdir with_wolfssl
cd with_wolfssl
echo "++++++++++++++++++++++++++++++++++++++++++++++"
echo "Compiling $PWD ..."
echo "++++++++++++++++++++++++++++++++++++++++++++++"
g++ ../*.cpp -std=c++11 -I$WEBSOCKETPP_DIR -I$ASIO_DIR/include -lboost_system -lpthread -I$WOLFSSL_INSTALL_DIR/include -I$WOLFSSL_INSTALL_DIR/include/wolfssl -L$WOLFSSL_INSTALL_DIR/lib -lwolfssl -DWOLFSSL_EXAMPLE -DASIO_STANDALONE


echo
echo "----------------------------------------------------"
read -n1 -r -p "Script finalized :-)" key



