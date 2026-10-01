/*
Original name: pl_contact_info_share
New name:      KMD_fnc_contactInfoShare
Original url: "Plmod\pl_ai_fnc.sqf"
*/

params ["_unit"];
sleep 7;
_targets = [];
_targets = [_unit] call KMD_fnc_getTargets;

//[_targets, _unit] call KMD_fnc_revealTargets;

[_targets] spawn KMD_fnc_markTargetsOnMap;

true;