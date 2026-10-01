/*
Original name: (Called directly in the file)
New name:      KMD_fnc_groupIconClickEh
Original url: "Plmod\init.sqf"
*/
addMissionEventHandler ["GroupIconClick", {
    params [
        "_is3D", "_group", "_waypointId",
        "_mouseButton", "_posX", "_posY",
        "_shift", "_control", "_alt"];
    private ["_vic", "_vicGroup"];

    if (side _group == playerSide) then {
        playsound "beep";
        if ((vehicle (leader _group)) != (leader _group)) then {
            _vic = vehicle (leader _group);
            // player sideChat str _vic;
            _vicGroup = group (driver _vic);
            // player sideChat str _vicGroup;
            [_vicGroup] spawn {
                params ["_vicGroup"];
                sleep 0.35;
                player hcSelectGroup [_vicGroup];
            };
        };
        if (pl_add_group_to_hc) then {
            if (_group getVariable ["pl_not_addalbe", false]) exitWith {pl_add_group_to_hc = false; hint "Group cant be added!"};
            [_group ] spawn KMD_fnc_addToHcExecute;
            [_group] spawn pl_set_up_ai;
        };
        if (missionNamespace getVariable ["pl_select_formation_leader", false]) then {
            missionNamespace setVariable ["pl_formation_leader", _group];
            missionNamespace setVariable ["pl_select_formation_leader", false];
            if (_shift) then {
                missionNamespace setVariable ["pl_formation_cancel", true];
            }
            else 
            {
                missionNamespace setVariable ["pl_formation_cancel", false]
            };
        };
        if (missionNamespace getVariable ["pl_transfer_medic_enabled", false]) then {
            missionNamespace setVariable ["pl_transfer_medic_enabled", false];
            missionNamespace setVariable ["pl_transfer_medic_group", _group];
        };
    };
}];