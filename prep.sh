#!/bin/bash

APPS_DIR=${1}
DATA_DIR=${2}
WORK_DIR=${3}
DATASET=${DATA_DIR}/kftt-data-1.0/data/tok

mkdir -p $WORK_DIR/input

if [ ! -e ${APPS_DIR}/done ]
then
  echo "download and make apps..."
  ./setup.sh ${APPS_DIR}
  echo "finish apps preparation."
fi

if [ -e ${DATA_DIR}/done ]
then
	echo "data is already prepared. Skip"
	exit 0
fi

mkdir -p ${DATA_DIR}

# Download data set
wget -O ${DATA_DIR}/kftt-data-1.0.tar.gz http://www.phontron.com/kftt/download/kftt-data-1.0.tar.gz
cd ${DATA_DIR}
# Uncompress
tar xvzf kftt-data-1.0.tar.gz

paste \
  ${DATASET}/kyoto-train.cln.en \
  ${DATASET}/kyoto-train.cln.ja |
  shuf > ${DATASET}/train.shuf
head -n $((`cat ${DATASET}/train.shuf | wc -l`/100)) ${DATASET}/train.shuf | cut -f 1 > ${DATASET}/train1p.en
head -n $((`cat ${DATASET}/train.shuf | wc -l`/100)) ${DATASET}/train.shuf | cut -f 2 > ${DATASET}/train1p.ja
head -n $((`cat ${DATASET}/train.shuf | wc -l`/5)) ${DATASET}/train.shuf | cut -f 1 > ${DATASET}/train20p.en
head -n $((`cat ${DATASET}/train.shuf | wc -l`/5)) ${DATASET}/train.shuf | cut -f 2 > ${DATASET}/train20p.ja
head -n $((3*`cat ${DATASET}/train.shuf | wc -l`/5)) ${DATASET}/train.shuf | cut -f 1 > ${DATASET}/train60p.en
head -n $((3*`cat ${DATASET}/train.shuf | wc -l`/5)) ${DATASET}/train.shuf | cut -f 2 > ${DATASET}/train60p.ja
cut -f 1 ${DATASET}/train.shuf > ${DATASET}/train100p.en
cut -f 2 ${DATASET}/train.shuf > ${DATASET}/train100p.ja

cd ${APPS_DIR}/OpenNMT-py
suffix="en-ja ja-en"
for train_name in train1p train20p train60p train100p; do
for lang_pair in ${suffix}; do
    src=`echo ${lang_pair} | awk -F"-" '{print $1}'`
    trg=`echo ${lang_pair} | awk -F"-" '{print $2}'`
    python preprocess.py \
        -train_src ${DATASET}/${train_name}.${src} \
        -train_tgt ${DATASET}/${train_name}.${trg} \
        -valid_src ${DATASET}/kyoto-dev.${src} \
        -valid_tgt ${DATASET}/kyoto-dev.${trg} \
        -save_data ${DATA_DIR}/dicts-${train_name}-${lang_pair} \
        -src_words_min_frequency 5 \
        -tgt_words_min_frequency 5 \
        -src_seq_length 40 \
        -tgt_seq_length 40
done
done

touch $DATA_DIR/done
