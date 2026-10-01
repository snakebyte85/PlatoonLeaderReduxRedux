/*
Original name: pl_hold
New name:      KMD_fnc_hold
Original url: "Plmod\pl_misc_fnc.sqf"
*/
    params ["_group"];
    playSound "beep";
    {
        // doStop _x;
        _x disableAI "PATH";   
    } forEach (units _group);  
