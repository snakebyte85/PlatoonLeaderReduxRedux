/*
Original name: pl_get_targets_opfor
New name:      KMD_fnc_getTargetsOpfor
Original url: "Plmod\pl_ai_fnc.sqf"
*/

params ["_leader"];
private ["_targets"];
_targets = [];
{
    if (alive _x and (side _x) != civilian) then {
        if (_leader knowsAbout _x > 2) then {
        _targets append [_x];
        };
    };
} forEach (allUnits+vehicles select {side _x isEqualTo playerSide});

_targets
