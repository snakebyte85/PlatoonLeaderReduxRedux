/*
Original name: pl_share_info
New name:      KMD_fnc_shareInfo
Original url: "Plmod\pl_ai_fnc.sqf"
*/

params [
	["_group",nil,[grpNull]]
];

format ["Enabling share info for %1", _group] call KMD_fnc_debug;

_group setVariable ["spotRepEnabled", true];

while { ({ alive _x } count units _group) > 0 } do {
    waitUntil {(behaviour (leader _group)) isEqualto "COMBAT"};

    _targets = [];

    _targets = [(leader _group)] call KMD_fnc_getTargets;
    [_targets, (leader _group)] call KMD_fnc_revealTargets;

    sleep 20;
};

format ["No more share info for %1, group is dead", _group] call KMD_fnc_debug;
