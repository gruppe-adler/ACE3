/*
 * Author: Nelson Duarte, SilentSpike
 * Handles camera initialisation and destruction
 *
 * Arguments:
 * 0: Init/Terminate <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [true] call ace_spectator_fnc_cam
 *
 * Public: No
 */

#include "script_component.hpp"

params ["_init"];

// No change
if (_init isEqualTo !isNil QGVAR(camera)) exitWith {};

// Note that init and destroy intentionally happen in reverse order
// Init: Vars > Camera > Camera Stuff
// Destroy: Camera Stuff > Camera > Vars
if (_init) then {
    // Start tracking camera attributes if not pre-set by public function
    ISNILS(GVAR(camType),"CamCurator");
    ISNILS(GVAR(camMode),MODE_FREE);
    ISNILS(GVAR(camVision),VISION_NORM);
    ISNILS(GVAR(camFocus),objNull);

    // Ticking related
    GVAR(camDeltaTime)          = 0;
    GVAR(camLastTickTime)       = 0;
    GVAR(camHasTarget)          = false;
    GVAR(camTargetInVehicle)    = false;

    // Follow camera related
    GVAR(camDistance)           = 0;
    GVAR(camDistanceTemp)       = 0;
    GVAR(camYaw)                = 0;
    GVAR(camPitch)              = 0;

    // Toggles
    GVAR(camSlow)               = false;
    GVAR(camLights)             = [];
    GVAR(camLight)              = false;


    [GVAR(camType)] call FUNC(cam_switchToCamera);

    // Create dummy target used for follow camera
    GVAR(camDummy) = "Logic" createVehicleLocal getPosASLVisual GVAR(camFocus);

    // Handle initial camera mode limitation
    if !(GVAR(camMode) in GVAR(availableModes)) then {
        GVAR(camMode) = GVAR(availableModes) select 0;
    };

    // If inital camera mode is not free cam and no focus, find initial focus
    if (GVAR(camMode) != MODE_FREE && isNull GVAR(camFocus)) then {
        [true] call FUNC(setFocus);
    };

    // Set the initial camera mode (could be pre-set or limited)
    [GVAR(camMode)] call FUNC(cam_setCameraMode);

    // Handle initial vision mode limitation
    if !(GVAR(camVision) in GVAR(availableVisions)) then {
        GVAR(camVision) = GVAR(availableVisions) select 0;
    };

    // Set the initial vision mode (could be pre-set or limited)
    [GVAR(camVision)] call FUNC(cam_setVisionMode);

    // Start ticking (follow camera requires EachFrame to avoid jitter)
    GVAR(camTick) = addMissionEventHandler ["EachFrame", {call FUNC(cam_tick)}];
} else {
    // Stop ticking
    removeMissionEventHandler ["EachFrame", GVAR(camTick)];
    GVAR(camTick) = nil;

    [""] call FUNC(cam_switchToCamera);

    // Destroy dummy target
    deleteVehicle (GVAR(camDummy));
    GVAR(camDummy) = nil;

    // Stop tracking everything
    GVAR(camMode)               = nil;
    GVAR(camVision)             = nil;
    GVAR(camFocus)              = nil;
    GVAR(camDeltaTime)          = nil;
    GVAR(camLastTickTime)       = nil;
    GVAR(camHasTarget)          = nil;
    GVAR(camTargetInVehicle)    = nil;
    GVAR(camDistance)           = nil;
    GVAR(camDistanceTemp)       = nil;
    GVAR(camYaw)                = nil;
    GVAR(camPitch)              = nil;
    GVAR(camSlow)               = nil;
    GVAR(camLights)             = nil;
    GVAR(camLight)              = nil;
};
