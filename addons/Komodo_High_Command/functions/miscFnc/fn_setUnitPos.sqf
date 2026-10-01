/*
Original name: pl_set_unit_pos
New name:      KMD_fnc_setUnitPos
Original url: "Plmod\pl_misc_fnc.sqf"
*/
    params ["_group", "_stance"];

    {
        _x setUnitPos _stance;
    } forEach (units _group);
