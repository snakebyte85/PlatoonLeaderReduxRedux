
missionNamespace setVariable ["KMD_Version", 0.11, true];
private _versionName = ["Komodo's Platoon Leader ", KMD_Version] joinString "";

[
    "pl_ai_skill",
    "SLIDER", 
    ["Player Side Ai Skill", "Ai Skill Level for Player Side"], 
	_versionName, 
    [
        0, 
        1, 
        0.8, 
        2,
        false
    ]
] call CBA_fnc_addSetting;

[
    "pl_radio_range", 
    "SLIDER", 
    ["Radio Range", "Set the maximum range for ai info sharing"], 
	_versionName, 
    [
        0, 
        2000, 
        700, 
        0,
        false
    ]
] call CBA_fnc_addSetting;

[
    "pl_opfor_info_share_enabled",
    "CHECKBOX",
    ["Enable Enemy Info sharing","Enable the sharing of information among enemy groups"],
    _versionName,
    true
] call CBA_fnc_addSetting;

[
    "pl_additional_ammoBearer",
    "EDITBOX",
    ["Additional Ammobearer classnames","Define unit classes that can be used as ammobearers: Format ['example_class_1', 'example_class_2']"],
    _versionName,
    "[]"
] call CBA_fnc_addSetting;

[
    "pl_enabled_medical",
    "CHECKBOX",
    ["Enable Medical System","enable or disable Medical System"],
    _versionName,
    true
] call CBA_fnc_addSetting;

[
    "pl_enable_vehicle_recovery",
    "CHECKBOX",
    ["Enable Vehicle Recovery","enable or disable Vehicle Recovery"],
    _versionName,
    true
] call CBA_fnc_addSetting;

[
    "pl_additional_engVic",
    "EDITBOX",
    ["Additional Repair Vehicles classnames","Define Vehicles that can repair/recover other Vehicles: Format ['example_class_1', 'example_class_2']"],
    _versionName,
    "[]"
] call CBA_fnc_addSetting;

[
    "pl_arty_enabled",
    "CHECKBOX",
    ["Enable Artillery","enable or disable Platoon Leader Artillery Supports"],
    _versionName,
    true
] call CBA_fnc_addSetting;

[
    "pl_arty_ammo",
    "EDITBOX",
    ["155mm Artillery Ammo","Set Amount of Rounds for 155mm Artillery Support"],
    _versionName,
    "24"
] call CBA_fnc_addSetting;

[
    "pl_cas_enabled",
    "CHECKBOX",
    ["Enable CAS","enable or disable Platoon Leader Close Air Support"],
    _versionName,
    true
] call CBA_fnc_addSetting;

[
    "pl_sorties",
    "EDITBOX",
    ["CAS Sortie Amount","Different CAS Strikes cost different amount of 'Sorties' select Amount"],
    _versionName,
    "25"
] call CBA_fnc_addSetting;

[
    "pl_enable_3d_icons",
    "CHECKBOX",
    ["Enable 3D Icons","Enable Extra 3D Icons when selecting or hovering over a group"],
    _versionName,
    true
] call CBA_fnc_addSetting;

#include "keybindings.sqf"