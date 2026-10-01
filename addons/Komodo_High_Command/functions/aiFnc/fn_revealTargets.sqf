/*
Original name: pl_reveal_targets
New name:      KMD_fnc_revealTargets
Original url: "Plmod\pl_ai_fnc.sqf"
*/

params ["_targets", "_leader"];
{
    _t = _x;
    {
        if (((leader _x) distance2D _leader) < pl_radio_range) then {
            _x reveal _t;
        };
    } forEach (allGroups select {side _x isEqualTo playerSide});

} forEach _targets;
