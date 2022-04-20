#include <stdio.h>
#include "csound.hpp"
#include <string>
#include <vector>
#include <cassert>
#include <iostream>
#include <fstream>
#include <sys/stat.h>

using namespace std;

class Iydhoti
{
public:
    Iydhoti()
    {
        this->orc = readFileIntoString("src/iydhoti.orc");
        this->sco = readFileIntoString("src/iydhoti_a.sco");
        this->scos.push_back(readFileIntoString("src/temp/Bass/Bass_a.sco"));
        this->scos.push_back(readFileIntoString("src/temp/Snares/Snare_a.sco"));
    }

    void run()
    {
        for(int i = 0; i < scos.size(); i++)
        {
            this->setOptions();
            this->play();
        }
    }

private:
    string readFileIntoString(const string& path)
    {
        ifstream input_file(path);

        if (!input_file.is_open())
        {
            cerr << "Could not open the file - '"
                << path << "'" << endl;
            exit(EXIT_FAILURE);
        }

        return string((istreambuf_iterator<char>(input_file)),
                       istreambuf_iterator<char>());
    }

    inline bool exists_test3 (const string& name)
    {
        struct stat buffer;
        return (stat (name.c_str(), &buffer) == 0);
    }

    void setOptions()
    {
        //sound.SetOption("-o audio.wav");
        sound.SetOption("-+jack_outportname=playback_1");
        sound.CompileOrc(this->orc.c_str());
        sound.ReadScore(this->sco.c_str());
    }

    void play()
    {
        sound.Start();
        sound.Perform();
    }

    string orc;
    string sco;
    vector<string> scos;
    Csound sound = Csound();
};

int main()
{
    Iydhoti t = Iydhoti();
    t.run();

    return 0;
}
