#!/bin/bash

TARGET="T1034"
TARGET_DIR="/projects/ccib/lamoureux/tr443/UrinXAlphaFold/${TARGET}_data"
TARGET_SEQ="${TARGET_DIR}/${TARGET}.seq" #fasta format
PLMDCA_DIR="plmDCA/plmDCA_asymmetric_v2/"
FILE_ALN="${TARGET_DIR}/${TARGET}.aln"
DATABASE_DIR="/scratch/tr443/prospr_data/hhblits/uniclust30_2018_08/uniclust30_2018_08"
#TARGET_OUT="${TARGET_DIR}/${TARGET}.pkl"


#generate domain crops from target seq
#python feature.py -s $TARGET_SEQ -c
#
#for domain in ${TARGET_DIR}/*.seq; do
#    out=${domain%.seq}
#    echo "Generate MSA files for ${out}"
#    hhblits -cpu 4 -i ${out}.seq -d ${DATABASE_DIR} -oa3m ${out}.a3m -ohhm ${out}.hhm -n 3
#    /home/tr443/anaconda3/scripts/reformat.pl ${out}.a3m ${out}.fas 
#    psiblast -subject ${out}.seq -in_msa ${out}.fas -out_ascii_pssm ${out}.pssm
#done

#make target features data and generate ungap target aln file for plmDCA
python feature.py -s $TARGET_SEQ -f

cd $PLMDCA_DIR
for aln in ${TARGET_DIR}/*.aln; do
    
    mat_file=$(echo $aln | cut -d"." -f 1).mat 
    if [ -f "$mat_file" ]; then
	echo "$mat_file exist"
    else 
	echo "calculate plmDCA for $mat_file"
	matlab -batch  "plmDCA('$aln')"
    fi

done
cd -

#run again to update target features data
python feature.py -s $TARGET_SEQ -f #-o $TARGET_OUT 
