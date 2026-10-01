/*
Original name: pl_bounding_move
New name:      KMD_fnc_boundingMove
Original url: "Plmod\pl_attack_fnc.sqf"
*/

    params ["_unit", "_pos", "_cords", "_moveDir", ["_atkRange", 1.5]];
    _unit disableAI "AUTOCOMBAT";
    _unit disableAI "SUPPRESSION";
    _unit disableAI "COVER";
    _unit disableAI "TARGET";
    _unit disableAI "AUTOTARGET";
        // _unit disableAI "FSM";
    _unit setVariable ["pl_bounding_set", false];
    _unit doMove _pos;
    _unit moveTo _pos;
    sleep 2;
    waitUntil {(!alive _unit) or (unitReady _unit) or ((_unit distance2D _pos) < _atkRange) or (_unit getVariable["pl_wia", false] or !((group _unit) getVariable ["onTask", true]))};
    _unit enableAI "AUTOCOMBAT";
    _unit enableAI "TARGET";
    _unit enableAI "AUTOTARGET";
    _unit enableAI "SUPPRESSION";
    _unit enableAI "COVER";
    // _unit enableAI "FSM";
    _unit setUnitPos "UP";
    sleep 0.1;
    if ((group _unit) getVariable ["onTask", true] and (_atkRange == 1.5)) then {
        _unit setVariable ["pl_bounding_set", true];
        [_unit, _cords, _moveDir, 3, false] spawn KMD_fnc_findCover;
    };
