#include <stdio.h>
#include "csound.hpp"
#include <string>
#include <vector>
#include <cassert>
#include <iostream>
#include <fstream>
#include <sys/stat.h>

using namespace std;

class Iydhoti{
  private:
	string orc;
	string sco;
	vector<string> scos;
	Csound* sound;

	string readFileIntoString(const string& path) {
      ifstream input_file(path);
      if (!input_file.is_open()) {
        cerr << "Could not open the file - '"
          << path << "'" << endl;
       exit(EXIT_FAILURE);
      }
      return string((istreambuf_iterator<char>(input_file)), 
      		 istreambuf_iterator<char>());
    }

	inline bool exists_test3 (const string& name) {
	  struct stat buffer;   
	  return (stat (name.c_str(), &buffer) == 0); 
	}

	void setOptions(string s){
	  string output("-oaudio{s}.wav", s);
      sound->SetOption("-oaudio.wav");
      sound->CompileOrc(this->orc.c_str());
      sound->ReadScore(this->sco.c_str());
	}

	void play(){
      sound->Start();
      sound->Perform();	
      delete sound;
	}

  public: 
	Iydhoti(){
	  sound = new Csound();
	  this->orc = readFileIntoString("src/1.orc"); 
//	  this->sco = readFileIntoString("src/bass.sco");
	  this->scos.push_back(readFileIntoString("src/bass.sco"));
	  this->scos.push_back(readFileIntoString("src/snare.sco"));
	}

	void run(){
	  //for(int i=0; i < scos.size(); i++){
	   // this->setOptions(to_string(42));
	    //this->play();
	  //}
    }
};

int main(){
  Iydhoti t = Iydhoti(); 
  t.run();
  return 0;
}
