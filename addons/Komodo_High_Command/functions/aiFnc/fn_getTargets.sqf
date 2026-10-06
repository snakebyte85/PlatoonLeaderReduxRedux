/*
Original name: pl_get_targets
New name:      KMD_fnc_getTargets
Original url: "Plmod\pl_ai_fnc.sqf"
*/

params ["_leader"];
private ["_targets"];

_targets = (group _leader) targets [true, 1000];

_targets
