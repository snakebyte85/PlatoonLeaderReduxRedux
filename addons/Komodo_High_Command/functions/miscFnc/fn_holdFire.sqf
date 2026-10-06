/*
Original name: pl_hold_fire
New name:      KMD_fnc_holdFire
Original url: "Plmod\pl_misc_fnc.sqf"
*/
    params ["_group"];

    playSound "beep";

    _group setCombatMode "GREEN";
    _group setVariable ["pl_hold_fire", true];
    _group setVariable ["pl_combat_mode", true];
