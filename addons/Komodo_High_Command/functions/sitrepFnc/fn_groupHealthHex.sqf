/*
Original name: pl_get_group_health_hex
New name:      KMD_fnc_groupHealthHex
Original url: "Plmod\pl_sitrep_fnc.sqf"
*/
params ["_group"];
private _healthState = ["Green", "#66ff33"];
{
    if ((damage _x) > 0.1) then {
        _healthState = ["Yellow", "#e5e500"];
    };
    if (_x getVariable "pl_wia" and (alive _x)) then {
        _healthState = ["Red", "#b20000"];
    };

} forEach (units _group);

_healthState;