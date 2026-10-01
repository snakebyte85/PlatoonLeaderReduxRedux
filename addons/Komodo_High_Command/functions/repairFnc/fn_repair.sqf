/*
Original name: pl_repair
New name:      KMD_fnc_repair
Original url: "Plmod\pl_repair_fnc.sqf"
*/

    private ["_group", "_engVic", "_vicPos", "_validEng", "_cords", "_repairTarget", "_toRepairVic", "_markerName", "_vicGroup", "_smokeGroup"];
    _group = hcSelected player select 0;
    if (vehicle (leader _group) != leader _group) then {
        _engVic = vehicle (leader _group);
        _validEng = false;
        if !((typeOf _engVic) in pl_eng_vic_cls_names) then {
            {
                if (getNumber ( configFile >> "CfgVehicles" >> typeOf _x >> "engineer" ) isEqualTo 1) then {
                    _validEng = true;
                };
            } forEach (crew _engVic);
        }
        else {_validEng = true;};

        if !(_validEng) exitWith {hint "Invalid Repair Vehicle!"};

        _engVic setUnloadInCombat [false, false];
        if (visibleMap) then {
            pl_show_dead_vehicles = true;
            pl_show_dead_vehicles_pos = getPos _engVic;
            hint "Select on MAP";
            onMapSingleClick {
                pl_repair_cords = _pos;
                pl_mapClicked = true;
                pl_show_dead_vehicles = false;
                hint "";
                onMapSingleClick "";
            };
            while {!pl_mapClicked} do {sleep 0.2;};
            pl_mapClicked = false;
            _cords = pl_repair_cords;
            private _distance = 100;
            {
                if ((_cords distance2D (_x #0)) < _distance) then {
                    _repairTarget = _x,
                    _distance = (_cords distance2D (_x #0));
                };
            } forEach pl_destroyed_vics_data;
            if (isNil "_repairTarget") exitWith {leader _group sideChat "No damaged Vehicles found, over"; playSound "beep";};

            _toRepairVic = _repairTarget #1;
            _markerName = _repairTarget #2;
            _vicGroupId = _repairTarget #3;
            _smokeGroup = _repairTarget #4;

            [_group] call KMD_fnc_reset;
            sleep 0.2;

            _group setVariable ["onTask", true];
            _group setVariable ["setSpecial", true];
            _group setVariable ["specialIcon", "\A3\ui_f\data\igui\cfg\simpleTasks\types\repair_ca.paa"];

            for "_i" from count waypoints _group - 1 to 0 step -1 do{
                deleteWaypoint [_group, _i];
            };
            _group addWaypoint [_repairTarget #0, 0];
            _group setVariable ["MARTA_customIcon", ["b_maint"]];
            playSound "beep";
            // leader _group sideChat format ["%1 is moving to damaged vehicle, over", (groupId _group)];
            sleep 4;
            waitUntil {sleep 0.1; !alive _engVic or (unitReady _engVic) or !(_group getVariable ["onTask", true])};
            sleep 2;

            _repairTime = time + 90;
            {
                _x disableAI "PATH";
            } forEach crew _engVic;
            waitUntil {sleep 1; time >= _repairTime or !(_group getVariable ["onTask", true])};
            {
                _x enableAI "PATH";
            } forEach crew _engVic;
            sleep 1;
            if ((alive _engVic) and (_group getVariable "onTask") and ({ alive _x } count units _group > 0) and (time >= _repairTime)) then {
                _idx = pl_destroyed_vics_data find _repairTarget;
                0 = pl_destroyed_vics_data deleteAt _idx;
                deleteMarker _markerName;
                _toRepairVic setDamage 0;
                _toRepairVic setFuel 1;
                _toRepairVic setVehicleAmmo 1;
                _toRepairVic setCaptive false;
                _toRepairVic allowDamage true;
                _toRepairVic setVehicleLock "DEFAULT";
                {
                    deleteVehicle ((_x getVariable "effectEmitter") select 0);  
                    // deleteVehicle ((_x getVariable "effectLight") select 0);
                } forEach (units _smokeGroup);
                sleep 0.1;
                _vicGroup = createVehicleCrew _toRepairVic;
                sleep 0.1;
                _vicGroup setGroupId [_vicGroupId];
                sleep  0.1;
                [_vicGroup] spawn KMD_fnc_setupAi;
                sleep 4;
                player hcSetGroup [_vicGroup];
                [_vicGroup] spawn KMD_fnc_reset;
                sleep 1;
                playsound "beep";
                (leader _vicGroup) sideChat format ["%1 is back up and fully operational, over", (groupId _vicGroup)];

                _group setVariable ["onTask", false];
                _group setVariable ["setSpecial", false];
                _group setVariable ["MARTA_customIcon", nil];
            };
        };
    }; 