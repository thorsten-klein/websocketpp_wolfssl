#!/bin/bash

if [ $? -ne 0 ]; then /bin/bash -c "$0"; exit; fi

ROOT_DIR=$PWD

WEBSOCKETPP_DIR=$ROOT_DIR/websocketpp
ASIO_DIR=$ROOT_DIR/asio/asio-1.10.8
WOLFSSL_DIR=$ROOT_DIR/wolfssl

WOLFSSL_SRC_ZIP=$WOLFSSL_DIR/wolfssl-3.13.0.zip
WOLFSSL_SRC_DIR=$WOLFSSL_DIR/wolfssl-3.13.0
WOLFSSL_INSTALL_DIR=$WOLFSSL_SRC_DIR/installed



# compile wolfssl
unzip $WOLFSSL_SRC_ZIP -d $WOLFSSL_DIR 
cd $WOLFSSL_SRC_DIR
./configure --enable-opensslextra
make install DESTDIR=$WOLFSSL_INSTALL_DIR


# compile websockettpp example
cd $ROOT_DIR/websocketpp/examples/debug_client

#normally
mkdir with_openssl
g++ ../*.cpp -I$WEBSOCKETPP_DIR -I$ASIO_DIR/include -std=c++11 -I$WOLFSSL_SRC_DIR/wolfssl -lcrypto -lboost_system -lpthread -lssl

cd..

#with wolfssl
mkdir with_wolfssl
g++ ../*.cpp -I$WEBSOCKETPP_DIR -I$ASIO_DIR/include -std=c++11 -I$WOLFSSL_SRC_DIR/wolfssl -lcrypto -lboost_system -lpthread -I$WOLFSSL_INSTALL_DIR/usr/local/include -I$WOLFSSL_INSTALL_DIR/usr/local/include/wolfssl


# using ASIO Standalone
## DOES NOT WORK WITH OPENSSL
## OPENSSL NEEDS BOOST ASIO
#
# g++ ../*.cpp -I$WEBSOCKETPP_DIR -I$ASIO_DIR/include -std=c++11 -I$WOLFSSL_SRC_DIR/wolfssl -lcrypto -lboost_system -lpthread -lssl -DASIO_STANDALONE




echo
echo "----------------------------------------------------"
read -n1 -r -p "Script finalized :-)" key



