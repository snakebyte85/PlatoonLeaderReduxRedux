/*
Original name: pl_spawn_hard_reset
New name:      KMD_fnc_spawnHardReset
Original url: "Plmod\pl_ai_fnc.sqf"
*/
{
    {
        [_x] spawn KMD_fnc_hardReset;
    } forEach (units _x);

} forEach hcSelected player;

true;