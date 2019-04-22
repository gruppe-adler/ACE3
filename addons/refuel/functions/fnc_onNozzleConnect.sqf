#include "script_component.hpp"

params [
    ["_nozzle", objNull],
    ["_switchState", true, [true, false]]
];

_nozzle setVariable [QGVAR(isRefueling), _switchState, true];

ISNILS(GVAR(connectedNozzles), []);

if (_switchState) then {
    GVAR(connectedNozzles) pushBackUnique _nozzle;
} else {
    [
        _nozzle,
        GVAR(clockwork),
        "connected",
        "disconnected",
        {},
        "manualDisconnect"
    ] call CBA_statemachine_fnc_manualTransition;
};
