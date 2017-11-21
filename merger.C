#include <iostream>
#include <fstream>

#include "TFile.h"
#include "TTree.h"

using namespace std;

bool verbose = false;

void find_aod(int mini_run, Long64_t mini_event, std::vector<float> test){

  std::ifstream input("DY50.list", std::ifstream::in);
  TString aod_file_name;
  
  //This could be smarter -- start with last file, not closed until found to be wrong one
  while(input>>aod_file_name){
    aod_file_name.Remove(0, 10);
    if(verbose) cout << aod_file_name << endl;

    TFile *aod_file = TFile::Open("root://cmseos.fnal.gov://"+aod_file_name, "READ");
    if(aod_file->IsZombie()){
      cout << "aod_file is zombie" << endl;
      return;
    }
    TTree *aod_tree = (TTree*)aod_file->Get("lldjNtuple/EventTree");
    aod_tree->SetBranchStatus("*",     0);
    aod_tree->SetBranchStatus("run",   1);
    aod_tree->SetBranchStatus("event", 1);
    
    Long64_t aod_event;
    int aod_run;
    aod_tree->SetBranchAddress("run", &aod_run);
    aod_tree->SetBranchAddress("event", &aod_event);
    
    Long64_t nentries = aod_tree->GetEntries();
    for (Long64_t i = 0; i < nentries; i++) {
      aod_tree->GetEntry(i);
      
      if(aod_run != mini_run) continue;
      if(aod_event != mini_event) continue;
      
      if(verbose) cout << "Found match --  " << aod_file_name << endl;
      test.push_back(aod_event);//Change to real variable
      return;
    }    
  }
}


void merger(TString miniaod_file_name){

  //MiniAOD
  TFile *miniaod_file = TFile::Open(miniaod_file_name, "READ");
  if(miniaod_file->IsZombie()){
    cout << "miniaod_file is zombie" << endl;
    return;
  }
  TTree *miniaod_tree = (TTree*)miniaod_file->Get("lldjNtuple/EventTree");

  int miniaod_run;
  Long64_t miniaod_event;
  miniaod_tree->SetBranchAddress("run", &miniaod_run);
  miniaod_tree->SetBranchAddress("event", &miniaod_event);

  //Merged 
  TFile *merged_file = TFile::Open("merged.root", "RECREATE");
  TTree *merged_tree = miniaod_tree->CloneTree();

  //New branches for merged tree
  std::vector<float> test;
  TBranch* b_test = merged_tree->Branch("TEST", "vector<float>", &test);

  //Loop over MiniAOD
  Long64_t nentries = miniaod_tree->GetEntries();
  for (Long64_t i = 0; i < nentries; i++) {
    if(i%1000==0) cout << i << "/" << nentries << endl;

    miniaod_tree->GetEntry(i);
  
    //Clear new branches for merged tree
    test.clear();

    //Find aod
    find_aod(miniaod_run, miniaod_event, test);

    //Fill new branches
    b_test->Fill();
  }

  merged_file->Write();
  merged_file->Close();
  miniaod_file->Close();
  delete merged_file;
  delete miniaod_file;
}
