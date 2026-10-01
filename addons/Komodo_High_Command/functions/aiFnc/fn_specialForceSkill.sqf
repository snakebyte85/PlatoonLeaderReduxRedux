/*
Original name: pl_special_forces_skills
New name:      KMD_fnc_specialForceSkill
Original url: "Plmod\pl_ai_fnc.sqf"
*/

params ["_unit"];
private ["_targets"];

_unit setSkill 1;
while {alive _unit} do {
    sleep 10;
    _targets = (getPos _unit) nearEntities [["Man", "Tank", "Car", "Truck"], 100];
    {
        _unit reveal [_x, 3];
    } forEach _targets select {!(side _x isEqualTo playerSide)};
};