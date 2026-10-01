/*
Original name: pl_heal_group
New name:      KMD_fnc_healGroup
Original url: "Plmod\pl_heal_fnc.sqf"
*/
    params ["_group", ["_targetGroup", objNull]];
    private ["_medic", "_healTarget", "_escort"];

    if (vehicle (leader _group) != leader _group) exitWith {hint "Infantry ONLY Task!"};

    // _medic = ((units _group) select {(typeOf _x) in pl_medic_cls_names}) select 0;
    {
        if (getNumber ( configFile >> "CfgVehicles" >> typeOf _x >> "attendant" ) isEqualTo 1) then {
            _medic = _x;
        };
    } forEach (units _group);
    // _escort = nil;
    if !(isNil "_medic") then {
        if !(_medic getVariable "pl_wia") then {

            [_group] call KMD_fnc_reset;
            sleep 0.2;

            playSound "beep";

            _group setVariable ["onTask", true];
            _group setVariable ["setSpecial", true];
            _group setVariable ["specialIcon", "\A3\ui_f\data\igui\cfg\simpleTasks\types\heal_ca.paa"];
            _medic setVariable ["pl_is_ccp_medic", true];
            // _medic disableAI "FSM";
            _medic disableAI "AUTOCOMBAT";
            sleep 2;
            
            if(isNull _targetGroup) then {
                _targetGroup = _group;
            };
            
            while {(_group getVariable "onTask")} do {
                // if (_group isEqualTo grpNull) exitWith {};
                // _reviveTargets = (getPos leader _group) nearObjects ["Man", 50];
                {
                    if (_x getVariable ["pl_wia", false] and !(_x getVariable "pl_beeing_treatet")) then {
                        _h1 = [_group, _medic, nil, _x, getPos (leader _group), 50] spawn KMD_fnc_ccpReviveAction;
                        waitUntil {sleep 0.1; scriptDone _h1 or !(_group getVariable ["onTask", true])}
                    };
                } forEach ((units _targetGroup) select {_x getVariable ["pl_wia", false]});;
                // _medic sideChat "Tick";
                {
                    if ((_x getVariable "pl_injured") and (alive _x) and !(_x getVariable "pl_wia") and !(lifeState _x isEqualTo "INCAPACITATED")) then {
                        _h1 = [_medic, _x, nil] spawn KMD_fnc_medicHeal;
                        waitUntil {sleep 0.1; scriptDone _h1 or !(_group getVariable ["onTask", true])}
                    };
                } forEach (units _targetGroup);
                sleep 1;
            };

            sleep 1;

            _medic setVariable ["pl_is_ccp_medic", false];
        }
        else
        {
            // playSound "beep";
            hint "Medic is wounded!";
        };
    }
    else
    {
        // playSound "beep";
        hint "The group has no medic!";
    };
