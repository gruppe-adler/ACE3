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
    ["_mode", ""]
];

private _currentFuel = ([_sink, _mode] call FUNC(getFuel));
private _fuelLeft = ([_sink, _mode] call FUNC(getMaxFuelCargo)) - _currentFuel;
private _fuelToBeAdded = _fuelLeft min _flow;


switch (_mode) do {
    case "cargo": {
        private _fuel
        [_sink, _fuelToBeAdded + _currentFuel] call FUNC(setFuel);
    };
    case "motor": {
        // TODO magic calculation, see fnc_refuel
    };
};

if (_flow > _fuelLeft) then {
    private _backFlow = _flow - _fuelLeft;

    [
        QGVAR(backPressure),
        [_source, _backFlow],
        [_source]
    ] call CBA_fnc_targetEvent;
};
