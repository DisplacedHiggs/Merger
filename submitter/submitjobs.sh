#!/bin/bash


doSubmit=false
maxfilesperjob=1
submitdir="mysubmitdir_dec15"
root_outdir=root://cmseos.fnal.gov//store/user/lpchbb/LLDJntuples/merged/splot_bigHadd
AOD_LIST_LOCATION=/uscms_data/d2/kreis/LLDJ/20171117_sort/Merger/makelists/mylists_aod/
MINIAOD_LIST_LOCATION=/uscms_data/d2/kreis/LLDJ/20171117_sort/Merger/makelists/mylists_mini/

samples=(  \
 "DY50_1"                               \
 "DY50_2"                               \
 "DY5to50_HT100to200_1"                               \
 "DY5to50_HT100to200_2"                               \
 "DY5to50_HT200to400_1"                               \
 "DY5to50_HT200to400_2"                               \
 "DY5to50_HT400to600_1"                               \
 "DY5to50_HT400to600_2"                               \
 "DY5to50_HT600toInf_1"                               \
 "DY5to50_HT600toInf_2"                               \
 "DY5to50_HT70to100"                               \
 "GJets_HT100to200_1"                               \
 "GJets_HT100to200_2"                               \
 "GJets_HT200to400_1"                               \
 "GJets_HT200to400_2"                               \
 "GJets_HT400to600_1"                               \
 "GJets_HT400to600_2"                               \
 "GJets_HT40to100_1"                               \
 "GJets_HT40to100_2"                               \
 "GJets_HT600toInf_1"                               \
 "GJets_HT600toInf_2"                               \
 "STs"                               \
 "STtbar"                               \
 "STt"                               \
 "STtbarW_1"                               \
 "STtbarW_2"                               \
 "STtW_1"                               \
 "STtW_2"                               \
 "Data_SingleEle_B_1"                               \
 "Data_SingleEle_B_2"                               \
 "Data_SingleEle_C"                               \
 "Data_SingleEle_D"                               \
 "Data_SingleEle_E"                               \
 "Data_SingleEle_F"                               \
 "Data_SingleEle_G"                               \
 "Data_SingleEle_H_2"                               \
 "Data_SingleEle_H_3"                               \
 "Data_SingleMu_B_1"                               \
 "Data_SingleMu_B_2"                               \
 "Data_SingleMu_C"                               \
 "Data_SingleMu_D"                               \
 "Data_SingleMu_E"                               \
 "Data_SingleMu_F"                               \
 "Data_SingleMu_G"                               \
 "Data_SingleMu_H_2"                               \
 "Data_SingleMu_H_3"                               \
 "Data_SinglePhoton_B_2"                               \
 "Data_SinglePhoton_D"                               \
 "Data_SinglePhoton_E"                               \
 "Data_SinglePhoton_F"                               \
 "Data_SinglePhoton_G"                               \
 "Data_SinglePhoton_H_2"                               \
 "Data_SinglePhoton_H_3"                               \
 "TTtoLL_1"                               \
 "TTtoLL_2"                               \
 "TTtoLfromT_1"                               \
 "TTtoLfromT_2"                               \
 "TTtoLfromTbar_1"                               \
 "TTtoLfromTbar_2"                               \
 "WG"                               \
 "WJets_1"                               \
 "WJets_2"                               \
 "WWToLNuLNu"                               \
 "WWToLNuQQ_1"                               \
 "WWToLNuQQ_2"                               \
 "WZToLNuNuNu"                               \
 "WZToLLLNu"                               \
 "WZToLNu2QorQQ2L"                               \
 "ZG"                               \
 "ZH_Hbb_1"                               \
 "ZH_Hbb_2"                               \
 "ZH_HToSSTobbbb_MS-15_ctauS-1000"                               \
 "ZH_HToSSTobbbb_MS-15_ctauS-100"                               \
 "ZH_HToSSTobbbb_MS-15_ctauS-10"                               \
 "ZH_HToSSTobbbb_MS-15_ctauS-1"                               \
 "ZH_HToSSTobbbb_MS-40_ctauS-1000"                               \
 "ZH_HToSSTobbbb_MS-40_ctauS-100"                               \
 "ZH_HToSSTobbbb_MS-40_ctauS-10"                               \
 "ZH_HToSSTobbbb_MS-40_ctauS-1"                               \
 "ZH_HToSSTobbbb_MS-55_ctauS-1000"                               \
 "ZH_HToSSTobbbb_MS-55_ctauS-100"                               \
 "ZH_HToSSTobbbb_MS-55_ctauS-10"                               \
 "ZH_HToSSTobbbb_MS-55_ctauS-1"                               \
 "ZZToLLNuNu"                               \
 "ZZToLLQQ"                               \
 "ZZToNuNuQQ"                               \
 "ZZToLLLL"                               \
 "ggZH_Hbb_1"                               \
 "ggZH_Hbb_2"                               \
 "ggZH_Hbb_3"                               \
 "ggZH_HToSSTobbbb_MS-15_ctauS-1000"                               \
 "ggZH_HToSSTobbbb_MS-15_ctauS-100"                               \
 "ggZH_HToSSTobbbb_MS-15_ctauS-10"                               \
 "ggZH_HToSSTobbbb_MS-15_ctauS-1"                               \
 "ggZH_HToSSTobbbb_MS-40_ctauS-1000"                               \
 "ggZH_HToSSTobbbb_MS-40_ctauS-100"                               \
 "ggZH_HToSSTobbbb_MS-40_ctauS-10"                               \
 "ggZH_HToSSTobbbb_MS-40_ctauS-1"                               \
 "ggZH_HToSSTobbbb_MS-55_ctauS-1000"                               \
 "ggZH_HToSSTobbbb_MS-55_ctauS-100"                               \
 "ggZH_HToSSTobbbb_MS-55_ctauS-10"                               \
 "ggZH_HToSSTobbbb_MS-55_ctauS-1"                               \
)


