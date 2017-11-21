#include <iostream>
#include <fstream>

#include "TFile.h"
#include "TTree.h"

using namespace std;

bool verbose = false;

void find_aod(std::vector<TString> aod_list, unsigned int &start_suggest, int mini_run, Long64_t mini_event, std::vector<float> test){

  //Loop over AOD file list
  unsigned int N = aod_list.size();
  for(unsigned int i=0; i<N; i++){

    //Start with suggestion from last match
    unsigned int f = start_suggest + i;
    if(f >= N ) f = f - N; 
    if(verbose && i==0) cout << "Starting search for Run " << mini_run << " Event " << mini_event << " at file " << f << endl;
    if(verbose) cout << "Loop: " << f << endl;

    TFile *aod_file = TFile::Open("root://cmseos.fnal.gov://"+aod_list[f], "READ");
    if(aod_file->IsZombie()){
      cout << "aod_file is zombie" << endl;
      return;
    }
    
    //Only get what you need from AOD file
    TTree *aod_tree = (TTree*)aod_file->Get("lldjNtuple/EventTree");
    aod_tree->SetBranchStatus("*",     0);
    aod_tree->SetBranchStatus("run",   1);
    aod_tree->SetBranchStatus("event", 1);
    
    Long64_t aod_event;
    int aod_run;
    aod_tree->SetBranchAddress("run", &aod_run);
    aod_tree->SetBranchAddress("event", &aod_event);
    
    //Loop through AOD tree
    Long64_t nentries = aod_tree->GetEntries();
    for (Long64_t j = 0; j < nentries; j++) {
      aod_tree->GetEntry(j);
      
      if(aod_run != mini_run) continue;
      if(aod_event != mini_event) continue;
      
      //Matched!
      if(verbose) cout << "Found match --  " << aod_list[f] << endl;
      test.push_back(aod_event);//Change to real variable
      start_suggest = f;
      return;
    }    
  }
}



void merger(TString miniaod_file_name){

  //////////////////////////////
  // List of AOD files
  //////////////////////////////
  std::vector<TString> aod_list;
  std::ifstream input("DY50.list", std::ifstream::in);
  TString aod_file_name;
  while(input>>aod_file_name){
    aod_file_name.Remove(0, 10);
    aod_list.push_back(aod_file_name);
  }
  unsigned int start_suggest = 0;

  //////////////////////////////
  // MiniAOD
  //////////////////////////////
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

  
  /////////////////////////////
  // Merged output
  /////////////////////////////
  TFile *merged_file = TFile::Open("merged.root", "RECREATE");
  TTree *merged_tree = miniaod_tree->CloneTree();

  //New branches for merged tree
  std::vector<float> test;
  TBranch* b_test = merged_tree->Branch("TEST", "vector<float>", &test);


  /////////////////////////////
  // Loop over MiniAOD
  /////////////////////////////
  Long64_t nentries = miniaod_tree->GetEntries();
  for (Long64_t i = 0; i < nentries; i++) {
    if(i%1000==0) cout << i << "/" << nentries << endl;

    miniaod_tree->GetEntry(i);
  
    //Clear new branches for merged tree
    test.clear();

    //Find aod
    find_aod(aod_list, start_suggest, miniaod_run, miniaod_event, test);
    
    //Fill new branches
    b_test->Fill();
  }

  merged_file->Write();
  merged_file->Close();
  miniaod_file->Close();
  delete merged_file;
  delete miniaod_file;
}
