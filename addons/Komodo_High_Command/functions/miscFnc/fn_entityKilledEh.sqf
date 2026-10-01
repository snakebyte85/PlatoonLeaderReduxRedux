/*
Original name: (Called directly in the file)
New name:      KMD_fnc_entityKilledEh
Original url: "Plmod\init.sqf"
*/
addMissionEventHandler ["EntityKilled",{
    params ["_killed", "_killer", "_instigator", "_useEffects"];
    if ((side group _killed) isEqualto playerside) then {
        if (vehicle _killed == _killed and _killed isKindOf "Man") then {
            _leader = leader (group _killed);
            _unitMos = getText (configFile >> "CfgVehicles" >> typeOf _killed >> "displayName");
            _unitName = name _killed;
            _killed setVariable ["pl_wia", false];
            [_killed] spawn pl_draw_kia;
            _group = group _killed;
            _mags = _group getVariable "magCountAllDefault";
            _mag = _group getVariable "magCountSoloDefault";
            _mags = _mags - _mag;
            _group setVariable ["magCountAllDefault", _mags];

            playSound "beep";
            _leader sideChat format ["%1: %2 K.I.A", groupId (group _killed), _unitMos];
        };
        // else
        // {
        //     if (time >= pl_vehicle_destroyed_report_cd) then {
        //         _vic = vehicle _killed;
        //         _vicName = getText (configFile >> "CfgVehicles" >> typeOf _vic >> "displayName");
        //         player sideChat format ["%1 was destroyed", _vicName];
        //         pl_vehicle_destroyed_report_cd = time + 3;
        //     };
        // };
    }
    else
    {
        if (_killed isEqualTo (leader (group _killed))) then {
            [_killed, _killer, (group _killed)] spawn pl_enemy_destroyed_report;
        };
    };
}];