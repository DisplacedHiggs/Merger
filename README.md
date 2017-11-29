# Merger


## Interactively
```
root -l
.L merger.C++
merger("/eos/uscms/store/group/lpchbb/LLDJntuples/splot/ZH_HToSSTobbbb_ZToLL_MH-125_MS-40_ctauS-10_TuneCUETP8M1_13TeV-powheg-pythia8/crab_ZH_HToSSTobbbb_MS-40_ctauS-10/171127_091316/0000/lldjntuple_mc_miniAOD_1.root", "aod.list")
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