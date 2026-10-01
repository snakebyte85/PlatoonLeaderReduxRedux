/*
Original name: pl_auto_unstuck
New name:      KMD_fnc_autoUnstuck
Original url: "Plmod\pl_ai_fnc.sqf"
*/
params ["_unit"];
if (group _unit != group player and (time >= _unit getVariable "pl_unstuck_cd")) then {
    _distance = _unit distance2D leader (group _unit);
    if (_distance > 150) then {
        [_unit] spawn KMD_fnc_hardReset;
        _unit setVariable ["pl_unstuck_cd", time + 90];
        _pos = (getPos _unit) findEmptyPosition [0, 30];
        _unit setPos _pos;
        _unit doFollow leader (group _unit);
    };
};
