
private _category = "Platoon Leader Redux Redux ";

[
    "pl_contact_report_enabled",
    "CHECKBOX",
    ["Enable Contact Report","The groups you command will report via chat every time they contact, engage or kill an enemy and when they get a KIA."],
    _category,
    true
] call CBA_fnc_addSetting;

[
    "pl_radio_range", 
    "SLIDER", 
    ["Radio Range", "Set the maximum range for ai info sharing"], 
	_category, 
    [
        0, 
        2000, 
        700, 
        0,
        false
    ]
] call CBA_fnc_addSetting;

[
    "pl_player_side_info_share_enabled",
    "CHECKBOX",
    ["Enable Player Side Info sharing","Enable the sharing of opfor forces location among your groups"],
    _category,
    false
] call CBA_fnc_addSetting;

[
    "pl_opfor_info_share_enabled",
    "CHECKBOX",
    ["Enable Enemy Info sharing","Enable the sharing of your side forces location among enemy groups (WARNING: the game would be harder!)"],
    _category,
    false
] call CBA_fnc_addSetting;

[
    "pl_additional_ammoBearer",
    "EDITBOX",
    ["Additional Ammobearer classnames","Define unit classes that can be used as ammobearers: Format ['example_class_1', 'example_class_2']"],
    _category,
    "[]"
] call CBA_fnc_addSetting;

[
    "pl_enabled_medical",
    "CHECKBOX",
    ["Enable Medical System","enable or disable Medical System"],
    _category,
    false
] call CBA_fnc_addSetting;

[
    "pl_enable_vehicle_recovery",
    "CHECKBOX",
    ["Enable Vehicle Recovery","enable or disable Vehicle Recovery"],
    _category,
    false
] call CBA_fnc_addSetting;

[
    "pl_additional_engVic",
    "EDITBOX",
    ["Additional Repair Vehicles classnames","Define Vehicles that can repair/recover other Vehicles: Format ['example_class_1', 'example_class_2']"],
    _category,
    "[]"
] call CBA_fnc_addSetting;

[
    "pl_enable_3d_icons",
    "CHECKBOX",
    ["Enable 3D Icons","Enable Extra 3D Icons when selecting or hovering over a group"],
    _category,
    true
] call CBA_fnc_addSetting;

[
    "pl_debug",
    "CHECKBOX",
    ["Enable Debug","Enable Extra Debug logging"],
    _category,
    false
] call CBA_fnc_addSetting;

#include "keybindings.sqf"