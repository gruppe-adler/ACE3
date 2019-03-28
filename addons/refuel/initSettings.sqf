// CBA Settings [ADDON: ace_refuel]:

[
    QGVAR(rate), "SLIDER",
    [LSTRING(RefuelSettings_speed_DisplayName), LSTRING(RefuelSettings_speed_Description)],
    [localize ELSTRING(OptionsMenu,CategoryLogistics), localize "str_state_refuel"],
    [0,25,1,1], // [min, max, default value, trailing decimals (-1 for whole numbers only)]
    true, // isGlobal
    {[QGVAR(rate), _this] call EFUNC(common,cbaSettings_settingChanged)}
] call CBA_settings_fnc_init;

[
    QGVAR(hoseLength), "SLIDER",
    [LSTRING(RefuelSettings_hoseLength_DisplayName)],
    [localize ELSTRING(OptionsMenu,CategoryLogistics), localize "str_state_refuel"],
    [0,50,12,1], // [min, max, default value, trailing decimals (-1 for whole numbers only)]
    true, // isGlobal
    {[QGVAR(hoseLength), _this] call EFUNC(common,cbaSettings_settingChanged)}
] call CBA_settings_fnc_init;

[
    QGVAR(tickTime), "SLIDER",
    [LSTRING(RefuelSettings_tickTime_DisplayName)],
    [localize ELSTRING(OptionsMenu,CategoryLogistics), localize "str_state_refuel"],
    [0.01,5,0.5,2], // [min, max, default value, trailing decimals (-1 for whole numbers only)]
    true, // isGlobal
    {[QGVAR(tickTime), _this] call EFUNC(common,cbaSettings_settingChanged)}
] call CBA_settings_fnc_init;
