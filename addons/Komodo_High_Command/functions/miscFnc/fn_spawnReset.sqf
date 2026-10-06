/*
Original name: pl_spawn_reset
New name:      KMD_fnc_spawnReset
Original url: "Plmod\pl_misc_fnc.sqf"
*/
    {
        [_x] spawn KMD_fnc_reset;
    } forEach hcSelected player;
