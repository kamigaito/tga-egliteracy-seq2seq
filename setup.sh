#!/bin/bash

ROOT_DIR=$(cd $(dirname $0); pwd)"../"
APP_DIR=${ROOT_DIR}/apps

if [ -e ${APP_DIR} ]
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

cd ..
cd ..

wget https://repo.anaconda.com/archive/Anaconda3-2018.12-Linux-x86_64.sh
chmod +x Anaconda3-2018.12-Linux-x86_64.sh
./Anaconda3-2018.12-Linux-x86_64.sh
