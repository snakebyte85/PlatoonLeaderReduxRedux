/*
Original name: pl_contact_report
New name:      KMD_fnc_contactReport
Original url: "Plmod\pl_ai_fnc.sqf"
*/
params ["_group", "_inTransport"];
private ["_leader"];

format ["Enabling contact report for %1", _group] call KMD_fnc_debug;

_leader = leader _group;
_leader setVariable ["PlContactRepEnabled", true];
_group setVariable ["PlContactTime", 0];
if !(_inTransport) then {
    if (vehicle _leader != _leader) then {
        _leader = vehicle _leader;
    };
};

if (_leader != player) then {
    _index = _leader addEventHandler ["FiredNear", {
        params ["_unit", "_firer", "_distance", "_weapon", "_muzzle", "_mode", "_ammo", "_gunner"];
        
        format ["Firing near %1, it was %2", _unit, _firer] call KMD_fnc_debug;


        if ((group _firer) isEqualTo (group _unit)) then {
        	if (((group _unit) getVariable "PlContactTime") < time) then {
                _target = getAttackTarget _unit;
                _target_display_name = "";
                if( _target isKindOf "Man" && vehicle _target == _target) then {
                    if((count units (group _target)) == 1) then {
                        _target_display_name = [configOf _target] call BIS_fnc_displayName;
                    } else {
                        _target_display_name = "infantry unit";
                    };
                } else {
                    _target_display_name = [configOf _target] call BIS_fnc_displayName;
                };
                
                playSound "beep";
                _unit sideChat format["Engaging %1", _target_display_name];
                
                (group _unit) setVariable ['inContact', true];
            };
            (group _unit) setVariable ["PlContactTime", (time + 60)];
            if ("launch" in (_weapon splitString "_")) then {
                if (pl_At_fire_report_cd < time) then {
                    pl_At_fire_report_cd = time + 5;
                   
                    _unit sideChat "Engaging enemy armor with AT";
                };
            };
        };
    }];
    
    private _knownTargets = createHashMap;
    
    while { alive _leader && _group in (hcAllGroups player) } do {       
        
        _targets = _group targets [true, 1000];
        
        _currentTargets = createHashMap;
        
        {
            _group_target = group _x;
            _currentTargets set [netid _group_target, _group_target];
        
        } forEach _targets;
        
        {            
            if( !(_y getVariable["pl_spotted",false]) ) then {
                format ["%1 SPOTTED NEW ENEMY! %2", _group, _y] call KMD_fnc_debug;
                _y setVariable["pl_spotted", true];
                _target_display_name=[_y] call KMD_fnc_displayName;
                playSound "beep";
                _leader sideChat format["Spotted enemy %1", _target_display_name];
            };
        } forEach _currentTargets;
        
        {
            if( !_x in _currentTargets ) then {
                format ["Group %1 forgot old spotted target %2", _group, _y] call KMD_fnc_debug;
                _y setVariable["pl_spotted", false];
                _knownTargets deleteAt _x;
            }
        
        } forEach _knownTargets;
    
        sleep 5;
    };
    
    format ["Leader %1 not alive or not in hc group, he won't contact report anymore.", _leader] call KMD_fnc_debug;
    _leader setVariable ["PlContactRepEnabled", false];
    _leader removeEventHandler["FiredNear", _index];
    
};
