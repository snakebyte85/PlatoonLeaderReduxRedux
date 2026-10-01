/*
Original name: pl_share_info_opfor
New name:      KMD_fnc_shareInfoOpfor
Original url: "Plmod\pl_ai_fnc.sqf"
*/

params ["_group"];
_group setVariable ["spotRepEnabled", true];

while {true} do {
    waitUntil {(behaviour (leader _group)) isEqualto "COMBAT"};

    _targets = [];

    _targets = [(leader _group)] call KMD_fnc_getTargetsOpfor;
    [_targets, (leader _group)] call KMD_fnc_revealTargetsOpfor;

    sleep 20;
};