/*
Original name: pl_ai_setUp_loop
New name:      KMD_fnc_aiSetupLoop
Original url: "Plmod\pl_ai_fnc.sqf"
*/
while {true} do {
    {
        if (side _x isEqualTo playerSide) 
		then {[_x]spawn KMD_fnc_vehicleSetup}
        else{
                _x limitSpeed 45;
                _x setUnloadInCombat [true, true];
        };
    
	} forEach vehicles;

{
    if (side _x isEqualTo playerSide) then {
        if (isNil {_x getVariable "spotRepEnabled"}) 
		then{[_x] spawn KMD_fnc_shareInfo};

        if (isNil {(leader _x) getVariable "PlContactRepEnabled"}) 
		then{[_x, false] spawn KMD_fnc_contactReport};

        if (isNil{_x getVariable "aiSetUp"})
		then{[_x] call KMD_fnc_setupAi};

        // unit Reset loop
        {
            if !(lifeState _x isEqualTo "INCAPACITATED") 
			then {[_x] call KMD_fnc_autoUnstuck;
                        if (_x getVariable "pl_wia") then {
                            _x setVariable ["pl_wia", false];
                        };
                    };
        } forEach (units _x);
        
		}else{
                if (pl_opfor_info_share_enabled
				&&{isNil {_x getVariable "spotRepEnabled"}}) 
				then {[_x] spawn KMD_fnc_shareInfoOpfor};
        };

        if(_x != (group player)) then {
            if !(_x getVariable ["pl_combat_mode", false]) then {
                _x enableAttack false;
                _x setCombatMode "YELLOW";
            };
        };

    } forEach allGroups;

        sleep 20;
    };