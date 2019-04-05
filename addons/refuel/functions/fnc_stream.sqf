#include "script_component.hpp"
#define MAX_FUELTICK 5

/*

* FUNC(stream)
    * checks source contents
    * checks nozzle flowRate (or respective global config)
    * checks sink capacity
    * throws stream event

*/

params [
    ["_nozzle", objNull]
];

_sink = _nozzle getVariable [GVAR(sink), objNull];
_source = _nozzle getVariable [GVAR(source), objNull];
_tankType = _nozzle getVariable [GVAR(tankType), ""];


private _lastTick = _nozzle getVariable [QGVAR(lastTickMissionTime), CBA_MissionTime];
_nozzle setVariable [QGVAR(lastTickMissionTime), CBA_MissionTime];

private _timeSinceLast = (CBA_MissionTime - _lastTick) min MAX_FUELTICK;

if (_timeSinceLast == 0) exitWith {};

private _available = [_source, _tankType] call FUNC(getFuel);

private _sinkConfig = configFile >> "CfgVehicles" >> typeOf _sink;

private _flowRate = getNumber (_sinkConfig >> QGVAR(flowRate)) * GVAR(rate);
if (_flowRate == 0) then {
    WARNING_1("no flowRate configured for %1 (using 1 as fallback)", typeOf _sink);
    _flowRate = 1;
};

private _flow = _flowRate * _timeSinceLast;

private _sinkFuel = [_sink, _tankType] call FUNC(getFuel);
private _sinkCapacity = [_sink, _tankType] call FUNC(getMaxFuel);

_flow = (_sinkCapacity - _sinkFuel) min _flow; // dont send more than it can take

if (_flow == 0) exitWith {false};

[_source, _available - __flow] call FUNC(setFuel);

[
    QGVAR(stream),
    [_source, _flow, _sink, _tankType], // TODO parameters?
    [_sink]
] call CBA_fnc_targetEvent;