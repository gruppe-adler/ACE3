#include "component.hpp"
#define MAX_FUELTICK 5

/*

* FUNC(stream)
    * checks source contents
    * checks nozzle flowRate (or respective global config)
    * checks sink capacity
    * throws stream event

*/

params [
    ["_source", objNull],
    ["_sink", objNull],
    ["_nozzle", objNull],
    ["_lastTick", 0],
    ["_mode", "motor", ["motor", "cargo"]]
];



private _timeSinceLast = (CBA_MissionTime - _lastTick) min MAX_FUELTICK;


private _available = [_source] call FUNC(getFuel);

private _sinkConfig = configFile >> "CfgVehicles" >> typeOf _sink;

private _flowRate = getNumber (_sinkConfig >> QGVAR(flowRate)) * GVAR(rate);

private _flow = _flowRate * _timeSinceLast;

private _sinkFuel = [_sink, _mode] call FUNC(getFuel);
private _sinkCapacity = [_sink, _mode] call FUNC(getMaxFuelCargo); // TODO getMaxFuelCargo should be getMaxFuel

_flow = (_sinkCapacity - _sinkFuel) min _flow; // dont send more than it can take

if (_flow == 0) exitWith {false};

[
    QGVAR(stream),
    [_source, _flow, _sink, _mode], // TODO parameters?
    [_sink]
] call CBA_fnc_targetEvent;
