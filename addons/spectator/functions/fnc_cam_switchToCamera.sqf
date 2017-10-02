/*
 * Author: Fusselwurm
 * Switch to different camera.
 *
 * Arguments:
 * 0: [optional ] New camera type. Will revert to player view if not set.
 *
 * Return Value:
 * None
 *
 * Example:
 * ["CuratorCam"] call ace_spectator_fnc_cam_switchToCamera
 *
 * Public: No
 */

#include "script_component.hpp"

private _newCameraType = param [0, ""];

// No change
if ((!isNil QGVAR(camera)) && (GVAR(camera) isKindOf _newCameraType)) exitWith {
    ERROR("new camera type same as old camera");
};

if (!isNil QGVAR(camera)) then {
    // Return to player view
    if !(isNull GVAR(camera)) then {
        GVAR(camera) cameraEffect ["terminate", "back"];
        deleteVehicle GVAR(camera);
    };
    player switchCamera "internal";

    // Remove camera variable
    GVAR(camera) = nil;
};

if (_newCameraType != "") then {

    // Handle pre-set pos and dir (delete GVARs when done)
    private _pos = if (isNil QGVAR(camPos)) then {eyePos player} else {GVAR(camPos)};
    private _dir = if (isNil QGVAR(camDir)) then {getDirVisual player} else {GVAR(camDir)};
    GVAR(camPos) = nil;
    GVAR(camDir) = nil;

    // Create the camera (CamCurator required for engine driven controls)
    // private _camera = "CamCurator" camCreate _pos;
    private _camera = GVAR(camType) camCreate _pos;
    if (isNull _camera) exitWith { ERROR_1("Camera of type %1 could not be created", GVAR(camType)); };
    if (_camera isKindOf "CamCurator") then {

    } else {
        _camera camCommand "manual on";
        showCinemaBorder false;
    };

    // Switch to the camera and set its attributes
    _camera cameraEffect ["internal", "back"];
    _camera setPosASL _pos;
    _camera setDir _dir;
    _camera camCommand "maxPitch 89";
    _camera camCommand "minPitch -89";
    _camera camCommand format ["speedDefault %1", SPEED_DEFAULT];
    _camera camCommand format ["speedMax %1", SPEED_FAST];
    _camera camCommand "ceilingHeight 5000";
    cameraEffectEnableHUD true;

    // If camera followed terrain it would be annoying to track units, etc.
    _camera camCommand "atl off";

    // Camera speed should be consistent irrespective of height (painfully slow otherwise)
    _camera camCommand "surfaceSpeed off";

    // Store camera
    GVAR(camera) = _camera;
};
