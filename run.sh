#!/bin/sh

echo "start"
if [ -e "run.log" ] ;then
    echo "log exist, delete"
    rm run.log
fi

qsub -g tga-egliteracy -o run.log -e run.log /gs/hs0/tga-egliteracy/egs/seq2seq/worker.sh

