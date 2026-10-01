/*
Original name: pl_crew_eject
New name:      KMD_fnc_crewEject
Original url: "Plmod\pl_repair_fnc.sqf"
*/
    params ["_unit", "_vic"];
    _pos = [[[getPos _vic, 8]],[]] call BIS_fnc_randomPos;
    _unit setPos _pos;
    _dir = [1, 359] call BIS_fnc_randomInt;
    _unit setDir _dir;
    unassignVehicle (_unit);
    doGetOut (_unit);
    group _unit setVariable ["pl_show_info", true];
    group _unit setVariable ["onTask", false];
