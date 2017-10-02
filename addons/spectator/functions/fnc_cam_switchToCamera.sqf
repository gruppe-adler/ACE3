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
 * ["CamCurator"] call ace_spectator_fnc_cam_switchToCamera
 *
 * Public: No
 */

#include "script_component.hpp"

private _newCameraType = param [0, ""];

private _previousCamType = "";

INFO_1("new cam: %1", _newCameraType);

// No change
if ((!isNil QGVAR(camera)) && (GVAR(camera) isKindOf _newCameraType)) exitWith {
    ERROR("new camera type same as old camera");
};

if (!isNil QGVAR(camera)) then {
INFO("old cam removal 1");
    if (_newCameraType != "") then {
        GVAR(camPos) = getPosATL GVAR(camera);
        GVAR(camDir) = getDirVisual GVAR(camera);
    };

    _previousCamType = typeOf GVAR(camera);
INFO_1("old cam was: %1", _previousCamType);
    // Return to player view
    if !(isNull GVAR(camera)) then {
        GVAR(camera) cameraEffect ["terminate", "back"];
        deleteVehicle GVAR(camera);
    };
    player switchCamera "internal";

    // Remove camera variable
    GVAR(camera) = nil;
INFO("old cam removal 2");
};

if (_newCameraType != "") then {

    // Handle pre-set pos and dir (delete GVARs when done)
    private _pos = if (isNil QGVAR(camPos)) then {eyePos player} else {GVAR(camPos)};
    private _dir = if (isNil QGVAR(camDir)) then {getDirVisual player} else {GVAR(camDir)};
    GVAR(camPos) = nil;
    GVAR(camDir) = nil;
INFO("new cams 2");
    // Create the camera (CamCurator required for engine driven controls)
    // private _camera = "CamCurator" camCreate _pos;
    private _camera = GVAR(camType) camCreate _pos;
    if (isNull _camera) exitWith { ERROR_1("Camera of type %1 could not be created", GVAR(camType)); };
    if (_camera isKindOf "CamCurator") then {
INFO("CamCurator 1");
        if (_previousCamType == "Camera") then {
            INFO("re-adding ui b/c of camera");
            [true] call FUNC(ui);
        };
INFO("CamCurator 2");
        // Switch to the camera and set its attributes
        _camera cameraEffect ["internal", "back"];
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
    } else { if (_camera isKindOf "Camera") then {
INFO("Camera 1");
        if (_previousCamType == "CamCurator") then {
            INFO("removing ui b/c of camera");
            [false] call FUNC(ui);
        };
        _camera cameraEffect ["internal", "back"];
        _camera camCommand "inertia on";
        _camera camCommand "manual on";
        cameraEffectEnableHUD false;
        showCinemaBorder false;
        GVAR(abortCameraHandler) = (findDisplay 46) displayAddEventHandler ["MouseButtonDown", {
            private _button = param [1, 0];
            INFO_1("mousehandler, button %1", _button);
            if (_button == 1) exitWith {
                INFO("keydownhandler right mouse!!!");
                (findDisplay 46) displayRemoveEventHandler ["MouseButtonDown" ,GVAR(abortCameraHandler)];
                (findDisplay 46) displayRemoveEventHandler ["KeyDown" ,GVAR(abortCameraHandler2)];
                ["CamCurator"] call FUNC(cam_switchToCamera);
                true
            };
        }];

        GVAR(abortCameraHandler2) = (findDisplay 46) displayAddEventHandler ["KeyDown", {
            private _key = param [1, 0];
            INFO_1("keydownhandler, key %1", _key);
            if (_key == DIK_F2) exitWith {
                INFO("keydownhandler F2!!!");
                (findDisplay 46) displayRemoveEventHandler ["MouseButtonDown" ,GVAR(abortCameraHandler)];
                (findDisplay 46) displayRemoveEventHandler ["KeyDown" , GVAR(abortCameraHandler2)];
                ["CamCurator"] call FUNC(cam_switchToCamera);
                true
            };
        }];
INFO("Camera 2");
    } else {
        ERROR_1("unknown camera type %1", typeOf _camera);
    };};
    _camera setPosASL _pos;
    _camera setDir _dir;
INFO("new cams post 1");
    // Store camera
    GVAR(camera) = _camera;
};
