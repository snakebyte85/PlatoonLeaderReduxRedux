/*
Original name: pl_spawn_attack
New name:      KMD_fnc_spawnAttack
Original url: "Plmod\pl_attack_fnc.sqf"
*/

{
    [_x] spawn KMD_fnc_attack;

} forEach hcSelected player;