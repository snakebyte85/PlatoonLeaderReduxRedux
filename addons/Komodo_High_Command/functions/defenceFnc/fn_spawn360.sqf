/*
Original name: pl_spawn_360
New name:      KMD_fnc_spawn360
Original url: "Plmod/pl_defence_fnc.sqf"
*/
    {
        [_x, 13] spawn KMD_fnc_atMapPos360;
    } forEach hcSelected player;