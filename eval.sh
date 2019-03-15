#!/bin/sh

ROOTDIR=${1}
DATADIR=${2}
WORKDIR=${3}
MODELS=${WORKDIR}/models
DATASET=${DATADIR}/kftt-data-1.0/data/tok
OUTDIR=${WORKDIR}/outputs
USRDIR=${WORKDIR}/input
suffix="en-ja ja-en"

if [ ! -e ${OUTDIR} ]
then
    mkdir -p ${OUTDIR}
fi

cd ${ROOTDIR}/apps/OpenNMT-py
for lang_pair in ${suffix}; do
    src=`echo ${lang_pair} | awk -F"-" '{print $1}'`
    trg=`echo ${lang_pair} | awk -F"-" '{print $2}'`
    python translate.py \
        -model ${MODELS}/${lang_pair}_step_30000.pt \
        -src ${DATASET}/kyoto-test.${src} \
        -output ${OUTDIR}/test.${trg} \
        -gpu 0 \
        -beam_size 1 \
        -batch_size 512 \
        -verbose
    perl ${ROOTDIR}/scripts/multi-bleu.perl \
        ${DATASET}/kyoto-test.${trg} \
        < ${OUTDIR}/test.${trg} \
        > ${OUTDIR}/result_${lang_pair}.bleu
done
if [ ! -e ${USRDIR} ]
then
    echo "${USRDIR} does not exist."
    exit
fi
for lang_pair in ${suffix}; do
    src=`echo ${lang_pair} | awk -F"-" '{print $1}'`
    trg=`echo ${lang_pair} | awk -F"-" '{print $2}'`
    if [ ${src} = "ja" -a ${src} != "en" ]
    then
        # Tokenize Japanese sentences
        bash ${ROOTDIR}/apps/kytea-0.4.7/src/bin/kytea \
        < ${USRDIR}/user.${src} |\
        sed 's/\/[^ ]\+//g' \
        > ${USRDIR}/user.tok.${src}
    elif [ ${src} = "en" -a ${src} != "ja" ]
    then
        # Tokenize English sentences
        perl ${ROOTDIR}/apps/mosesdecoder/scripts/tokenizer/tokenizer.perl \
        -l en \
        < ${USRDIR}/user.${src} \
        > ${USRDIR}/user.tok.${src}
    else
	echo "Language: ${src} is undefined."
        continue
    fi
    python translate.py \
        -model ${MODELS}/${lang_pair}_step_30000.pt \
        -src ${USRDIR}/user.tok.${src} \
        -output ${OUTDIR}/user.${trg} \
        -gpu 0 \
        -beam_size 1 \
        -batch_size 512 \
        -verbose
done
