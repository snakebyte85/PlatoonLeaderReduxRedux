/*
Original name: (Called directly in the file)
New name:      KMD_fnc_entityKilledEh
Original url: "Plmod\init.sqf"
*/

addMissionEventHandler ["EntityKilled",{
    params ["_killed", "_killer", "_instigator", "_useEffects"];
    
    if (!pl_contact_report_enabled || group _killed == group player || group _killer == group player ) exitWith {};
        
    if ((side group _killed) isEqualto playerSide) then {
    
        if ( group _killed in hcAllGroups player) then {
        
            format ["DAMN! One of our killed! %1", _killed] call KMD_fnc_debug;
    
            if (vehicle _killed == _killed && _killed isKindOf "Man") then {
                _leader = leader (group _killed);
                _unitMos = getText (configFile >> "CfgVehicles" >> typeOf _killed >> "displayName");
                _unitName = name _killed;
                _killed setVariable ["pl_wia", false];
                [_killed] spawn KMD_fnc_drawKia;
                _group = group _killed;
                _mags = _group getVariable "magCountAllDefault";
                _mag = _group getVariable "magCountSoloDefault";
                _mags = _mags - _mag;
                _group setVariable ["magCountAllDefault", _mags];

                playSound "beep";
                _leader sideChat format ["%1 K.I.A", _unitMos];
            } else {
                 if ( _killed isKindOf "Vehicle" && time >= pl_vehicle_destroyed_report_cd) then {
                     _vic = vehicle _killed;
                     _vicName = getText (configFile >> "CfgVehicles" >> typeOf _vic >> "displayName");
                     _group sideChat format ["%1 was destroyed", _vicName];
                     pl_vehicle_destroyed_report_cd = time + 3;
                 };
             };
        };   
    }
    else
    {
        if ( group _killer in hcAllGroups player ) then {
        
            format ["NICE! We killed one of theirs! %1", _killed] call KMD_fnc_debug;
            
            _typeStr = "";
            if (_killed isKindOf "Vehicle") then {                
                _typeStr = getText (configFile >> "CfgVehicles" >> typeOf _killed >> "displayName");
            } else {
                if(_killed isKindOf "Man" && ({ alive _x } count units (group _killed)) == 0 ) then {
                    _typeStr = "Infantry unit";
                };
            };

            if(_typeStr != "") then {
                
                playSound "beep";
                _killer sideChat format ["Destroyed enemy %1",  _typeStr];
                    
            };            
        };
    };
}];
