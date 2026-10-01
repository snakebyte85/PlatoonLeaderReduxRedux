/*
Original name: pl_spawn_watch_dir
New name:      KMD_fnc_spawnWatchDir
Original url: "Plmod\pl_misc_fnc.sqf"
*/
    {
        [_x] spawn KMD_fnc_watchDir;
    } forEach hcSelected player; 