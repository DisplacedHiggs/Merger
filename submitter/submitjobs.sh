#!/bin/bash


doSubmit=false
maxfilesperjob=1
outdir=root://cmseos.fnal.gov//store/user/lpchbb/LLDJntuples/merged
AOD_LIST_LOCATION=/uscms_data/d2/kreis/LLDJ/20171117_sort/Merger/submitter/lists/aod/
MINIAOD_LIST_LOCATION=/uscms_data/d2/kreis/LLDJ/20171117_sort/Merger/submitter/lists/miniaod/

samples=(  \
 "DY50"                               \
)


# tar up your present CMSSW area
#if [ ! -f ${CMSSW_VERSION}.tar.gz ] 
#then 
#   tar --exclude-caches-all --exclude-vcs -zcf ${CMSSW_VERSION}.tar.gz -C ${CMSSW_BASE}/.. ${CMSSW_BASE} --exclude=src --exclude=tmp
#fi


makeasubmitdir () {
 printf "Making submits for $1\n"
 
 #Make output stuff 
 submitdir="submitdir"
 mkdir -p ${submitdir}/$1
 mkdir -p ${submitdir}/$1/logs

 outdir=${outdir}/$1

 submitfile=${submitdir}/submit_$1.condor 
 
 # write base for submit file
 printf "universe = vanilla\n" > $submitfile
 printf "Executable = ../runjob.sh\n" >> $submitfile
 printf "Should_Transfer_Files = YES \n" >> $submitfile
 printf "WhenToTransferOutput = ON_EXIT_OR_EVICT\n" >> $submitfile
 printf "Transfer_Input_Files = ../runjob.sh, ../../merger.C, ${AOD_LIST_LOCATION}/$1.list\n" >> $submitfile
 printf "Notification=Never\n" >> $submitfile
 printf "notify_user = $(whoami)@cern.ch\n" >> $submitfile
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
	 printf "Arguments = ${outdir} ${files}\n" >> $submitfile
	 printf "Queue\n" >> $submitfile
	 printf "\n" >> $submitfile
	 files="$p"
	 split_count=1
     fi     

 done <${MINIAOD_LIST_LOCATION}/$1.list

 printf "Arguments = ${outdir} ${files}\n" >> $submitfile
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

