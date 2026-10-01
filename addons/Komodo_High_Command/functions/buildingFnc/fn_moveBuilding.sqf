/*
Original name: pl_move_building
New name:      KMD_fnc_moveBuilding
Original url: "Plmod\pl_building_fnc.sqf"
*/
    params ["_unit", "_buildPosArray", "_building"];

    _currentPos = 0;
    for "_i" from 0 to (count(_buildPosArray) - 1) do {
        _pos = _buildPosArray select _i;
        _unit doMove _pos;
        _unit moveTo _pos;
        waitUntil {(unitReady _unit) or (!alive _unit) or (_unit getVariable ["pl_wia", false]) or !((group _unit) getVariable ["onTask", true])};
        if ((!alive _unit) or (_unit getVariable ["pl_wia", false]) or !((group _unit) getVariable ["onTask", true])) exitWith {};
        doStop _unit;
    };
    if (alive _unit and (group _unit) getVariable ["onTask", true]) then {
        _unit enableAI "AUTOCOMBAT";
        _unit limitSpeed 5000;
        _unit setVariable ["pl_damage_reduction", false];
        [_unit, _building] spawn KMD_fnc_guardBuilding;
    };