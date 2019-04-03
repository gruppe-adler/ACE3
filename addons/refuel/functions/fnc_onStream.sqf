#include "component.hpp"
/*

* FUNC(onStream)
    * check capacity of sink
    * add amount of fluid
    * on excess, throw backPressure event
*/

params [
    ["_source", objNull],
    ["_flow", 0],
    ["_sink", objNull],
    ["_tankType", "", ["cargo", "motor"]]
];

private _currentFuel = [_sink, _tankType] call FUNC(getFuel);
private _fuelLeft = ([_sink, _tankType] call FUNC(getMaxFuel)) - _currentFuel;
private _fuelToBeAdded = _fuelLeft min _flow;
private _backFlow = (_flow - _fuelLeft) max 0;

[_sink, _fuelToBeAdded + _currentFuel, _tankType] call FUNC(setFuel);

if (_backFlow > 0) then {
    [
        QGVAR(backPressure),
        [_source, _backFlow],
        [_source]
    ] call CBA_fnc_targetEvent;
};
