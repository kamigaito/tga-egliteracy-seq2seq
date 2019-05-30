#!/bin/bash

APP_DIR=${1}

if [ ! -e ${APP_DIR} ]
then
    mkdir -p ${APP_DIR}
fi

cd ${APP_DIR}

git clone https://github.com/moses-smt/mosesdecoder.git
git clone https://github.com/OpenNMT/OpenNMT-py.git
wget http://www.phontron.com/kytea/download/kytea-0.4.7.tar.gz
tar xzf kytea-0.4.7.tar.gz
cd kytea-0.4.7
./configure --prefix=${APP_DIR}/kytea-0.4.7
make
make install

touch $APP_DIR/done
