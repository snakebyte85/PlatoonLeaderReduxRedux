/*
Original name: pl_player_report
New name:      KMD_fnc_playerReport
Original url: "Plmod\pl_ai_fnc.sqf"
*/

playSound "beep";
// player sideChat "to all Elements, stand by for SPOTREP, over";
_targets = [];
{
    if (player knowsAbout _x > 0) then {
        _targets pushBack _x;
    };
} forEach (allUnits+vehicles select {side _x != playerSide});

[_targets] spawn KMD_fnc_markTargetsOnMap;

[_targets, player] call KMD_fnc_revealTargets;
