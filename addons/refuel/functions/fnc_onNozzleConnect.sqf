#include "script_component.hpp"

params [
    ["_nozzle", objNull],
    ["_switchState", true, [true, false]]
];

_nozzle setVariable [QGVAR(isRefueling), _switchState, true];

ISNILS(GVAR(watchedNozzles), []);

if (_switchState) then {
    GVAR(watchedNozzles) pushBackUnique _nozzle;
} else {
    //     GVAR(watchedNozzles) deleteAt (GVAR(watchedNozzles) find _nozzle);
    // no. do manual transition to disconnected instead
    [

    ] call CBA_statemachine_fnc_manualTransition; // TODO do.


};
