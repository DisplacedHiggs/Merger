# Merger


## Interactively
```
root -l
.L merger.C++
merger("/store/group/lpchbb/LLDJntuples/splot/DYJetsToLL_M-50_TuneCUETP8M1_13TeV-madgraphMLM-pythia8/crab_DY50_1/171127_101103/0000/lldjntuple_mc_miniAOD_1.root", "aod.list")
```

## With condor
First, do cmsenv in CMSSW area where LLDJ framework is set up, and set options [here](https://github.com/DisplacedHiggs/Merger/blob/master/submitter/submitjobs.sh#L4-L8).

Then, 
```
cd submitter
bash submitjobs.sh
```

## Notes
At least for now, inputs are opened from EOS directly rather than xrdcp'ed to worker nodes.  
