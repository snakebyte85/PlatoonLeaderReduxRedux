/*
Original name: pl_spawn_vic_speed
New name:      KMD_fnc_spawnVicSpeed
Original url: "Plmod\pl_vehicle_fnc.sqf"
*/
    params ["_speed"];

    playsound "beep";

    {  
       [_x, _speed] spawn KMD_fnc_vehicleSpeedLimit; 
    } forEach hcSelected player;
