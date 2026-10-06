/*
Original name: pl_spawn_hold
New name:      KMD_fnc_spawnHold
Original url: "Plmod\pl_misc_fnc.sqf"
*/
    {
        [_x] spawn KMD_fnc_hold;
    } forEach hcSelected player;
