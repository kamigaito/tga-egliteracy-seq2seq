#!/bin/sh

APPS_DIR=${1}
SCRIPT_DIR=${2}
DATA_DIR=${3}
WORK_DIR=${4}
LANG_PAIR=${5}
MODELS=${WORK_DIR}/models
DATASET=${DATA_DIR}/kftt-data-1.0/data/tok
OUT_DIR=${WORK_DIR}/outputs
USRDIR=${WORK_DIR}/input
SCORE_PATH=$(cd $(dirname $0); pwd)/score.txt

if [ ! -e ${OUT_DIR} ]
then
    mkdir -p ${OUT_DIR}
fi

cd ${APPS_DIR}/OpenNMT-py

src=`echo ${LANG_PAIR} | awk -F"-" '{print $1}'`
trg=`echo ${LANG_PAIR} | awk -F"-" '{print $2}'`
python translate.py \
    -model ${MODELS}/${LANG_PAIR}_final.pt \
    -src ${DATASET}/kyoto-test.${src} \
    -output ${OUT_DIR}/test.${trg} \
    -gpu 0 \
    -beam_size 1 \
    -batch_size 512 \
    -verbose
perl ${SCRIPT_DIR}/multi-bleu.perl \
    ${DATASET}/kyoto-test.${trg} \
    < ${OUT_DIR}/test.${trg} \
    > ${OUT_DIR}/result_${LANG_PAIR}.bleu

cat ${OUT_DIR}/result_${LANG_PAIR}.bleu | sed -r 's/(BLEU = [0-9]*\.[0-9]*), .*/\1/g' > ${SCORE_PATH}
if [ ! -e ${USRDIR}/user.${src} ]
then
    echo "${USRDIR}/user.${src} does not exist."
    exit
fi

if [ ${src} = "ja" -a ${src} != "en" ]
then
    # Tokenize Japanese sentences
    bash ${APPS_DIR}/kytea-0.4.7/src/bin/kytea \
    < ${USRDIR}/user.${src} |\
    sed 's/\/[^ ]\+//g' \
    > ${USRDIR}/user.tok.${src}
elif [ ${src} = "en" -a ${src} != "ja" ]
then
    # Tokenize English sentences
    perl ${APPS_DIR}/mosesdecoder/scripts/tokenizer/tokenizer.perl \
    -l en \
    < ${USRDIR}/user.${src} \
    > ${USRDIR}/user.tok.${src}
else
echo "Language: ${src} is undefined."
    continue
fi
python translate.py \
    -model ${MODELS}/${LANG_PAIR}_final.pt \
    -src ${USRDIR}/user.tok.${src} \
    -output ${OUT_DIR}/user.${trg} \
    -gpu 0 \
    -beam_size 1 \
    -batch_size 512 \
    -verbose
