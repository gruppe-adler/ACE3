#include "script_component.hpp";

ISNILS(GVAR(refuelingNozzles), []);

_sm = [{GVAR(refuelingNozzles)}, true] call CBA_statemachine_fnc_create;
_state = [
    _sm,
    {
        private _sink = _this getVariable [GVAR(sink), objNull];
        private _source = _this getVariable [GVAR(source), objNull];
        if (CBA_MissionTime - (_this getVariable [GVAR(lastTickMissionTime), CBA_MissionTime]) < 0.2) exitWith {};
        _this call FUNC(stream);
    },
    {},
<<<<<<< HEAD
    {},
    "on"

] call CBA_statemachine_fnc_createState;


_state = [
    _sm,
    {},
    {},
    {},
    "off"
] call CBA_statemachine_fnc_createState;


_state = [
    _sm,
    {},
    { /*disconnect code, remove from state machine*/

    },
    {},
    "disconnected"
] call CBA_statemachine_fnc_createState;

_transition = [
    _sm,
    "on", "off",
    {
        !(_this getVariable[GVAR(switchedOn), false])
    },
    {
        _this setVariable [QGVAR(lastTickMissionTime), nil];
    }
] call CBA_statemachine_fnc_addTransition;


_transition = [
    _sm,
    "off", "on",
    {
        _this getVariable[GVAR(switchedOn), false]
    },
    {
        _this setVariable [QGVAR(lastTickMissionTime), CBA_missionTime];
    }
] call CBA_statemachine_fnc_addTransition;


_transition = [
    _sm,
    "on", "disconnected",
    {!(_this call FUNC(canStayConnected)},
    {}
] call CBA_statemachine_fnc_addTransition;


_transition = [
    _sm,
    "off", "disconnected",
    {!(_this call FUNC(canStayConnected)},
    {}
] call CBA_statemachine_fnc_addTransition;


// also:
// * listen to event when client connects the thing.
// -> thats it f yeah!

// no onTouch needed

=======
    {}
] call CBA_statemachine_fnc_addState;
>>>>>>> b0rked wip
