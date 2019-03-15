#!/bin/bash

ROOT_DIR=${1}
DATA_DIR=${2}
WORK_DIR=${3}
MODEL_DIR=${WORK_DIR}/models

if [ ! -e ${MODEL_DIR} ]
then
    mkdir -p ${MODEL_DIR}
fi
cd ${ROOT_DIR}/apps/OpenNMT-py
suffix="en-ja ja-en"
for lang_pair in ${suffix}; do
    src=`echo ${lang_pair} | awk -F"-" '{print $1}'`
    trg=`echo ${lang_pair} | awk -F"-" '{print $2}'`
    python preprocess.py \
        -train_src ${DATASET}/kyoto-train.cln.${src} \
        -train_tgt ${DATASET}/kyoto-train.cln.${trg} \
        -valid_src ${DATASET}/kyoto-dev.${src} \
        -valid_tgt ${DATASET}/kyoto-dev.${trg} \
        -save_data ${MODEL_DIR}/dicts-${lang_pair} \
        -src_words_min_frequency 5 \
        -tgt_words_min_frequency 5 \
        -src_seq_length 40 \
        -tgt_seq_length 40
done
for lang_pair in ${suffix}; do
    python train.py \
        -data ${MODEL_DIR}/dicts-${lang_pair} \
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
