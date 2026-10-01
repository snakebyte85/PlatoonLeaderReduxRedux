/*
Original name: pl_open_fire
New name:      KMD_fnc_openFire
Original url: "Plmod\pl_misc_fnc.sqf"
*/
    params ["_group"];

    playSound "beep";

    _group setCombatMode "YELLOW";
    _group setVariable ["pl_hold_fire", false];
    _group setVariable ["pl_combat_mode", false];