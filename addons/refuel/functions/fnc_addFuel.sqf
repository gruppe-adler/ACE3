#include "script_component.hpp"
/*adds fuel to a given tank, and returns the overflow */

params [
    ["_sink", objNull],
    ["_mode", ""],
    ["_flow", 0]
];

private _currentFuel = [_sink, _mode] call FUNC(getFuel);
private _maxFuel = [_sink, _mode] call FUNC(getFuelCargoMax);

private _open = _maxFuel - _currentFuel;

// TODO mode handling
[_sink, _currentFuel + (_open min _flow)] call FUNC(setFuel);

// return that which could not be added
(_flow - _open min 0)
