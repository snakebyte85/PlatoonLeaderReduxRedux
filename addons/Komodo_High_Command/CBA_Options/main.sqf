#include "../script_version.hpp"

private _category = 'Platoon Leader Redux Redux MAJOR.MINOR.PATCH';

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
    "pl_enable_revival",
    "CHECKBOX",
    ["Enable Revival System","Enable Revival System. Units in the groups you control have a chance to be wounded and needs to be treated by a medic to be 'revived'."],
    _category,
    false
] call CBA_fnc_addSetting;

[
    "pl_death_chance",
    "SLIDER",
    ["Death chance of the Revival System","If the Revival System is enabled, this is the chance the unit will receive a fatal hit and die, without being just wounded and revivable."],
    _category,
    [
        0, 
        100, 
        10, 
        0,
        true
    ]
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
