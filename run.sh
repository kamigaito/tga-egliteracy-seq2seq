#!/bin/sh

### This directory contains libraries and exexution files.
APPS_DIR=/gs/hs0/tga-egliteracy/egs/seq2seq/apps
#APPS_DIR=$(cd $(dirname $0); pwd)/../apps
### This directory contains scripts.
SCRIPT_DIR=$(cd $(dirname $0); pwd)/scripts
### This directory contains training, development and test set
DATA_DIR=/gs/hs0/tga-egliteracy/data/tga-egliteracy-seq2seq/dataset
#DATA_DIR=$(cd $(dirname $0); pwd)/../dataset
### This directory contains output directions.
WORK_DIR=$(cd $(dirname $0); pwd)/work

LANG_PAIR=ja-en #japanese -> english
#LANG_PAIR=en-ja #english -> japanese

./prep.sh ${APPS_DIR} ${DATA_DIR} ${WORK_DIR} >& prep.log

start_time=`date +%s`

./train.sh ${APPS_DIR} ${DATA_DIR} ${WORK_DIR} train1p ${LANG_PAIR} >& train.log
#./train.sh ${APPS_DIR} ${DATA_DIR} ${WORK_DIR} train20p ${LANG_PAIR} >& train.log
#./train.sh ${APPS_DIR} ${DATA_DIR} ${WORK_DIR} train60p ${LANG_PAIR} >& train.log
#./train.sh ${APPS_DIR} ${DATA_DIR} ${WORK_DIR} train100p ${LANG_PAIR} >& train.log

end_time=`date +%s`
time=$((end_time - start_time))
echo "${time} (sec)" >& train.time.log

./eval.sh ${APPS_DIR} ${SCRIPT_DIR} ${DATA_DIR} ${WORK_DIR} ${LANG_PAIR} >& eval.log
