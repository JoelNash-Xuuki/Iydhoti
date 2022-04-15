#include <stdio.h>
#include <iostream>
#include "csound.hpp"
#include <string>

using namespace std;

string testGetFileContents(const char *filename){
      FILE *fp = fopen(filename, "rb");
	  if(fp){
	    string contents = filename;
		fseek(fp, 0, SEEK_END);
		rewind(fp);
		fread(&contents[0], 1, contents.size(), fp);
		return (contents);
      }
	  throw(errno);
    }


int main(){
  string testcsd= testGetFileContents("test.csd");
  //Create an instance of Csound
  Csound* csound = new Csound();
  
  //compile instance of csound.
  csound->CompileCsd("test.csd");
  
  //prepare Csound for performance
  csound->Start();
  
  //perform entire score
  csound->Perform();	
  
  //free Csound object
  delete csound;
  
  return 0;
}

