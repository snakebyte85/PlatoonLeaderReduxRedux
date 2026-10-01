/*
Original name: pl_garrison_area_building
New name:      KMD_fnc_garrisonAreaBuilding
Original url: "Plmod\pl_building_fnc.sqf"
*/

    params ["_group"];
    private ["_watchDir", "_cords", "_watchPos", "_markerAreaName", "_markerDirName", "_buildings", "_allPos", "_validPos", "_units", "_unit", "_pos"];

    if (vehicle (leader _group) != leader _group) exitWith {hint "Infantry ONLY Task!"};
    if (visibleMap) then {
        hintSilent "";

        _message = "Select Area <br /><br /><t size='0.8' align='left'> -> SHIFT + LMB</t><t size='0.8' align='right'>CANCEL</t> <br />";
        hint parseText _message;

        _markerAreaName = format ["%1garrison", _group];
        createMarker [_markerAreaName, [0,0,0]];
        _markerAreaName setMarkerShape "ELLIPSE";
        _markerAreaName setMarkerBrush "Vertical";
        _markerAreaName setMarkerColor "colorYellow";
        _markerAreaName setMarkerAlpha 0.5;
        _markerAreaName setMarkerSize [pl_garrison_area_size, pl_garrison_area_size];

        onMapSingleClick {
            pl_defence_cords = _pos;
            pl_mapClicked = true;
            if (_shift) then {pl_cancel_strike = true};
            if (_alt) then {pl_deploy_static = true};
            hintSilent "";
            onMapSingleClick "";
        };

        while {!pl_mapClicked} do {
            _mPos = (findDisplay 12 displayCtrl 51) ctrlMapScreenToWorld getMousePosition;
            _markerAreaName setMarkerPos _mPos;
        };

        pl_mapClicked = false;
        if (pl_cancel_strike) exitWith {pl_cancel_strike = false};
        _message = "Select Defence FACING <br /><br />
        <t size='0.8' align='left'> -> SHIFT + LMB</t><t size='0.8' align='right'>CANCEL</t> <br />";
        hint parseText _message;

        sleep 0.1;
        _cords = pl_defence_cords;
        _markerDirName = format ["defence%1", _group];
        createMarker [_markerDirName, _cords];
        _markerDirName setMarkerType "marker_afp";
        _markerDirName setMarkerColor "colorBLUFOR";

        onMapSingleClick {
            pl_mapClicked = true;
            if (_shift) then {pl_cancel_strike = true};
            hintSilent "";
            onMapSingleClick "";
        };

        while {!pl_mapClicked} do {
            _watchDir = [_cords, ((findDisplay 12 displayCtrl 51) ctrlMapScreenToWorld getMousePosition)] call BIS_fnc_dirTo;
            _markerDirName setMarkerDir _watchDir;
        };
        pl_mapClicked = false;

        if (pl_cancel_strike) exitWith {pl_cancel_strike = false; deleteMarker _markerDirName; deleteMarker _markerAreaName;};

        _buildings = nearestObjects [_cords, ["house"], pl_garrison_area_size];

        if ((count _buildings == 0)) exitWith {hint "No buildings in Area!"; deleteMarker _markerAreaName; deleteMarker _markerDirName;};

        [_group] call KMD_fnc_reset;

        sleep 0.2;

        playSound "beep";

        _group setVariable ["onTask", true];
        _group setVariable ["setSpecial", true];
        _group setVariable ["specialIcon", "\A3\ui_f\data\igui\cfg\simpleTasks\types\getin_ca.paa"];


        _validPos = [];
        _allPos = [];
        {
            _building = _x;
            pl_draw_building_array pushBack [_group, _building];
            _bPos = [_building] call BIS_fnc_buildingPositions;
            {
                _allPos pushBack _x;
                _watchPos = [10*(sin _watchDir), 10*(cos _watchDir), 1.7] vectorAdd _x;
                _standingPos = [0, 0, 1.7] vectorAdd _x;
                _standingPos = ATLToASL _standingPos;
                _watchPos = ATLToASL _watchPos;

                // _helper = createVehicle ["Sign_Sphere25cm_F", _x, [], 0, "none"];
                // _helper setObjectTexture [0,'#(argb,8,8,3)color(1,0,1,1)'];
                // _helper setposASL _standingPos;

                _cansee = [objNull, "VIEW"] checkVisibility [_standingPos, _watchPos];
                if (_cansee == 1) then {
                    _validPos pushBack _x;
                };
            } forEach _bPos;
        } forEach _buildings;


        // {
        //     _helper = createVehicle ["Sign_Sphere25cm_F", _x, [], 0, "none"];
        //     _helper setObjectTexture [0,'#(argb,8,8,3)color(1,0,1,1)'];
        //     _helper setposATL _x;
        // } forEach _validPos;

        _watchPos = [500*(sin _watchDir), 500*(cos _watchDir), 0] vectorAdd _cords;

        _validPos = [_validPos, [], {_x distance2D _watchPos}, "ASCEND"] call BIS_fnc_sortBy;
        _allPos = _allPos - _validPos;
        _allPos = [_allPos, [], {_x distance2D _watchPos}, "ASCEND"] call BIS_fnc_sortBy;

        _units = units _group;
        for "_i" from 0 to (count _units) - 1 step 1 do {
            private _cover = false;
            if (_i < (count _validPos)) then {
                _pos = _validPos#_i;
                _unit = _units#_i;
            }
            else
            {
                if (_i < (count _allPos)) then {
                    _pos = _allPos#_i;
                    _unit = _units#_i;
                }
                else
                {
                    _cover = true;
                    _unit = _units#_i;
                };
            };
            _pos = ATLToASL _pos;
            private _unitPos = "UP";
            _checkPos = [7*(sin _watchDir), 7*(cos _watchDir), 1.7] vectorAdd _pos;
            _crouchPos = [0, 0, 0.6] vectorAdd _pos;
            if (([objNull, "VIEW"] checkVisibility [_crouchPos, _checkPos]) == 1) then {
                _unitPos = "MIDDLE";
            };
            if (([objNull, "VIEW"] checkVisibility [_pos, _checkPos]) == 1) then {
                _unitPos = "DOWN";
            };

            _pos = ASLToATL _pos;
            if (_cover) then {
                _b = (nearestObjects [_cords, ["house"], pl_garrison_area_size]) select 0;
                _pos = [[[(position _b), 30]],[]] call BIS_fnc_randomPos;
                _pos = _pos findEmptyPosition [0, 20];
                // player sideChat str _pos;
            };
            [_unit, _pos, _watchPos, _watchDir, _unitPos, _cover] spawn {
                params ["_unit", "_pos", "_watchPos", "_watchDir", "_unitPos", "_cover"];
                _unit disableAI "AUTOCOMBAT";
                _unit disableAI "TARGET";
                _unit doMove _pos;
                _unit moveTo _pos;
                sleep 1;
                waitUntil {(unitReady _unit) or (!alive _unit) or !((group _unit) getVariable ["onTask", true])};
                if !(_cover) then {
                    _unit doWatch _watchPos;
                    doStop _unit;
                    _unit setUnitPos _unitPos;
                    _unit disableAI "PATH";
                    _unit enableAI "AUTOCOMBAT";
                    _unit enableAI "TARGET";
                }
                else
                {
                    // player sideChat "off";
                    [_unit, _watchPos, _watchDir, 8, true] spawn KMD_fnc_findCover;
                };
            };
        };

        // hint (str _allPos);

        waitUntil {!(_group getVariable ["onTask", true])};

        deleteMarker _markerAreaName;
        deleteMarker _markerDirName;

        {
            pl_draw_building_array = pl_draw_building_array - [[_group, _x]];
        } forEach _buildings;
    };
