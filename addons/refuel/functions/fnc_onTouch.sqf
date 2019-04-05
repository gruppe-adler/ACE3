#include "script_component.hpp"
/*

* FUNC(onTouch)
    * creates PFH that checks a tank (in its role as source), and calls FUNC(stream) on every one of them
    * PFH gets stored in a namespace within missionNamespace (like, GVAR(flows) containing a map of sink => pfh

    * self-removes if not connected to anything for $timeout (uncritical, could be as less as 1s, could be as much as a minute? it's more a GC thing)


how about
- on server, have a PFH that runs every GVAR(tickTime)
- throws


    */

params [
    ["_sink", objNull]
];

// TODO does this work that way?
ISNILS(GVAR(sourcePfhs), [] call CBA_fnc_createNamespace);



GVAR(sourcePfhs) getVariable [_sink, CBA_MissionTime];
