/*
Original name: pl_share_info_opfor
New name:      KMD_fnc_shareInfoOpfor
Original url: "Plmod\pl_ai_fnc.sqf"
*/

params ["_group"];

format ["Enabling opfor share info for %1", _group] call KMD_fnc_debug;

_group setVariable ["spotRepEnabled", true];

while { ({ alive _x } count units _group) > 0  } do {
    waitUntil {(behaviour (leader _group)) isEqualto "COMBAT"};

    _targets = [];

    _targets = [(leader _group)] call KMD_fnc_getTargetsOpfor;
    [_targets, (leader _group)] call KMD_fnc_revealTargetsOpfor;

    sleep 20;
};

format ["No more opfor share info for %1, group is dead", _group] call KMD_fnc_debug;
