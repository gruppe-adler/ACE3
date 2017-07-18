#include "script_component.hpp";

/*

fullCrew [obj/class, "", true]

[
	[
		occupant,
		"driver",
		-1,
		[],
		false
	],
	[
		nil,
		"cargo",
		2,
		[],
		false
	],
	[
		foo,
		"cargo",
		3, // cargo index
		[],
		false
	],
	[
		nullObject,
		"Turret",
		-1,
		[0],
		false
	],[<NULL-object>,"Turret",0,[1],true],[<NULL-object>,"Turret",1,[2],true]]

*/

/*

    "a3\ui_f\data\IGUI\Cfg\Actions\getinpilot_ca.paa", \
    "a3\ui_f\data\IGUI\Cfg\Actions\getindriver_ca.paa", \
    "a3\ui_f\data\IGUI\Cfg\Actions\getincommander_ca.paa", \
    "a3\ui_f\data\IGUI\Cfg\Actions\getingunner_ca.paa", \
    QPATHTOF(UI\icon_position_ffv.paa), \
"a3\ui_f\data\IGUI\Cfg\Actions\getincargo_ca.paa" \
*/

ACE_boarding_menu_fnc_hasFreeSlot = {
    _target = param [0];
    _type = param [1];
    (count ((fullCrew [_target, _type, true]) select { _unit = (_x select 0); isNull _unit}) > 0)
};


_action = ["ACE_boardingmenu_parent", "Boarding", "", {true}, {true}] call ace_interact_menu_fnc_createAction;
["AllVehicles", 0, ["ACE_MainActions"], _action, true] call ace_interact_menu_fnc_addActionToClass;

_action = [
    "ACE_boardingmenu_driver",
    "driver",
    "a3\ui_f\data\IGUI\Cfg\Actions\getindriver_ca.paa",
    { player moveInDriver _target; },
    {
        ([_target, "driver"] call ACE_boarding_menu_fnc_hasFreeSlot);
    }
] call ace_interact_menu_fnc_createAction;
["AllVehicles", 0, ["ACE_MainActions", "ACE_boardingmenu_parent"], _action, true] call ace_interact_menu_fnc_addActionToClass;

_action = [
    "ACE_boardingmenu_commander",
    "commander",
    "a3\ui_f\data\IGUI\Cfg\Actions\getincommander_ca.paa",
    { player moveInCommander _target; },
    {
        ([_target, "commander"] call ACE_boarding_menu_fnc_hasFreeSlot);
    }
] call ace_interact_menu_fnc_createAction;
["AllVehicles", 0, ["ACE_MainActions", "ACE_boardingmenu_parent"], _action, true] call ace_interact_menu_fnc_addActionToClass;



_action = [
    "ACE_boardingmenu_gunner",
    "gunner",
    "a3\ui_f\data\IGUI\Cfg\Actions\getingunner_ca.paa",
    { player moveInGunner _target; },
    {
        ([_target, "gunner"] call ACE_boarding_menu_fnc_hasFreeSlot);
    }
] call ace_interact_menu_fnc_createAction;
["AllVehicles", 0, ["ACE_MainActions", "ACE_boardingmenu_parent"], _action, true] call ace_interact_menu_fnc_addActionToClass;


_action = [
    "ACE_boardingmenu_turret",
    "turret",
    "a3\ui_f\data\IGUI\Cfg\Actions\getingunner_ca.paa",
    { player moveInTurret _target; },
    {
        ([_target, "turret"] call ACE_boarding_menu_fnc_hasFreeSlot);
    }
] call ace_interact_menu_fnc_createAction;
["AllVehicles", 0, ["ACE_MainActions", "ACE_boardingmenu_parent"], _action, true] call ace_interact_menu_fnc_addActionToClass;


_action = [
    "ACE_boardingmenu_cargo",
    "cargo",
    "a3\ui_f\data\IGUI\Cfg\Actions\getincargo_ca.paa",
    { player moveInCargo _target; },
    {
        ([_target, "cargo"] call ACE_boarding_menu_fnc_hasFreeSlot);
    }
] call ace_interact_menu_fnc_createAction;
["AllVehicles", 0, ["ACE_MainActions", "ACE_boardingmenu_parent"], _action, true] call ace_interact_menu_fnc_addActionToClass;
