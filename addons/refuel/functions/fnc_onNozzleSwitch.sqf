#include "script_component.hpp"

params [
    ["_nozzle", objNull],
    ["_switchState", true, [true, false]]
];

_nozzle setVariable [QGVAR(isRefueling), _switchState, true];

ISNILS(GVAR(watchedNozzles), []);

if (_switchState) then {
    _nozzle setVariable [QGVAR(lastTickMissionTime), CBA_MissionTime];
    GVAR(watchedNozzles) pushBackUnique _nozzle;
} else {
    _nozzle setVariable [QGVAR(lastTickMissionTime), nil];
    GVAR(watchedNozzles) deleteAt (GVAR(watchedNozzles) find _nozzle);
};
