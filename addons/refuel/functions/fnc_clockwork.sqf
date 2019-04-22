#include "script_component.hpp";

ISNILS(GVAR(connectedNozzles), []);

private _sm = [{GVAR(connectedNozzles)}, true] call CBA_statemachine_fnc_create;
private _state = [
    _sm,
    {
        private _sink = _this getVariable [GVAR(sink), objNull];
        private _source = _this getVariable [GVAR(source), objNull];

        if (CBA_MissionTime - (_this getVariable [GVAR(lastTickMissionTime), CBA_MissionTime]) < 0.2) exitWith {};

        _this call FUNC(stream);
    },
    {},
    {},
    "connected"
] call CBA_statemachine_fnc_addState;

_state = [
    _sm,
    {
        private _sink = _this getVariable [GVAR(sink), objNull];
        private _source = _this getVariable [GVAR(source), objNull];

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
    {
        // remove from state machine
        GVAR(connectedNozzles) deleteAt (GVAR(connectedNozzles) find _this);
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

GVAR(clockwork) = _sm;
