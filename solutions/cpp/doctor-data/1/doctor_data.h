#pragma once
#include <string> 
namespace star_map {
    enum System {
	BetaHydri,
	Sol,
	EpsilonEridani,
	AlphaCentauri,
	DeltaEridani,
	Omicron2Eridani
    };
}
namespace heaven {
    class Vessel{
	public: 
	    int busters = 0;
	    int generation = 0;
	    std::string name;
	    star_map::System current_system;
	    Vessel(std::string pName, int pGeneration, star_map::System pSystem = star_map::System::Sol){
		name = pName;
		generation = pGeneration;
		current_system = pSystem;
	    }
	    Vessel replicate(std::string pName);
	    void make_buster();
	    bool shoot_buster();
	};
    std::string get_older_bob(Vessel a, Vessel b);
    bool in_the_same_system(Vessel a, Vessel b);
}
