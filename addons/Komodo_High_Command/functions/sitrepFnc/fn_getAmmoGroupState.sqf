/*
Original name: pl_get_ammo_group_state
New name:      KMD_fnc_getAmmoGroupState
Original url: "Plmod\pl_sitrep_fnc.sqf"
*/
params ["_group"];
private _ammoState = ["Green", "#66ff33"];
private _magsDefault = _group getVariable "magCountAllDefault";
private _magCountAll = 0;

{
    _mags = magazines _x;
    _mag = "";
    if ((primaryWeapon _x) != "") then {
        _mag = (getArray (configFile >> "CfgWeapons" >> (primaryWeapon _x) >> "magazines")) select 0;
    };
    _magCount = 0;
    {
        if ((_mag isEqualto _x)) then {
            _magCount = _magCount + 1;
        };
    }forEach _mags;
    _magCountAll = _magCountAll + _magCount;
} forEach (units _group);

if (_magCountAll < (_magsDefault * 0.6)) 
then {_ammoState = ["Yellow", "#e5e500"]};

if (_magCountAll < (_magsDefault * 0.25)) 
then {_ammoState = ["Red", "#b20000"]};

_ammoState;