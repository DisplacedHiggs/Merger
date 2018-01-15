#!/bin/bash

# straight ls is too big
# ls  /hdfs/store/user/tmperry/rainday/*/*/*/*/*root > ./allfiles.list

# define output directory where lists will end up
outdir="."

# make outlist of directories
#ls -d /hdfs/store/user/tmperry/sosou/*/ > ${outdir}/dirout.list
#eosls -d root://cmseos.fnal.gov//store/group/lpchbb/LLDJntuples/furwed/* > ${outdir}/dirout.list
#eos root://cmseos.fnal.gov ls -d /store/user/lpchbb/LLDJntuples/furwed/*/ > ${outdir}/dirout.list

#xrdfs root://cmseos.fnal.gov ls /eos/uscms/store/user/lpchbb/LLDJntuples/furwed/ > ${outdir}/dirout.list
#tempbase = ${CMSSW_BASE}/src/commontools
#isAOD=false
#dir=/store/group/lpchbb/LLDJntuples/ninejan

isAOD=true
dir=/store/group/lpchbb/LLDJntuples/newegrecipeAOD/

xrdfs root://cmseos.fnal.gov ls ${dir} > templayer1.out #${outdir}/dirout.list

extra=""
if [ "$isAOD" = true ]; then
    extra="AOD"
fi


# initialize outfile as empty (overwrite if exists)
echo "" > ${outdir}/allfiles${extra}.masterlist

for lineone in $(cat templayer1.out);
do
 
 xrdfs root://cmseos.fnal.gov ls ${lineone} > templayer2.out  
 echo "Text read from file: ${depot}${nversion}/${lineone}"
 for linetwo in $(cat templayer2.out)
 do
 
  xrdfs root://cmseos.fnal.gov ls ${linetwo} > templayer3.out
  for linethree in $(cat templayer3.out)
  do
  
   xrdfs root://cmseos.fnal.gov ls ${linethree} > templayer4.out
   for linefour in $(cat templayer4.out)
   do 
   
   xrdfs root://cmseos.fnal.gov ls ${linefour} | grep ".root" >> ${outdir}/allfiles${extra}.masterlist 
   done
  done
 done
done



#old way half-way works
# # ls on each directory individually, add to allfiles.list
# while IFS='' read -r line || [[ -n "$line" ]]; do
#     echo "Text read from file: $line"
#     #eos root://cmseos.fnal.gov ls ${line}/*/*/*/*root >> ${outdir}/allfiles.masterlist
#     #xrdfs root://cmseos.fnal.gov ls ${line}/*/*/*/* >> ${outdir}/allfiles.masterlist
#     #ls ${line}/*/*/*/*root >> ${outdir}/allfiles.masterlist
#     
# 
#     #ls -d  ${line}*/*/*/*/* >> ${outdir}/allfiles.masterlist
#     #xrdfs root://cmseos.fnal.gov ls -d  ${line}*/*/*/*/* >> ${outdir}/allfiles.masterlist
#     xrdfs root://cmseos.fnal.gov// ls -d ${line}*/*/*/* >> ${outdir}/allfiles.masterlist
#     
# 
# done < ${outdir}/dirout.list



