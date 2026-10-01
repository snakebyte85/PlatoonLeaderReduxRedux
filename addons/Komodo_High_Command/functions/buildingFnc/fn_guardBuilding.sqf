/*
Original name: pl_guard_building
New name:      KMD_fnc_guardBuilding
Original url: "Plmod\pl_building_fnc.sqf"
*/
    params ["_unit", "_building"];

    _pos = [[[(getPos _building), 40]],[]] call BIS_fnc_randomPos;
    _pos = _pos findEmptyPosition [0, 10];
    _unit doMove _pos;
    _unit moveTo _pos;

    sleep 2;
    waitUntil {sleep 0.1; (unitReady _unit) or (!alive _unit) or (_unit getVariable ["pl_wia", false]) or !((group _unit) getVariable ["onTask", true])};
    if !((group _unit) getVariable ["onTask", true]) exitWith {};
    _unit disableAI "PATH";
    _unit setUnitPos "MIDDLE";
