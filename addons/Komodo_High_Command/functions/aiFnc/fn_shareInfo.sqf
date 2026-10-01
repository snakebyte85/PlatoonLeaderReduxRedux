/*
Original name: pl_share_info
New name:      KMD_fnc_shareInfo
Original url: "Plmod\pl_ai_fnc.sqf"
*/

params [
	["_group",nil,[grpNull]]
];

_group setVariable ["spotRepEnabled", true];

while {true} do {
    waitUntil {(behaviour (leader _group)) isEqualto "COMBAT"};

    _targets = [];

    // [_targets] spawn pl_mark_targets_on_map;

    _targets = [(leader _group)] call KMD_fnc_getTargets;
    [_targets, (leader _group)] call KMD_fnc_revealTargets;

    sleep 20;
};