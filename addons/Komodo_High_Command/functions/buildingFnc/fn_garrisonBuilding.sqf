/*
Original name: pl_garrison_building
New name:      KMD_fnc_garrisonBuilding
Original url: "Plmod\pl_building_fnc.sqf"
*/
    private ["_group","_building"];
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

        pl_draw_building_array pushBack [_group, _building];
        playSound "beep";
        // leader _group sideChat format ["Roger %1 is moving into Building, over",(groupId _group)];
        _allPos = [_building] call BIS_fnc_buildingPositions;
        _posCount = count _allPos;
        _unitCount = count (units _group);
        _group setVariable ["setSpecial", true];
        _group setVariable ["onTask", true];
        _group setVariable ["specialIcon", "\A3\ui_f\data\igui\cfg\simpleTasks\types\getin_ca.paa"];
        for "_i" from 0 to _unitCount -1 do {
            if (_i < _posCount) then {
                [((units _group) select _i), (_allPos select (_posCount -1 -_i))] spawn KMD_fnc_moveToGarrison;
            }
            else
            {
                [(units _group) select _i, _building] spawn KMD_fnc_guardBuilding;
            }
        };
        waitUntil {({ alive _x } count units _group == 0) or !(_group getVariable ["onTask", true])};
        pl_draw_building_array = pl_draw_building_array - [[_group, _building]];
    };
