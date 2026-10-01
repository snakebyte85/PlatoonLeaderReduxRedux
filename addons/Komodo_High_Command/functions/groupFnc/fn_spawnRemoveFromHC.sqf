/*
Original name: pl_spawn_remove_hc
New name:      KMD_fnc_spawnRemoveFromHC
Original url: "Plmod\pl_group_fnc.sqf"
*/
    {
        [_x] spawn pl_remove_from_hc;
    } forEach hcSelected player;  