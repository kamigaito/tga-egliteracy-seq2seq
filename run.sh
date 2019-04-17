#!/bin/sh

# This directory contains libraries and exexution files.
ROOT_DIR=/gs/hs0/tga-egliteracy/egs/seq2seq
# This directory contains training, development and test set
DATA_DIR=/gs/hs0/tga-egliteracy/egs/seq2seq/dataset/kftt-data-1.0/data/tok
# This directory contains output directions.
WORK_DIR=$(cd $(dirname $0); pwd)/work

mkdir -p $WORK_DIR/input

source ${ROOT_DIR}/.bashrc
/usr/bin/env

##${ROOT_DIR}/prep.sh ${ROOT_DIR} ${DATA_DIR} ${WORK_DIR}
${ROOT_DIR}/train.sh ${ROOT_DIR} ${DATA_DIR} ${WORK_DIR}
${ROOT_DIR}/eval.sh ${ROOT_DIR} ${DATA_DIR} ${WORK_DIR}
