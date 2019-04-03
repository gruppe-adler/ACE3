#include "script_component.hpp";

ISNILS(GVAR(refuelingNozzles), []);

_sm = [{GVAR(refuelingNozzles)}] call CBA_statemachine_fnc_create;
_state = [
    _sm,
    {
        if (CBA_MissionTime - (_this getVariable [GVAR(lastTickMissionTime), CBA_MissionTime]) < 0.2) exitWith {};
        _this call FUNC(stream);
    },
    {},
    {}
] call CBA_statemachine_fnc_createState;
