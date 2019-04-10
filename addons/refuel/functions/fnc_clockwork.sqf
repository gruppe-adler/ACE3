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
    {!(_this getVariable[GVAR(switchedOn), false])},
    {}
] call CBA_statemachine_fnc_addTransition;


_transition = [
    _sm,
    "off", "on",
    {_this getVariable[GVAR(switchedOn), false]},
    {}
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

