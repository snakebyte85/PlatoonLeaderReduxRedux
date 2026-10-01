/*
Original name: pl_spawn_heal_group
New name:      KMD_fnc_spawnHealGroup
Original url: "Plmod\pl_heal_fnc.sqf"
*/
    {
        [_x] spawn KMD_fnc_healGroup;
    } forEach hcSelected player;