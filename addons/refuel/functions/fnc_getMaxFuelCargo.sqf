params [
    ["_object", objNull]
];


private _fuelCargoConfig = getNumber (configFile >> "CfgVehicles" >> typeOf _object >> QGVAR(fuelCargo));
if (_fuelCargoConfig == 0) then {
    _source getVariable [QGVAR(maxFuelCargo), 0];
} else {
    _fuelCargoConfig;
}
