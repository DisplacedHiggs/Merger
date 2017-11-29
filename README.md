# Merger


## Interactively
```
root -l
.L merger.C++
merger("/eos/uscms/store/user/lpchbb/LLDJntuples/furwed/DYJetsToLL_M-50_TuneCUETP8M1_13TeV-madgraphMLM-pythia8/crab_DY50_1/171021_203643/0000/lldjntuple_mc_ww_1.root")
```

## With condor
First, do cmsenv in CMSSW area where LLDJ framework is set up.

Then, 
```
cd submitter
bash submitjobs.sh
```