# tar up your present CMSSW area
#if [ ! -f ${CMSSW_VERSION}.tar.gz ] 
#then 
#   tar --exclude-caches-all --exclude-vcs -zcf ${CMSSW_VERSION}.tar.gz -C ${CMSSW_BASE}/.. ${CMSSW_BASE} --exclude=src --exclude=tmp
#fi


makeasubmitdir () {
 printf "Making submits for $1\n"
 
 #Make output stuff 
 mkdir -p ${submitdir}/$1
 mkdir -p ${submitdir}/$1/logs

 outdir=${root_outdir}/$1

 submitfile=${submitdir}/submit_$1.condor 
 
 # write base for submit file
 printf "universe = vanilla\n" > $submitfile
 printf "Executable = ../runjob.sh\n" >> $submitfile
 printf "Should_Transfer_Files = YES \n" >> $submitfile
 printf "WhenToTransferOutput = ON_EXIT_OR_EVICT\n" >> $submitfile
 printf "Transfer_Input_Files = ../runjob.sh, ../../merger.C, ${AOD_LIST_LOCATION}/$1.list\n" >> $submitfile
 printf "Notification=Never\n" >> $submitfile
 printf "notify_user = $(whoami)@cern.ch\n" >> $submitfile
 printf "request_memory = 8000\n" >> $submitfile
 printf "x509userproxy = $X509_USER_PROXY\n" >> $submitfile
 printf "Output = $1/logs/merger_\$(Cluster)_\$(Process).stdout\n" >> $submitfile
 printf "Error  = $1/logs/merger_\$(Cluster)_\$(Process).stderr\n" >> $submitfile
 printf "Log    = $1/logs/merger_\$(Cluster)_\$(Process).log\n" >> $submitfile
 printf "\n" >> $submitfile
 
 split_count=0
 files="" 
 # breaking up input file list
 while read p; do
     #echo $p
     
     if [ "$split_count" -lt "$maxfilesperjob" ]
     then
	 files="$files $p"
	 split_count=$((split_count+1))
     else
	 printf "Arguments = $1 ${outdir} ${files}\n" >> $submitfile
	 printf "Queue\n" >> $submitfile
	 printf "\n" >> $submitfile
	 files="$p"
	 split_count=1
     fi     

 done <${MINIAOD_LIST_LOCATION}/$1.list

 printf "Arguments = $1 ${outdir} ${files}\n" >> $submitfile
 printf "Queue\n" >> $submitfile
 printf "\n" >> $submitfile

 
 if [ ${doSubmit} = true ]
 then
  condor_submit $submitfile
 fi
 
}


# actually call the function
for sample in ${samples[@]} 
do
 makeasubmitdir ${sample}
done

