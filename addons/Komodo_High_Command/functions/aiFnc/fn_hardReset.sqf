/*
Original name: pl_hard_reset
New name:      KMD_fnc_hardReset
Original url: "Plmod\pl_ai_fnc.sqf"
*/
params ["_unit"];

_origGroup = group _unit;
_pos = getPosATL _unit ;
_damage = damage _unit;
_dir = getDir _unit ;
_type = typeOf _unit ;
_name = name _unit ;
_nameSound = nameSound _unit ;
_face = face _unit ;
_speaker = speaker _unit ;
_loadout = getUnitLoadout _unit ;
_unitWia = _unit getVariable "pl_wia";
    // _wpnCargo = getWeaponCargo (_pos nearestObject "weaponHolderSimulated");
deleteVehicle _unit;

_newUnit = _origGroup createUnit [_type,_pos,[],0,"CAN_COLLIDE"] ;
_newUnit setDir _dir ;
_newUnit setUnitLoadout _loadout ;
    // _newUnit addWeapon (_wpnCargo select 0 select 0) ;
_newUnit setName _name ;
_newUnit setNameSound _nameSound ;
_newUnit setFace _face ;
_newUnit setSpeaker _speaker ;
_newUnit setDamage _damage;
_newUnit setHit ["legs", 0];
_newUnit setVariable ["pl_wia", false];
_newUnit setVariable ["pl_unstuck_cd", 0];

// [_newUnit] spawn KMD_fnc_autoCrouch;

if (pl_enabled_medical) then {
    [_newUnit] call KMD_fnc_medicalSetup; 
    sleep 0.1;
    if (_unitWia) then {
        _newUnit setUnconscious true;
        _newUnit setVariable ["pl_bleedout_time", 150];
        sleep 2;
        _newUnit setVariable ["pl_wia", true];
        sleep 1;
        [_newUnit] spawn KMD_fnc_bleedOut;
    };
};