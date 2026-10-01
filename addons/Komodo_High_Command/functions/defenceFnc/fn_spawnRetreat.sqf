/*
Original name: pl_spawn_retreat
New name:      KMD_fnc_spawnRetreat
Original url: "Plmod/pl_defence_fnc.sqf"
*/
    {
        [_x] spawn pl_retreat;
    } forEach hcSelected player;
