/*
Original name: pl_spawn_execute
New name:      KMD_fnc_spawnExecute
Original url: "Plmod\pl_misc_fnc.sqf"
*/
    {
        [_x] spawn KMD_fnc_execute;
    } forEach hcSelected player;