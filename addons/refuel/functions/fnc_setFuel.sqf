#include "script_component.hpp"
/*
 * Author: GitHawk
 * Set the remaining fuel amount.
 *
 * Arguments:
 * 0: Fuel Source <OBJECT>
 * 1: Amount (in liters)<NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [fuelTruck, 42] call ace_refuel_fnc_setFuel
 *
 * Public: Yes
 */

params [
    ["_source", objNull, [objNull]],
    ["_fuel", nil, [0]],
    ["_tankType", "cargo", ["cargo", "motor"]]
];

if (isNull _source ||
    {isNil "_fuel"}) exitWith {};


if (_tankType == "motor") then {
    private _maxFuel = [_source, _tankType] call FUNC(getMaxFuel);
    if (_maxFuel == 0) then {
        WARNING("aaaah max motor fuel == 0");
    } else {
        _source setFuel (_fuel / _maxFuel);
    };
} else {
    _source setVariable [QGVAR(currentFuelCargo), _fuel, true];
};

