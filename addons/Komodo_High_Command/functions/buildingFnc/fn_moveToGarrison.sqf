/*
Original name: pl_move_to_garrison
New name:      KMD_fnc_moveToGarrison
Original url: "Plmod\pl_building_fnc.sqf"
*/
    params ["_unit", "_pos"];
    _unit disableAI "AUTOCOMBAT";
    _unit doMove _pos;
    _unit moveTo _pos;
    waitUntil {(unitReady _unit) or !(alive _unit) or (_unit getVariable ["pl_wia", false]) or !((group _unit) getVariable ["onTask", true])};
    if ((group _unit) getVariable ["onTask", true]) then {
        doStop _unit;
        _unit disableAI "PATH";
        _unit enableAI "AUTOCOMBAT";
    };
