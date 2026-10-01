/*
Original name: pl_ch_vehicle_dir
New name:      KMD_fnc_chVehicleDir
Original url: "Plmod\pl_ai_fnc.sqf"
*/
params ["_group"];
private ["_vic"];

if((vehicle (leader _group)) == (leader _group))exitWith{};

_vic = vehicle (leader _group);
_dir = getDir _vic;
_vic setDir (_dir - 180);

_dir;