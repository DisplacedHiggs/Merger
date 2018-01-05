#!/bin/bash

maxfilesperjob_list=( 2 10 40 80 160 )
#or better to use result of previous hadd for next??

AOD_LIST_LOCATION=/uscms_data/d2/kreis/LLDJ/20171117_sort/Merger/makelists/mylists_aod/
OUT_DIR_ROOT=/uscmst1b_scratch/lpc1/3DayLifetime/kreis/merged_newegrecipe_jan3
eos_director="root://cmsxrootd.fnal.gov:"

sample="DY50_1"

for i in ${maxfilesperjob_list[@]}; do
    OUT_DIR=${OUT_DIR_ROOT}/hadd"${i}"
    #printf ${OUT_DIR}
    mkdir -p ${OUT_DIR}
    
    out_num=0
    split_count=0
    files="" 
    out_name=""
    while read p; do
        #echo $p
	
	if [ "$split_count" -lt "$i" ]
	then
            files="$files ${eos_director}/$p"
            split_count=$((split_count+1))
	else
	    out_name=${OUT_DIR}/${sample}_merged_${out_num}.root
            printf "hadd ${out_name} ${files}\n"
            files="${eos_director}/$p"
            split_count=1
            out_num=$((out_num+1))
	fi 
	
    done <${AOD_LIST_LOCATION}/${sample}.list
    out_name=${OUT_DIR}/${sample}_merged_${out_num}.root
    printf "hadd ${out_name} ${files}\n"

done