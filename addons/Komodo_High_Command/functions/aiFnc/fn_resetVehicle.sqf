/*
Original name: pl_reset_vehicle
New name:      KMD_fnc_resetVehicle
Original url: "Plmod\pl_ai_fnc.sqf"
*/
params ["_group"];
private ["_vic"];

if ((vehicle (leader _group)) == (leader _group)) exitWith {};

_vic = vehicle (leader _group);