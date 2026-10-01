/*
Original name: pl_spawn_set_unit_pos
New name:      KMD_fnc_spawnSetUnitPos
Original url: "Plmod\pl_misc_fnc.sqf"
*/
    params ["_stance"];

    {
        [_x, _stance] spawn KMD_fnc_setUnitPos;
    } forEach hcSelected player;  