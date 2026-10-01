/*
Original name: pl_enemy_destroyed_report
New name:      KMD_fnc_enemyDestroyedReport
Original url: "Plmod\pl_ai_fnc.sqf"
*/
params ["_unit", "_killer", "_group"];
_typeStr = "Infantry Unit";
if (vehicle _unit != _unit) then {
    _vic = vehicle _unit;
    _typeStr = getText (configFile >> "CfgVehicles" >> typeOf _vic >> "displayName");
};

_time = time + 10;
waitUntil {time >= _time};
_unitsAlive = false;
{
    if (alive _x) then {
        _unitsAlive = true;
    };
} forEach (units _group);

if !(_unitsAlive) then {
        if (isNil {_group getVariable "pl_death_reported"}) then {
        _gridPos = mapGridPosition _unit;
        _group setVariable ["pl_death_reported", true];
        playSound "beep";
        _killer sideChat format ["%1 destroyed enemy %2", groupId (group _killer), _typeStr];
    };
};