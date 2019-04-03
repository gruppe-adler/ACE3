params [
    ["_object", objNull, [objNull]],
    ["_tankType", "", ["cargo", "motor"]]
];

private _config = configFile >> "CfgVehicles" >> typeOf _object;

switch (_tankType) do {
    case "cargo": {
        private _fuelCargoConfig = getNumber (_config >> QGVAR(fuelCargo));
        if (_fuelCargoConfig == 0) then {
            _source getVariable [QGVAR(maxFuelCargo), 0];
        } else {
            _fuelCargoConfig;
        }
    };
    case "motor": {
        private _maxFuel = getNumber (_config >> QGVAR(fuelCapacity));

        // Fall back to vanilla fuelCapacity value (only air and sea vehicles don't have this defined by default by us)
        // Air and sea vehicles have that value properly defined in liters, unlike ground vehicles which is is formula of (range * tested factor) - different fuel consumption system than ground vehicles
        if (_maxFuel == 0) then {
            getNumber (_config >> "fuelCapacity");
        } else {
            _maxFuel
        };
    };
    default {
        0
    };
};
