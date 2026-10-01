/*
Original name: pl_spawn_leave_vehicle
New name:      KMD_fnc_spawnLeaveVehicle
Original url: "Plmod\pl_vehicle_fnc.sqf"
*/
{
    [_x] spawn KMD_fnc_leaveVehicle;
} forEach hcSelected player;  