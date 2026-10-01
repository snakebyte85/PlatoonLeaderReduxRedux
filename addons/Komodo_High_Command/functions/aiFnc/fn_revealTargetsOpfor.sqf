/*
Original name: pl_reveal_targets_opfor
New name:      KMD_fnc_revealTargetsOpfor
Original url: "Plmod\pl_ai_fnc.sqf"
*/
params ["_targets", "_leader"];
{
    _t = _x;
    {
        if (((leader _x) distance2D _leader) < (pl_radio_range / 2) and ((_leader distance2D _t) < 300)) then {
            _x reveal _t;
        };
    } forEach (allGroups select {side _x != playerSide});

} forEach _targets;

true;