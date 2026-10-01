/*
Original name: pl_move_to_360
New name:      KMD_fnc_moveTo360
Original url: "Plmod/pl_defence_fnc.sqf"
*/
    params ["_unit", "_posArray"];
    private ["_pos", "_watchPos"];
    _pos = _posArray select 0;
    _watchPos = _posArray select 1;
    if (vehicle _unit != _unit) exitWith {};
    sleep 0.1;
    doStop _unit;
    _unit setUnitPos "MIDDLE";
    sleep 0.2;
    _unit moveTo _pos;
    _time = time + 100;
    waitUntil {sleep 1; (time > _time || !alive _unit || moveToCompleted _unit || currentCommand _unit != "STOP") or !((group _unit) getVariable ["onTask", true])};
    _unit doWatch _watchPos;
    _time = time + 600;
    waitUntil {sleep 2; (time > _time || !alive _unit || currentCommand _unit != "STOP") or !((group _unit) getVariable ["onTask", true])};
    _unit doWatch objNull;
    _unit setUnitPos "AUTO";