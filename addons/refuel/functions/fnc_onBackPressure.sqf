#include "component.hpp"

/*

* FUNC(onBackPressure)
    * check capacity of source
    * add fluid to it
    * on excess, throw backPressure events to all sources (thats a bit yucky, but its the best we can do)
*/

params [
    ["_source", objNull],
    ["_backPressure", 0]
];

private _couldNotAdd = [_source, _backPressure] call FUNC(addFuel);

if (_couldNotAdd == 0) exitWith {};

// is _source acting as a sink to anybody? if yes, push that shit back
// ok, now I cant avoid registering nozzles with their sinks

private _nozzles = [_source, true, false, true] call FUNC(getCargoSockets);

if (count _nozzles == 0) exitWith {
    // TODO cause fuel spill
    WARNING("halp, causing fluid spill!");
};

private _amountPerNozzle = (_couldNotAdd / _nozzles);
{
    private _upstream = _x getVariable [QGVAR(source), objNull];
    [
        QGVAR(backPressure),
        [_upstream, _amountPerNozzle],
        [_upstream]
    ] call CBA_fnc_targetEvent;
} forEach _nozzles;
