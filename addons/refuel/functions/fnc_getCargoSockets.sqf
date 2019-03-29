#define CARGONOZZLE(var) QGVAR(cargoNozzle) + (toString var)

params [
    [_sink, objNull],
    [_getOccupied, true],
    [_getUnoccupied, true]
];

_config = (configFile >> "CfgVehicles" >> (typeOf _sink) >> QGVAR(cargoSockets));

if (!isArray (_config)) exitWith {[]};

private _sockets = getArray _config;

if (!_getOccupied) then {
    _sockets = _sockets select {
        isNull (_sink getVariable [CARGONOZZLE(_x), objNull])
    };
};
if (!_getUnoccupied) then {
    _sockets = _sockets select {
        !(isNull (_sink getVariable [CARGONOZZLE(_x), objNull]))
    };
};

_sockets
