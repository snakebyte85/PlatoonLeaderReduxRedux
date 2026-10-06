/*
Original name: pl_medical_setup
New name:      KMD_fnc_medicalSetup
Original url: "Plmod\pl_ai_fnc.sqf"
*/
params ["_unit"];
_unit setVariable ["pl_beeing_treatet", false];
_unit setVariable ["pl_wia_calledout", false];
_unit setVariable ["pl_injured", false];
_unit setVariable ["pl_bleedout_time", 400];
_unit setVariable ["pl_bleedout_set", false];
_unit setVariable ["pl_damage_reduction", false];

_unit addEventHandler ['HandleDamage', KMD_fnc_onDamage];
