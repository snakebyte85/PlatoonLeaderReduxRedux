/*
Original name: pl_interdiction_cas
New name:      KMD_fnc_interdictionCas
Original url: "Plmod\pl_support_fnc.sqf"
*/
    params ["_type"];
    private ["_height", "_cd", "_dir", "_spawnDistance", "_markerName", "_areaMarkerName", "_evacHeight", "_spawnPos", "_groupId", "_cords", "_sadWp", "_planeType", "_casGroup", "_plane", "_targets", "_sortiesCost", "_onStationTime", "_sadAreaSize", "_wpType", "_flyHeight", "_ccpGroup"];

    switch (_type) do { 
        case 1 : {
            _height = 1500;
            _flyHeight = 200;
            _spawnDistance = 6000;
            _planeType = 'B_Plane_CAS_01_F';
            // _planeType = "B_Plane_Fighter_01_F";
            _sortiesCost = 5;
            _groupId = "Reaper 1";
            _evacHeight = 2000;
            _cd = 300;
            _onStationTime = 110;
            _sadAreaSize = 600;
            _wpType = "SAD";
        }; 
        case 2 : {
            _height = 100;
            _flyHeight = 100;
            _spawnDistance = 3000;
            _planeType = 'B_Heli_Attack_01_F';
            _sortiesCost = 4;
            _groupId = "Black Jack 4";
            _evacHeight = 200;
            _onStationTime = 90;
            _sadAreaSize = 500;
            _wpType = "SAD";
        };
        case 3 : {
            _height = 1700;
            _flyHeight = 1700;
            _spawnDistance = 4500;
            _planeType = 'B_UAV_02_dynamicLoadout_F';
            _sortiesCost = 3;
            _groupId = "Sentry 3";
            _evacHeight = 1700;
            _onStationTime = 240;
            _sadAreaSize = 700;
            _wpType = "LOITER";
        };
        case 4 : {
            _height = 100;
            _flyHeight = 80;
            _spawnDistance = 3000;
            _planeType = 'B_Heli_Transport_01_F';
            _sortiesCost = 4;
            _groupId = "Angel 6";
            _evacHeight = 150;
            _onStationTime = 180;
            _sadAreaSize = 200;
            _wpType = "TR UNLOAD";
        };
        default {}; 
    };

    if (visibleMap) then {

        if (pl_sorties < _sortiesCost) exitWith {hint "Not enough Sorties Left"};

        hintSilent "";
        _message = "Select STRIKE Location <br /><br />
        <t size='0.8' align='left'> -> SHIFT + LMB</t><t size='0.8' align='right'>CANCEL</t>";
        hint parseText _message;
        _areaMarkerName = format ["%1casarea", _type];
        createMarker [_areaMarkerName, [0,0,0]];
        _areaMarkerName setMarkerShape "ELLIPSE";
        _areaMarkerName setMarkerBrush "Vertical";
        _areaMarkerName setMarkerColor "colorYellow";
        _areaMarkerName setMarkerAlpha 0.5;
        _areaMarkerName setMarkerSize [_sadAreaSize, _sadAreaSize];

        onMapSingleClick {
            pl_cas_cords = _pos;
            pl_mapClicked = true;
            if (_shift) then {pl_cancel_strike = true};
            hintSilent "";
            onMapSingleClick "";
        };

        while {!pl_mapClicked} do {
            _mPos = (findDisplay 12 displayCtrl 51) ctrlMapScreenToWorld getMousePosition;
            _areaMarkerName setMarkerPos _mPos;
        };
        pl_mapClicked = false;
        if (pl_cancel_strike) exitWith {pl_cancel_strike = false};
        _areaMarkerName setMarkerAlpha 0.28;
        _message = "Select APPROACH Vector <br /><br />
        <t size='0.8' align='left'> -> SHIFT + LMB</t><t size='0.8' align='right'>CANCEL</t>";
        hint parseText _message;

        sleep 0.1;
        _cords = pl_cas_cords;
        _markerName = format ["cassad%1", _type];
        createMarker [_markerName, _cords];
        _markerName setMarkerType "mil_arrow";
        _markerName setMarkerColor "colorBLUFOR";

        onMapSingleClick {
            pl_cas_cords = _pos;
            pl_mapClicked = true;
            if (_shift) then {pl_cancel_strike = true};
            hintSilent "";
            onMapSingleClick "";
        };

        while {!pl_mapClicked} do {
            _dir = [_cords, ((findDisplay 12 displayCtrl 51) ctrlMapScreenToWorld getMousePosition)] call BIS_fnc_dirTo;
            _markerName setMarkerDir _dir;
        };
        pl_mapClicked = false;


    }
    else
    {
        _cords =  screenToWorld [0.5,0.5];
        _dir = player getDir _cords;
        _markerName = format ["cassad%1", _type];
        createMarker [_markerName, _cords];
        _markerName setMarkerType "mil_arrow";
        _markerName setMarkerColor "colorBLUFOR";
        _markerName setMarkerDir _dir;
    };

    if (pl_cancel_strike) exitWith {pl_cancel_strike = false; deleteMarker _markerName; deleteMarker _areaMarkerName;};
        
    playSound "beep";
    [playerSide, "HQ"] sideChat "Strike Aircraft on the Way!";

    pl_sorties = pl_sorties - _sortiesCost;

    switch (_type) do { 
        case 1 : {pl_plane_sad_enabled = 0;}; 
        case 2 : {pl_helo_sad_enabled = 0;};
        case 3 : {pl_uav_sad_enabled = 0;};
        case 4 : {pl_medevac_sad_enabled = 0;}; 
        default {}; 
    };

    // sleep 15;

    _spawnPos = [_spawnDistance*(sin (_dir - 180)), _spawnDistance*(cos (_dir - 180)), 0] vectorAdd _cords;

    _casGroup = createGroup playerside;
    _casGroup setGroupId [_groupId];
    _casGroup setVariable ["pl_not_addalbe", true];
    if (_type == 3) then {
        _casGroup setCombatMode "BLUE";
        _casGroup setVariable ["pl_combat_mode", true];
        _casGroup setVariable ["pl_hold_fire", true];
    };

    _p = [_spawnPos, _dir, _planeType, _casGroup] call BIS_fnc_spawnVehicle;
    _plane = _p#0;
    [_plane, _height] call BIS_fnc_setHeight;
    _plane forceSpeed 140;
    _plane flyInHeight _flyHeight;
    sleep 0.1;
    {
        _plane removeWeaponTurret [_x, [-1]];
    } forEach ["Gatling_30mm_Plane_CAS_01_F", "Rocket_04_HE_Plane_CAS_01_F", "Rocket_04_AP_Plane_CAS_01_F"];
    {
        _plane removeMagazinesTurret [_x, [-1]];
    } forEach ["1000Rnd_Gatling_30mm_Plane_CAS_01_F", "7Rnd_Rocket_04_HE_F", "7Rnd_Rocket_04_AP_F"];

    {
        _x setSkill 1;
    } forEach crew (_plane);

    _sadWp = _casGroup addWaypoint [_cords, 0];
    _sadWp setWaypointType _wpType;

    _allVics = nearestObjects [_cords, ["Tank", "Car", "Truck"], _sadAreaSize, true];
    if (_type == 3) then {
        _allVics = nearestObjects [_cords, ["Tank", "Car", "Truck", "Man"], _sadAreaSize, true];
    };
    sleep 3;
    _casGroup setBehaviour "COMBAT";

    [_plane, _cords, _casGroup, _sadAreaSize] spawn {
        params ["_plane", "_cords", "_casGroup", "_sadAreaSize"];

        while {alive _plane} do {

            // hintSilent str (magazines _plane);

            _targets = (driver _plane) targetsQuery [objNull, sideUnknown, "", [], 0];
            {
                // hintSilent str _targets;
                if (((_x select 1) distance2D _cords) > _sadAreaSize) then {
                    _casGroup forgetTarget (_x#1);
                };
            } forEach _targets;
        };
    };

    if (_type != 4) then {
        waitUntil {(_plane distance2D _cords) < 3000};
    }
    else
    {
        "Land_HelipadEmpty_F" createVehicle _cords;
        sleep 3;
        waitUntil {(isTouchingGround _plane) or !alive _plane };
        if (alive _plane) then {
            private _medic = _casGroup createUnit ["B_medic_F", [0,0,0], [], 0, "CAN_COLLIDE"];
            _medic moveInCargo _plane;
            sleep 3;
            private _gunner = gunner _plane;
            _ccpGroup = createGroup playerSide;
            _ccpGroup setGroupId ["Angel 6 Medic"];
            _ccpGroup setVariable ["MARTA_customIcon", ["b_med"]];
            _ccpGoup setVariable ["pl_not_addalbe", true];
            {
                [_x] joinSilent _ccpGroup;
                unassignVehicle _x;
                doGetOut _x;
            } forEach [_medic, _gunner];
            _ccpGroup selectLeader _gunner;
            [_ccpGroup] call pl_set_up_ai;
            sleep 5;
            [_ccpGroup, true, _gunner] spawn KMD_fnc_ccp;
        };
    };

    {
        if ((side (driver _x)) != playerSide) then {
            (driver _plane) reveal [_x, 4];
            {
                (driver _plane) reveal [_x, 4];
            } forEach (crew _x);
        };
    } forEach _allVics;

    sleep 40;

    deleteMarker _markerName;
    _time = time + _onStationTime;
    waitUntil { time > _time };

    deleteMarker _areaMarkerName;

    switch (_type) do { 
        case 1 : {
            pl_plane_sad_cd = time + 300;
            _cd = pl_plane_sad_cd;
        }; 
        case 2 : {
            pl_helo_sad_cd = time + 240;
            _cd = pl_helo_sad_cd;
        };
        case 3 : {
            pl_uav_sad_cd = time + 360;
            _cd = pl_uav_sad_cd;
        };
        case 4 : {
            pl_medevac_sad_cd = time + 400;
            _cd = pl_medevac_sad_cd;
        }; 
        default {}; 
    };

    if (alive _plane) then {
        // _targets = (driver _plane) targetsQuery [objNull, sideUnknown, "", [], 0];
        [_casGroup] call KMD_fnc_reset;
        sleep 0.2;
        playsound "beep";
        (driver _plane) sideChat format ["%1: RTB", _groupId];
        {
            _x disableAI "AUTOCOMBAT";
            _x disableAI "TARGET";
            _x disableAI "AUTOTARGET";
        } forEach (units _casGroup);

        if (_type == 4) then {
            [_ccpGroup] call KMD_fnc_reset;

            sleep 0.2;

            _ccpGroup setVariable ["MARTA_customIcon", nil];
            {
                _x assignAsCargo _plane;
                [_x] allowGetIn true;
                [_x] orderGetIn true;
                [_x] joinSilent _casGroup;
            } forEach (units _ccpGroup);

            _casGroup setGroupId [_groupId];

            sleep 2;
            waitUntil {({_x in _plane} count (units _casGroup)) == (count (units _casGroup))};
            sleep 1;
        };


        _plane flyInHeight _evacHeight;
        _plane forceSpeed 300;
        _evacWp = _casGroup addWaypoint [_spawnPos, 0];
        _despawnTime = time + 90;
        while {(alive _plane) and ((_plane distance2D _spawnPos) > 100) and (time < _despawnTime)} do {
            _targets = (driver _plane) targetsQuery [objNull, sideUnknown, "", [], 0];
            {
                _casGroup forgetTarget (_x#1);
            } forEach _targets;
            sleep 0.1;
        };
        {
            _plane deleteVehicleCrew _x;
        } forEach (crew _plane);
        deleteVehicle _plane;
        deleteGroup _casGroup;
    };
    waitUntil {time > _cd};
    switch (_type) do { 
        case 1 : {pl_plane_sad_enabled = 1;}; 
        case 2 : {pl_helo_sad_enabled = 1;};
        case 3 : {pl_uav_sad_enabled = 1;};
        case 4 : {pl_medevac_sad_enabled = 1;}; 
        default {}; 
    };