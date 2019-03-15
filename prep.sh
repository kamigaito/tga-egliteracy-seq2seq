#!/bin/bash

ROOTDIR=${1}
DATADIR=${2}
WORKDIR=${3}
DATASET=${DATADIR}/kftt-data-1.0/data/tok
MODELS=${WORKDIR}/models
# If not exit, make work space
if [ ! -e ${MODELS} ]
then
    mkdir -p ${MODELS}
fi
# Download data set
wget -O ${DATADIR}/kftt-data-1.0.tar.gz http://www.phontron.com/kftt/download/kftt-data-1.0.tar.gz
cd ${DATADIR}
# Uncompress
tar xvzf kftt-data-1.0.tar.gz
