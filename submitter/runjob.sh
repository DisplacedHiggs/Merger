#!/bin/bash

MAINDIR=`pwd`
ls

export VO_CMS_SW_DIR=/cvmfs/cms.cern.ch
export COIN_FULL_INDIRECT_RENDERING=1
echo $VO_CMS_SW_DIR
source $VO_CMS_SW_DIR/cmsset_default.sh
export SCRAM_ARCH=slc6_amd64_gcc493
tar xzf CMSSW_8_0_26_patch1.tar.gz
cd CMSSW_8_0_26_patch1/src
scram b ProjectRename
eval `scramv1 runtime -sh`
cd -

for var in "$@"
do
    echo "$var"
    #xrdcp
    root -l -b -q "merger.C+(\"$var\")"
    #xrdcp
done

echo "Inside $MAINDIR:"
ls
echo "DELETING..."
rm *.root
rm *.C
rm -r CMSSW_8_0_26_patch1
rm CMSSW_8_0_26_patch1.tar.gz
ls