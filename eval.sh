#!/bin/sh

ROOT_DIR=${1}
DATA_DIR=${2}
WORK_DIR=${3}
MODELS=${WORK_DIR}/models
DATASET=${DATA_DIR}/kftt-data-1.0/data/tok
OUT_DIR=${WORK_DIR}/outputs
USRDIR=${WORK_DIR}/input
SCORE_PATH=$(cd $(dirname $0); pwd)/score.txt
suffix="en-ja ja-en"

if [ ! -e ${OUT_DIR} ]
then
    mkdir -p ${OUT_DIR}
fi

cd ${ROOT_DIR}/apps/OpenNMT-py
for lang_pair in ${suffix}; do
    src=`echo ${lang_pair} | awk -F"-" '{print $1}'`
    trg=`echo ${lang_pair} | awk -F"-" '{print $2}'`
    python translate.py \
        -model ${MODELS}/${lang_pair}_final.pt \
        -src ${DATASET}/kyoto-test.${src} \
        -output ${OUT_DIR}/test.${trg} \
        -gpu 0 \
        -beam_size 1 \
        -batch_size 512 \
        -verbose
    perl ${ROOT_DIR}/scripts/multi-bleu.perl \
        ${DATASET}/kyoto-test.${trg} \
        < ${OUT_DIR}/test.${trg} \
        > ${OUT_DIR}/result_${lang_pair}.bleu
done
cp ${OUT_DIR}/result_en-ja.bleu ${SCORE_PATH}
if [ ! -e ${USRDIR}/user.en ]
then
    echo "${USRDIR}/user.en does not exist."
    exit
fi
if [ ! -e ${USRDIR}/user.ja ]
then
    echo "${USRDIR}/user.ja does not exist."
    exit
fi
for lang_pair in ${suffix}; do
    src=`echo ${lang_pair} | awk -F"-" '{print $1}'`
    trg=`echo ${lang_pair} | awk -F"-" '{print $2}'`
    if [ ${src} = "ja" -a ${src} != "en" ]
    then
        # Tokenize Japanese sentences
        bash ${ROOT_DIR}/apps/kytea-0.4.7/src/bin/kytea \
        < ${USRDIR}/user.${src} |\
        sed 's/\/[^ ]\+//g' \
        > ${USRDIR}/user.tok.${src}
    elif [ ${src} = "en" -a ${src} != "ja" ]
    then
        # Tokenize English sentences
        perl ${ROOT_DIR}/apps/mosesdecoder/scripts/tokenizer/tokenizer.perl \
        -l en \
        < ${USRDIR}/user.${src} \
        > ${USRDIR}/user.tok.${src}
    else
	echo "Language: ${src} is undefined."
        continue
    fi
    python translate.py \
        -model ${MODELS}/${lang_pair}_final.pt \
        -src ${USRDIR}/user.tok.${src} \
        -output ${OUT_DIR}/user.${trg} \
        -gpu 0 \
        -beam_size 1 \
        -batch_size 512 \
        -verbose
done
