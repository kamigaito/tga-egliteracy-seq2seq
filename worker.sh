#!/bin/sh

#$ -l q_node=1
#$ -l h_rt=6:00:0

. /etc/profile.d/modules.sh
module load cuda

# This directory contains libraries and exexution files.
ROOTDIR=/gs/hs0/tga-egliteracy/egs/seq2seq
# This directory contains training, development and test set
DATADIR=/gs/hs0/tga-egliteracy/egs/seq2seq/dataset
# This directory contains output directions.
WORKDIR=${HOME}/seq2seq

source ${ROOTDIR}/.bashrc
/usr/bin/env

##${ROOTDIR}/prep.sh ${ROOTDIR} ${DATADIR} ${WORKDIR}
${ROOTDIR}/train.sh ${ROOTDIR} ${DATADIR} ${WORKDIR}
${ROOTDIR}/eval.sh ${ROOTDIR} ${DATADIR} ${WORKDIR}
