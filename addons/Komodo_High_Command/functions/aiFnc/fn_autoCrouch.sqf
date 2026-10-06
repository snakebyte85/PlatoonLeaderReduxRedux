/*
Original name: pl_auto_crouch
New name:      KMD_fnc_autoCrouch
Original url: "Plmod\pl_ai_fnc.sqf"
*/

params ["_unit"];
while {alive _unit} do {
    if ((behaviour _unit) isEqualTo "AWARE") then {
        if !((group _unit) getVariable ["onTask", false]) then {
            if ((speed _unit) == 0) then {
                _unit setUnitPos "MIDDLE";
                waitUntil {sleep 2; (speed _unit) > 0 or !(alive _unit)};
                _unit setUnitPos "AUTO";
            };
        };
    };
    sleep 3;
};  
