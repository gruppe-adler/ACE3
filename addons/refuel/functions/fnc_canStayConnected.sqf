#include "script_component.hpp"

params [
    ["_nozzle", objNull, [objNull]]
];

if !(alive _source && alive _sink) exitWith {false};

// private _distance = _source distance _sink;

private _sourcePoint = _source modelToWorld (_nozzle getVariable QGVAR(attachPos));
private _sinkPoint = _sink modelToWorld

(_source getVariable [QGVAR(hoseLength), GVAR(hoseLength)]) >= _sinkPoint distance _sourcePoint;
