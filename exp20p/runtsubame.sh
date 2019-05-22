#!/bin/sh

#$ -cwd
#$ -l q_node=1
#$ -l h_rt=0:10:0

. /etc/profile.d/modules.sh
module load cuda

./run.sh
