#include "script_component.hpp"

private _unit = ACE_player;
private _nozzle = _unit getVariable [QGVAR(nozzle), objNull];

if (isNull _nozzle) exitWith {false};

getCursorObjectParams params ["_cursorObject", "", "_distance"];
if (
    !isNull _cursorObject
    && {_distance < REFUEL_NOZZLE_ACTION_DISTANCE}
    && {1 == getNumber (configFile >> "CfgVehicles" >> (typeOf _cursorObject) >> QGVAR(canReceive))}
    && {isNull (_cursorObject getVariable [QGVAR(nozzle), objNull])}
    && {!lineIntersects [eyePos _unit, _virtualPosASL, _unit]}
) then {
    [_unit, _cursorObject, _virtualPosASL, _nozzle] call FUNC(connectNozzleAction);
};
