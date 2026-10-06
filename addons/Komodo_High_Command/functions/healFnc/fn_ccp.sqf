/*
Original name: pl_ccp
New name:      KMD_fnc_ccp
Original url: "Plmod\pl_heal_fnc.sqf"
*/

    params [["_group", hcSelected player select 0], ["_isMedevac", false], ["_escort", nil]];
    private ["_medic", "_healTarget", "_escort", "_group", "_ccpPos", "_markerNameOuter", "_markerNameInner", "_markerNameCCP"];

    // _group = hcSelected player select 0;
    if (vehicle (leader _group) != leader _group) exitWith {hint "Infantry ONLY Task!"};
 

    // _medic = ((units _group) select {(typeOf _x) in pl_medic_cls_names}) select 0;
    {
        if (getNumber ( configFile >> "CfgVehicles" >> typeOf _x >> "attendant" ) isEqualTo 1) then {
            _medic = _x;
        };
    } forEach (units _group);
    // _escort = nil;
    // player sideChat "erstens is da";
    if !(isNil "_medic") then {
        // player sideChat "Medic is da";
        if !(_medic getVariable ["pl_wia", false]) then {

            [_group] call KMD_fnc_reset;
            sleep 0.2;

            playSound "beep";

            if (count (units _group) > 2) then {
                {
                    if (_x != _medic and _x != (leader _group) and !(_x getVariable "pl_wia") and (alive _x)) exitWith {
                        _escort = _x;
                    };
                } forEach (units _group);
            };
            _group setVariable ["onTask", true];
            _group setVariable ["setSpecial", true];
            _group setVariable ["specialIcon", "\Komodo_High_Command\gfx\CCP.paa"];
            _ccpGuard = (units _group) - [_medic];
            if !(isNil "_escort") then {
                _escort setVariable ["pl_is_ccp_medic", true];
               _ccpGuard = _ccpGuard - [_escort]
            };
            // {
            //     [_x, getPos leader _group, getDir leader _group, 20, false] spawn KMD_fnc_findCover;
            // } forEach _ccpGuard;

            _medic setVariable ["pl_damage_reduction", true];
            _medic setVariable ["pl_is_ccp_medic", true];

            if(pl_enable_revival) then {
                _markerNameOuter = str (random 2);
                createMarker [_markerNameOuter, getPos (leader _group)];
                _markerNameOuter setMarkerShape "ELLIPSE";
                _markerNameOuter setMarkerBrush "DiagGrid";
                _markerNameOuter setMarkerColor "colorBLUFOR";
                _markerNameOuter setMarkerAlpha 0.4;
                _markerNameOuter setMarkerSize [pl_ccp_revive_range, pl_ccp_revive_range];
            };

            _markerNameInner = str (random 2);
            createMarker [_markerNameInner, getPos (leader _group)];
            _markerNameInner setMarkerShape "ELLIPSE";
            _markerNameInner setMarkerBrush "DiagGrid";
            _markerNameInner setMarkerColor "colorGreen";
            _markerNameInner setMarkerAlpha 0.4;
            _markerNameInner setMarkerSize [pl_ccp_heal_range, pl_ccp_heal_range];

            _markerNameCCP = str (random 3);
            createMarker [_markerNameCCP, getPos (leader _group)];
            _markerNameCCP setMarkerType "marker_CCP";
            _markerNameCCP setMarkerColor [side _group] call KMD_fnc_sideToMarkerColor;

            _ccpPos = getPos (leader _group);

            sleep 1;

            while {(_group getVariable ["onTask", true]) and (alive _medic) and !(_medic getVariable ["pl_wia", false])} do {
                // player sideChat "Loop is da";
                _reviveTargets = [];
                if(pl_enable_revival) then {
                    _reviveTargets = _ccpPos nearObjects ["Man", pl_ccp_revive_range];
                };
                _healTargets = _ccpPos nearObjects ["Man", pl_ccp_heal_range];
                
                               
                {
                    if (_x getVariable ["pl_wia", false] and !(_x getVariable "pl_beeing_treatet")) then {
                        if !(isNil "_escort") then {
                            _h1 = [_group, _medic, _escort, _x, _ccpPos, 10] spawn KMD_fnc_ccpReviveAction;
                            waitUntil {(scriptDone _h1) or !(_group getVariable ["onTask", true])};
                        }
                        else
                        {
                            _h1 = [_group, _medic, nil, _x, _ccpPos, 10] spawn KMD_fnc_ccpReviveAction;
                            waitUntil {(scriptDone _h1) or !(_group getVariable ["onTask", true])};
                        };
                    };
                } forEach (_reviveTargets select {_x getVariable ["pl_wia", false]});
                
                
                {
                    if ((_x getVariable "pl_injured") and (alive _x) and !(_x getVariable "pl_wia")) then {
                        _h2 = [_medic, _x, _ccpPos] spawn KMD_fnc_medicHeal;
                        _time = time + 30;
                        waitUntil {scriptDone _h2 or !(_group getVariable ["onTask", true]) or (time > _time)}
                    };
                } forEach (_healTargets select {side _x isEqualTo playerSide});
                sleep 0.1;
                _medic enableAI "AUTOCOMBAT";
                _medic enableAI "AUTOTARGET";
                _medic enableAI "TARGET";
                // _medic enableAI "FSM";
            };

            _group setVariable ["setSpecial", false];
            _group setVariable ["onTask", false];
            _medic setVariable ["pl_damage_reduction", false];
            _medic setVariable ["pl_is_ccp_medic", false];
            if !(isNil "_escort") then {
                _escort setVariable ["pl_is_ccp_medic", false];
            };
            deleteMarker _markerNameCCP;
            if(pl_enable_revival) then {
                deleteMarker _markerNameOuter;
            };
            deleteMarker _markerNameInner;
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
