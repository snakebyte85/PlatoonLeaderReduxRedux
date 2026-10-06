/*
called by the eventhandler set in the "KMD_fnc_medicalSetup" function.
*/

params['_unit', '_selName', '_damage', '_source'];
if ((_unit getVariable "pl_damage_reduction") or (_unit getVariable ["pl_special_force", false])) then {
    _dmg = _damage * 0.7 ;
    _damage = _dmg;
};

if !(_unit getVariable "pl_wia") then {
    if (_damage > 0.99) then {
        if ( pl_enable_revival && (([0, 100] call BIS_fnc_randomInt) > pl_death_chance) ) then {
            _damage = 0;
            _unit setUnconscious true;
            if !(_unit getVariable "pl_wia_calledout") then {
                [_unit] spawn KMD_fnc_wiaCallout;
            };
            if !(_unit getVariable "pl_bleedout_set") then {
                [_unit] spawn KMD_fnc_bleedOut;
            };
        };
    }
    else
    {
        if(_damage > 0.1) then {
            _unit setVariable ["pl_injured", true];
        };
    };
};

_damage;
