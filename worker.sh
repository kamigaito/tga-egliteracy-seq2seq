#!/bin/sh

#$ -l q_node=1
#$ -l h_rt=6:00:0

. /etc/profile.d/modules.sh
module load cuda

# This directory contains libraries and exexution files.
ROOT_DIR=/gs/hs0/tga-egliteracy/egs/seq2seq
# This directory contains training, development and test set
DATA_DIR=/gs/hs0/tga-egliteracy/egs/seq2seq/dataset
# This directory contains output directions.
WORK_DIR=${HOME}/seq2seq

source ${ROOT_DIR}/.bashrc
/usr/bin/env

##${ROOT_DIR}/prep.sh ${ROOT_DIR} ${DATA_DIR} ${WORK_DIR}
${ROOT_DIR}/train.sh ${ROOT_DIR} ${DATA_DIR} ${WORK_DIR}
${ROOT_DIR}/eval.sh ${ROOT_DIR} ${DATA_DIR} ${WORK_DIR}
