#!/bin/bash

ROOT_DIR=${1}
DATA_DIR=${2}
WORK_DIR=${3}
DATASET=${DATA_DIR}/kftt-data-1.0/data/tok
MODELS=${WORK_DIR}/models
# If not exit, make work space
if [ ! -e ${MODELS} ]
then
    mkdir -p ${MODELS}
fi
# Download data set
wget -O ${DATA_DIR}/kftt-data-1.0.tar.gz http://www.phontron.com/kftt/download/kftt-data-1.0.tar.gz
cd ${DATA_DIR}
# Uncompress
tar xvzf kftt-data-1.0.tar.gz
