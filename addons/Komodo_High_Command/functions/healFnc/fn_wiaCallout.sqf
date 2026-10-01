/*
Original name: pl_wia_callout
New name:      KMD_fnc_wiaCallout
Original url: "Plmod\pl_heal_fnc.sqf"
*/
params ["_unit"];
sleep 3;
_unit setVariable ["pl_wia_calledout", true];
sleep 3;
_unit setVariable ["pl_wia", true];
if (alive _unit and (_unit getVariable "pl_wia_calledout")) then {
    _unit setVariable ["pl_wia_calledout", false];
    _unitMos = getText (configFile >> "CfgVehicles" >> typeOf _unit >> "displayName");
    // leader (group _unit) sideChat format ["%1 is W.I.A, requesting Medic, over", _unitMos];
    playSound "beep";
    leader (group _unit) sideChat format ["%1: %2 WOUNDED", groupId (group _unit), _unitMos];
};