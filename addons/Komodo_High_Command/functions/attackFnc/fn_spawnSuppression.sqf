/*
Original name: pl_spawn_suppression
New name:      KMD_fnc_spawnSuppression
Original url: "Plmod\pl_attack_fnc.sqf"
*/
playsound "beep";
{  
    [units _x] spawn KMD_fnc_suppressiveFire;

} forEach hcSelected player;