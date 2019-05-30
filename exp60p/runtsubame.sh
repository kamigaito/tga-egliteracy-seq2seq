#!/bin/sh

#$ -cwd
#$ -l q_node=1
#$ -l h_rt=0:10:0

. /etc/profile.d/modules.sh
module load cuda

source /gs/hs0/tga-egliteracy/egs/seq2seq/.bashrc
/usr/bin/env

./run.sh
