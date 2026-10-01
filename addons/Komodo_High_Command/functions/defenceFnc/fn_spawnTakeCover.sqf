/*
Original name: pl_spawn_take_cover
New name:      KMD_fnc_spawnTakeCover
Original url: "Plmod/pl_defence_fnc.sqf"
*/
    {
        [_x] spawn KMD_fnc_takeCover;
    } forEach hcSelected player;  
