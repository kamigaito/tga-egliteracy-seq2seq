#!/bin/bash

ROOT_DIR=${1}
DATA_DIR=${2}
WORK_DIR=${3}
DATASET=${DATA_DIR}/kftt-data-1.0/data/tok

if [ -e ${DATA_DIR}/done ]
then
	echo "data is already prepared. Skip"
	exit 0
fi

# Download data set
wget -O ${DATA_DIR}/kftt-data-1.0.tar.gz http://www.phontron.com/kftt/download/kftt-data-1.0.tar.gz
cd ${DATA_DIR}
# Uncompress
tar xvzf kftt-data-1.0.tar.gz

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
        -save_data ${DATA_DIR}/dicts-${lang_pair} \
        -src_words_min_frequency 5 \
        -tgt_words_min_frequency 5 \
        -src_seq_length 40 \
        -tgt_seq_length 40
done

touch $DATA_DIR/done
