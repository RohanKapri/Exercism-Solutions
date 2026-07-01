#include "doctor_data.h"
#include <iostream>
using namespace std;
namespace heaven {
    Vessel heaven::Vessel::replicate(std::string pName){
	return Vessel(pName, generation += 1, current_system);
    }
    void heaven::Vessel::make_buster(){
	busters++;
    }
    bool heaven::Vessel::shoot_buster(){
	if(busters > 0){ 
	    busters--;
	    return true;
	} else { 
	    return false; 
	}
    }
    string get_older_bob(Vessel a, Vessel b){
	if(a.generation < b.generation){
	    return a.name;
	} else {
	    return b.name;
	}
    }
    bool in_the_same_system(Vessel a, Vessel b){
	if(a.current_system == b.current_system){
	    return true;
	} else {
	    return false;
	}
    }
}
