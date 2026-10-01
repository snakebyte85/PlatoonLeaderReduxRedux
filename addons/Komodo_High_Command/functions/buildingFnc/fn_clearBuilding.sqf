/*
Original name: pl_clear_building
New name:      KMD_fnc_clearBuilding
Original url: "Plmod\pl_building_fnc.sqf"
*/
    private ["_group", "_building", "_targetPos"];
    _group = hcSelected player select 0;
    if (vehicle (leader _group) != leader _group) exitWith {hint "Infantry ONLY Task!"};

    if (visibleMap) then {
        hint "Select on MAP";
        onMapSingleClick {
            pl_building_search_cords = _pos;
            pl_mapClicked = true;
            hintSilent "";
            onMapSingleClick "";
        };
        while {!pl_mapClicked} do {sleep 0.1;};
        pl_mapClicked = false;
        _building = nearestBuilding pl_building_search_cords;
    }
    else
    {
        _building = cursorTarget;
    };
    
    if !(isNil "_building") then {

        [_group] call KMD_fnc_reset;
        sleep 0.2;

        playSound "beep";
        leader _group sideChat format ["%1 is clearing the Building, over",(groupId _group)];
        _allPos = [_building] call BIS_fnc_buildingPositions;

        pl_draw_building_array pushBack [_group, _building];



        _targetPos = [];
        _targets = (getPos _building) nearObjects ["Man", 50];
        {
            if (alive _x) then {
                _targetPos pushBack (getPosATL _x);
                _x setSkill 0.1;
                _x disableAI "PATH";
            };
        } forEach (_targets select {!(side _x isEqualTo playerSide)});

        _movePos = [_targetPos, _allPos] call KMD_fnc_nearestPos;

        if ((count _movePos) == 0) then {_movePos = _allPos};

        _group setVariable ["onTask", true];
        _group setVariable ["setSpecial", true];
        _group setVariable ["specialIcon", "\A3\ui_f\data\igui\cfg\simpleTasks\types\getin_ca.paa"];
        _unitLimiter = 0;
        {
            _x limitSpeed 12;
            if (_unitLimiter < 4) then {
                _unitLimiter =  _unitLimiter + 1;
                _x disableAI "AUTOCOMBAT";
                _x setVariable ["pl_damage_reduction", true];
                [_x, _movePos, _building] spawn KMD_fnc_moveBuilding;
            }
            else
            {
                [_x, _building] spawn KMD_fnc_guardBuilding;
            };
        } forEach (units _group);
        waitUntil {({ alive _x } count units _group == 0) or !(_group getVariable ["onTask", true])};
        pl_draw_building_array = pl_draw_building_array - [[_group, _building]];
    };
