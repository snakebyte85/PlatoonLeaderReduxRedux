/*
Original name: pl_ai_setUp_loop
New name:      KMD_fnc_aiSetupLoop
Original url: "Plmod\pl_ai_fnc.sqf"
*/
while {true} do {

    { 
        {
            if( vehicle _x != _x ) then {
                [_x]spawn KMD_fnc_vehicleSetup;
            };

            // unit Reset loop (for now I disable it, it's kinda too much?
            /*if !(lifeState _x isEqualTo "INCAPACITATED") then {
                [_x] call KMD_fnc_autoUnstuck;
                if (_x getVariable "pl_wia") then {
                    _x setVariable ["pl_wia", false];
                };
            };*/            
        
        } forEach ((units _x) select { side _x == playerSide });
        
                   
            
        if (pl_contact_report_enabled && isNil {(leader _x) getVariable "PlContactRepEnabled"}) then { 
            [_x, false] spawn KMD_fnc_contactReport
        };

        if (isNil{_x getVariable "aiSetUp"}) then {
            [_x] call KMD_fnc_setupAi
        };
        
        if(_x != (group player)) then {
            if !(_x getVariable ["pl_combat_mode", false]) then {
                _x enableAttack false;
                _x setCombatMode "YELLOW";
            };
        };

    } forEach hcAllGroups player;

    // player side info share
    if (pl_player_side_info_share_enabled) then {
        {
            if(isNil {_x getVariable "spotRepEnabled"}) then {
                [_x] spawn KMD_fnc_shareInfo;
            };
        } forEach (allGroups select { side _x == playerSide });
    };
        
    // opfor side info share
    if (pl_opfor_info_share_enabled) then {
        {
            if(isNil {_x getVariable "spotRepEnabled"}) then {
                [_x] spawn KMD_fnc_shareInfoOpfor;
            };
        } forEach (allGroups select { (side _x != playerSide) && (side _x != civilian) });
    };

    sleep 20;
};