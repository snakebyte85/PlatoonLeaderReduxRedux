/*
Original name: pl_execute
New name:      KMD_fnc_execute
Original url: "Plmod\pl_misc_fnc.sqf"
*/
    params ["_group"];
    playSound "beep";

    {
        _x enableAI "PATH";
        // _x doFollow (leader _group);
    } forEach (units _group);