/*
Original name: pl_set_up_ai
New name:      KMD_fnc_setupAi
Original url: "Plmod\pl_ai_fnc.sqf"
*/

params ["_group"];
private ["_magCountAll", "_magCountSolo"];

_group setVariable ["aiSetUp", true];
_group setVariable ["onTask", false];
_group setVariable ["inContact", false];
_group setVariable ["sitrepCd", 0];
_group setVariable ["pl_show_info", true];
_group setVariable ["pl_hold_fire", false];
_group allowFleeing 0;

[_group] spawn KMD_fnc_ammoBearer;

_magCountAll = 0;
{
        // Ammo Count
    _mags = magazines _x;
    _mag = "";
    if ((primaryWeapon _x) != "") then {
        _mag = (getArray (configFile >> "CfgWeapons" >> (primaryWeapon _x) >> "magazines")) select 0;
    };

    _magCount = 0;

    {
        if ((_mag isEqualto _x))
		then{_magCount = _magCount + 1};
	
    }forEach _mags;

    _magCountAll = _magCountAll + _magCount;

    _x setVariable ["pl_wia", false];
    _x setVariable ["pl_unstuck_cd", 0];

    // [_x] spawn KMD_fnc_autoCrouch;

    if(pl_enabled_medical) then {
        [_x] call KMD_fnc_medicalSetup
    };
    
    if (_x getVariable ["pl_special_force", false]) then {
        [_x] spawn KMD_fnc_specialForceSkill;
    };

} forEach (units _group);

_group setVariable ["magCountAllDefault", _magCountAll];

if ((count (units _group)) > 1) then {
    _magCountSolo = round (_magCountAll / (count (units _group)));
}
else{_magCountSolo = _magCountAll}; 

_group setVariable ["magCountSoloDefault", _magCountSolo];

_unitCount = count (units _group);
_group setVariable ["_unitCountDefault", _unitCount];