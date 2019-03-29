#include "script_component.hpp"

params [["_unit", objNull, [objNull]], ["_sink", objNull, [objNull]]];

private _nozzle = _unit getVariable [QGVAR(nozzle), objNull];

if (isNull _nozzle) exitWith {false};

private _unoccupiedCargoSockets = [_sink, false, true] call FUNC(getCargoSockets);

{(_unit distance _sink) < REFUEL_NOZZLE_ACTION_DISTANCE} && {count _unoccupiedCargoSockets > 0}
