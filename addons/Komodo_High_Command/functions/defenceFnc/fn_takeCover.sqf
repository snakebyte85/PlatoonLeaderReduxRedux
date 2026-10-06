/*
Original name: pl_take_cover
New name:      KMD_fnc_takeCover
Original url: "Plmod/pl_defence_fnc.sqf"
*/
    params ["_group"];

    if (vehicle (leader _group) != leader _group) exitWith {hint "Infantry ONLY Task!"};

    [_group] call KMD_fnc_reset;

    sleep 0.2;

    playSound "beep";

    _dir = getDir leader _group;
    _watchPos = getPos leader _group;
    _group setVariable ["setSpecial", true];
    _group setVariable ["onTask", true];
    _group setVariable ["specialIcon", "\A3\ui_f\data\igui\cfg\simpleTasks\types\defend_ca.paa"];

    {
        [_x, _watchPos, _dir, 20, false] spawn KMD_fnc_findCover;
    } forEach (units _group);
