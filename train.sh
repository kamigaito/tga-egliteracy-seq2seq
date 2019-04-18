#!/bin/bash

ROOT_DIR=${1}
DATA_DIR=${2}
WORK_DIR=${3}
TRAIN_NAME=${4}
LANG_PAIR=${5}
MODEL_DIR=${WORK_DIR}/models
DATASET=${DATA_DIR}/kftt-data-1.0/data/tok

NUM_EPOCH=25

if [ -e $MODEL_DIR/$LANG_PAIR.done ]; then
	echo "model is already trained. Skip"
	exit 0
fi

if [ ! -e ${MODEL_DIR} ]
then
    mkdir -p ${MODEL_DIR}
fi

NUM_DATA=$(cat ${DATASET}/${TRAIN_NAME}.en | wc -l)

cd ${ROOT_DIR}/apps/OpenNMT-py

batch_size=256
num_steps=$((${NUM_DATA}*${NUM_EPOCH}/${batch_size}))
python train.py \
    -data ${DATA_DIR}/dicts-${TRAIN_NAME}-${LANG_PAIR} \
    -save_model ${MODEL_DIR}/${LANG_PAIR} \
    -layers 2 \
    -rnn_size 500 \
    -word_vec_size 300 \
    -optim adam \
    -learning_rate 0.001 \
    -dropout 0.3 \
    -batch_size ${batch_size} \
    -report_every 1 \
    -save_checkpoint_steps ${num_steps} \
    -train_steps ${num_steps} \
    -gpu_rank 0
cp ${MODEL_DIR}/${LANG_PAIR}_step_${num_steps}.pt ${MODEL_DIR}/${LANG_PAIR}_final.pt

touch $MODEL_DIR/$LANG_PAIR.done
