#!/bin/bash

# Makes a list of files in eos
# then greps through to separate into samples
# 
# output files are xxx/lists/<sample>.list
# formatted as one file per line: /store/group/xxx.root

# don't forget to source setup.sh (from xxx/LLDJstandalones)
listdir=mylists_mini
masterlist=allfiles.masterlist

#listdir=mylists_aod
#masterlist=allfilesAOD.masterlist

# only works from login.hep.wisc.edu
# ls  /hdfs/store/user/tmperry/rainday/*/*/*/*/*root > ${listdir}/allfiles.list

makealist () {
 printf "Making %s\n" $1
 fullsamplename=$(grep -i "$2" ${masterlist})
 printf "%s\n"  ${fullsamplename} > ${listdir}/$1.list
 sed -i -e "s@/hdfs@@" ${listdir}/$1.list
}

#makealist "DY50"                                "/DYJetsToLL_M-50_"


makealist "DY50_1" "DY50_1"
makealist "DY50_2" "DY50_2"
makealist "DY5to50_HT100to200_1" "DY5to50_HT100to200_1"
makealist "DY5to50_HT100to200_2" "DY5to50_HT100to200_2"
makealist "DY5to50_HT200to400_1" "DY5to50_HT200to400_1"
makealist "DY5to50_HT200to400_2" "DY5to50_HT200to400_2"
makealist "DY5to50_HT400to600_1" "DY5to50_HT400to600_1"
makealist "DY5to50_HT400to600_2" "DY5to50_HT400to600_2"
makealist "DY5to50_HT600toInf_1" "DY5to50_HT600toInf_1"
makealist "DY5to50_HT600toInf_2" "DY5to50_HT600toInf_2"
makealist "DY5to50_HT70to100" "DY5to50_HT70to100"
makealist "GJets_HT100to200_1" "GJets_HT100to200_1"
makealist "GJets_HT100to200_2" "GJets_HT100to200_2"
makealist "GJets_HT200to400_1" "GJets_HT200to400_1"
makealist "GJets_HT200to400_2" "GJets_HT200to400_2"
makealist "GJets_HT400to600_1" "GJets_HT400to600_1"
makealist "GJets_HT400to600_2" "GJets_HT400to600_2"
makealist "GJets_HT40to100_1" "GJets_HT40to100_1"
makealist "GJets_HT40to100_2" "GJets_HT40to100_2"
makealist "GJets_HT600toInf_1" "GJets_HT600toInf_1"
makealist "GJets_HT600toInf_2" "GJets_HT600toInf_2"
makealist "STs" "STs"
makealist "STtbar" "STtbar"
makealist "STt" "STt"
makealist "STtbarW_1" "STtbarW_1"
makealist "STtbarW_2" "STtbarW_2"
makealist "STtW_1" "STtW_1"
makealist "STtW_2" "STtW_2"
makealist "Data_SingleEle_B_1" "Data_SingleEle_B_1"
makealist "Data_SingleEle_B_2" "Data_SingleEle_B_2"
makealist "Data_SingleEle_C" "Data_SingleEle_C"
makealist "Data_SingleEle_D" "Data_SingleEle_D"
makealist "Data_SingleEle_E" "Data_SingleEle_E"
makealist "Data_SingleEle_F" "Data_SingleEle_F" 
makealist "Data_SingleEle_G"  "Data_SingleEle_G"
makealist "Data_SingleEle_H_2" "Data_SingleEle_H_2"
makealist "Data_SingleEle_H_3" "Data_SingleEle_H_3"
makealist "Data_SingleMu_B_1" "Data_SingleMu_B_1"
makealist "Data_SingleMu_B_2" "Data_SingleMu_B_2"
makealist "Data_SingleMu_C" "Data_SingleMu_C"
makealist "Data_SingleMu_D" "Data_SingleMu_D"
makealist "Data_SingleMu_E" "Data_SingleMu_E"
makealist "Data_SingleMu_F" "Data_SingleMu_F"
makealist "Data_SingleMu_G" "Data_SingleMu_G"
makealist "Data_SingleMu_H_2" "Data_SingleMu_H_2"
makealist "Data_SingleMu_H_3" "Data_SingleMu_H_3"
makealist "Data_SinglePhoton_B_2" "Data_SinglePhoton_B_2"
makealist "Data_SinglePhoton_D" "Data_SinglePhoton_D"
makealist "Data_SinglePhoton_E" "Data_SinglePhoton_E"
makealist "Data_SinglePhoton_F" "Data_SinglePhoton_F"
makealist "Data_SinglePhoton_G" "Data_SinglePhoton_G"
makealist "Data_SinglePhoton_H_2" "Data_SinglePhoton_H_2"
makealist "Data_SinglePhoton_H_3" "Data_SinglePhoton_H_3"
makealist "TTtoLL_1" "TTtoLL_1"
makealist "TTtoLL_2" "TTtoLL_2"
makealist "TTtoLfromT_1" "TTtoLfromT_1"
makealist "TTtoLfromT_2" "TTtoLfromT_2"
makealist "TTtoLfromTbar_1" "TTtoLfromTbar_1"
makealist "TTtoLfromTbar_2" "TTtoLfromTbar_2"
makealist "WG" "WG"
makealist "WJets_1" "WJets_1"
makealist "WJets_2" "WJets_2"
makealist "WWToLNuLNu" "WWToLNuLNu"
makealist "WWToLNuQQ_1" "WWToLNuQQ_1"
makealist "WWToLNuQQ_2" "WWToLNuQQ_2"
makealist "WZToLNuNuNu" "WZToLNuNuNu"
makealist "WZToLLLNu" "WZToLLLNu"
makealist "WZToLNu2QorQQ2L" "WZToLNu2QorQQ2L"
makealist "ZG" "ZG"
makealist "ZH_Hbb_1" "ZH_Hbb_1"
makealist "ZH_Hbb_2" "ZH_Hbb_2"
makealist "ZH_HToSSTobbbb_MS-15_ctauS-1000" "ZH_HToSSTobbbb_MS-15_ctauS-1000"
makealist "ZH_HToSSTobbbb_MS-15_ctauS-100" "ZH_HToSSTobbbb_MS-15_ctauS-100"
makealist "ZH_HToSSTobbbb_MS-15_ctauS-10" "ZH_HToSSTobbbb_MS-15_ctauS-10"
makealist "ZH_HToSSTobbbb_MS-15_ctauS-1" "ZH_HToSSTobbbb_MS-15_ctauS-1"
makealist "ZH_HToSSTobbbb_MS-40_ctauS-1000" "ZH_HToSSTobbbb_MS-40_ctauS-1000"
makealist "ZH_HToSSTobbbb_MS-40_ctauS-100" "ZH_HToSSTobbbb_MS-40_ctauS-100"
makealist "ZH_HToSSTobbbb_MS-40_ctauS-10" "ZH_HToSSTobbbb_MS-40_ctauS-10"
makealist "ZH_HToSSTobbbb_MS-40_ctauS-1" "ZH_HToSSTobbbb_MS-40_ctauS-1"
makealist "ZH_HToSSTobbbb_MS-55_ctauS-1000" "ZH_HToSSTobbbb_MS-55_ctauS-1000"
makealist "ZH_HToSSTobbbb_MS-55_ctauS-100" "ZH_HToSSTobbbb_MS-55_ctauS-100"
makealist "ZH_HToSSTobbbb_MS-55_ctauS-10" "ZH_HToSSTobbbb_MS-55_ctauS-10"
makealist "ZH_HToSSTobbbb_MS-55_ctauS-1" "ZH_HToSSTobbbb_MS-55_ctauS-1"
makealist "ZZToLLNuNu" "ZZToLLNuNu"
makealist "ZZToLLQQ" "ZZToLLQQ"
makealist "ZZToNuNuQQ" "ZZToNuNuQQ"
makealist "ZZToLLLL" "ZZToLLLL"
makealist "ggZH_Hbb_1" "ggZH_Hbb_1"   
makealist "ggZH_Hbb_2" "ggZH_Hbb_2" 
makealist "ggZH_Hbb_3" "ggZH_Hbb_3"
makealist "ggZH_HToSSTobbbb_MS-15_ctauS-1000" "ggZH_HToSSTobbbb_MS-15_ctauS-1000"
makealist "ggZH_HToSSTobbbb_MS-15_ctauS-100" "ggZH_HToSSTobbbb_MS-15_ctauS-100"
makealist "ggZH_HToSSTobbbb_MS-15_ctauS-10" "ggZH_HToSSTobbbb_MS-15_ctauS-10"
makealist "ggZH_HToSSTobbbb_MS-15_ctauS-1" "ggZH_HToSSTobbbb_MS-15_ctauS-1"
makealist "ggZH_HToSSTobbbb_MS-40_ctauS-1000" "ggZH_HToSSTobbbb_MS-40_ctauS-1000"
makealist "ggZH_HToSSTobbbb_MS-40_ctauS-100" "ggZH_HToSSTobbbb_MS-40_ctauS-100"
makealist "ggZH_HToSSTobbbb_MS-40_ctauS-10" "ggZH_HToSSTobbbb_MS-40_ctauS-10"
makealist "ggZH_HToSSTobbbb_MS-40_ctauS-1" "ggZH_HToSSTobbbb_MS-40_ctauS-1"
makealist "ggZH_HToSSTobbbb_MS-55_ctauS-1000" "ggZH_HToSSTobbbb_MS-55_ctauS-1000"
makealist "ggZH_HToSSTobbbb_MS-55_ctauS-100" "ggZH_HToSSTobbbb_MS-55_ctauS-100"
makealist "ggZH_HToSSTobbbb_MS-55_ctauS-10" "ggZH_HToSSTobbbb_MS-55_ctauS-10"
makealist "ggZH_HToSSTobbbb_MS-55_ctauS-1" "ggZH_HToSSTobbbb_MS-55_ctauS-1"
