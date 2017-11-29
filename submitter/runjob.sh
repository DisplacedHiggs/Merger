#!/bin/bash

date

MAINDIR=`pwd`
ls

#If tarballing release
#export VO_CMS_SW_DIR=/cvmfs/cms.cern.ch
#export COIN_FULL_INDIRECT_RENDERING=1
#echo $VO_CMS_SW_DIR
#source $VO_CMS_SW_DIR/cmsset_default.sh
#export SCRAM_ARCH=slc6_amd64_gcc493
#tar xzf CMSSW_8_0_26_patch1.tar.gz
#cd CMSSW_8_0_26_patch1/src
#scram b ProjectRename
#eval `scramv1 runtime -sh`
#cd -

#CMSSW from scratch (only need for root)
export PATH=${PATH}:/cvmfs/cms.cern.ch/common
export CMS_PATH=/cvmfs/cms.cern.ch
export SCRAM_ARCH=slc6_amd64_gcc530
scramv1 project CMSSW CMSSW_8_0_26_patch2
cd CMSSW_8_0_26_patch2/src
eval `scramv1 runtime -sh` # cmsenv
cd -

argument_counter=0
for var in "$@"
do

    if [ $argument_counter -eq 0 ]
    then
	argument_counter=1
    else
        #echo "$var"
        #For now, inputs are accessed from EOS directly, not xrdcp'ed
	root -l -b -q "merger.C+(\"$var\")"

	for f in merged_*.root; do
	    xrdcp $f $1/$f 
	    rm merged_*.root
	done
    fi
done

echo "Inside $MAINDIR:"
ls
echo "DELETING..."
rm merger*
rm -r CMSSW_8_0_26_patch2
#rm CMSSW_8_0_26_patch2.tar.gz
ls

date