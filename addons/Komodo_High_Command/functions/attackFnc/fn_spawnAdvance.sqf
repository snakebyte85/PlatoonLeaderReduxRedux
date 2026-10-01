/*
Original name: pl_spawn_advance
New name:      KMD_fnc_spawnAdvance
Original url: "Plmod\pl_attack_fnc.sqf"
*/
{
    [_x] spawn KMD_fnc_advance;

} forEach hcSelected player;