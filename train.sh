#!/bin/bash

ROOT_DIR=${1}
DATA_DIR=${2}
WORK_DIR=${3}
MODEL_DIR=${WORK_DIR}/models

if [ -e $MODEL_DIR/done ]; then
	echo "model is already trained. Skip"
	exit 0
fi

if [ ! -e ${MODEL_DIR} ]
then
    mkdir -p ${MODEL_DIR}
fi

cd ${ROOT_DIR}/apps/OpenNMT-py
suffix="en-ja ja-en"

for lang_pair in ${suffix}; do
    python train.py \
        -data ${DATA_DIR}/dicts-${lang_pair} \
        -save_model ${MODEL_DIR}/${lang_pair} \
        -layers 2 \
        -rnn_size 500 \
        -word_vec_size 300 \
        -optim adam \
        -learning_rate 0.001 \
        -dropout 0.3 \
        -batch_size 256 \
        -report_every 1 \
        -save_checkpoint_steps 10000 \
        -train_steps 30000 \
        -gpu_rank 0
done

touch $MODEL_DIR/done
