/*
Original name: pl_cas
New name:      KMD_fnc_cas
Original url: "Plmod\pl_support_fnc.sqf"
*/
    params ["_key"];
    private ["_sortiesCost", "_cords", "_dir", "_support", "_type", "_plane", "_cs", "_markerName"];

    switch (_key) do { 
        case 1 : {_sortiesCost = 1}; 
        case 2 : {_sortiesCost = 2};
        case 3 : {_sortiesCost = 4}; 
        case 4 : {_sortiesCost = 5}; 
        default {_sortiesCost = 1}; 
    };

    if (visibleMap) then {

        if (pl_sorties < _sortiesCost) exitWith {hint "Not enough Sorties Left"};

        hintSilent "";
        // hint "Select STRIKE location on MAP (SHIFT + LMB to cancel)";
        _message = "Select STRIKE Location <br /><br />
        <t size='0.8' align='left'> -> SHIFT + LMB</t><t size='0.8' align='right'>CANCEL</t>";
        hint parseText _message;

        _cords = (findDisplay 12 displayCtrl 51) ctrlMapScreenToWorld getMousePosition;

        onMapSingleClick {
            pl_cas_cords = _pos;
            pl_mapClicked = true;
            if (_shift) then {pl_cancel_strike = true};
            hintSilent "";
            onMapSingleClick "";
        };

        while {!pl_mapClicked} do {sleep 0.1;};
        pl_mapClicked = false;
        if (pl_cancel_strike) exitWith {pl_cancel_strike = false};
        // hint "Select APPROACH Vector for Strike (SHIFT + LMB to cancel)";
        _message = "Select APPROACH Vector <br /><br />
        <t size='0.8' align='left'> -> SHIFT + LMB</t><t size='0.8' align='right'>CANCEL</t>";
        hint parseText _message;

        sleep 0.1;
        _cords = pl_cas_cords;
        _markerName = format ["cas%1", _key];
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

        if (pl_cancel_strike) exitWith {pl_cancel_strike = false; deleteMarker _markerName};
    }
    else
    {
        _cords =  screenToWorld [0.5,0.5];
        _dir = player getDir _cords;
        _markerName = format ["cas%1", _key];
        createMarker [_markerName, _cords];
        _markerName setMarkerType "mil_arrow";
        _markerName setMarkerColor "colorBLUFOR";
        _markerName setMarkerDir _dir;
    };

    pl_sorties = pl_sorties - _sortiesCost;

    switch (_key) do { 
        case 1 : {pl_gun_enabled = 0, _type = 0, _plane = 'B_Plane_CAS_01_F', _cs = 'Viper 1'};
        case 2 : {pl_gun_rocket_enabled = 0, _type = 2, _plane = 'B_Plane_CAS_01_F', _cs = 'Viper 4'};
        case 3 : {pl_cluster_enabled = 0,  _type = 3, _plane = 'B_Plane_Fighter_01_Cluster_F', _cs = 'Black Knight 2'}; 
        case 4 : {pl_jdam_enabled = 0,  _type = 3, _plane = 'B_Plane_Fighter_01_F', _cs = 'Stroke 3'};
        default {sleep 0.1}; 
    };
    sleep 1;
    _group = createGroup playerSide;
    _support = _group createUnit ["ModuleCAS_F", _cords, [],0 , ""];
    _support setVariable ["vehicle", _plane];
    _support setVariable ["type", _type];

    playSound "beep";
    [playerSide, "HQ"] sideChat "Strike Aircraft on the Way!";
    sleep 1;
    _support setDir _dir;
    sleep 5;
    _vicGroup = group (driver (_support getVariable "plane"));
    _vicGroup setGroupId [_cs];
    _vicGroup setVariable ["pl_not_addalbe", true];
    waitUntil {sleep 0.1; _support isEqualTo objNull};
    deleteMarker _markerName;
    sleep 8;
    switch (_key) do {
        case 1 : {
        pl_cas_gun_cd = time + 120;
        // playSound "beep";
        // [playerSide, "HQ"] sideChat format ["%1 will be back on Station in 2 MINUTES, over", _cs];
        waitUntil {sleep 1; time > pl_cas_gun_cd};
        pl_gun_enabled = 1;
     }; 
        case 2 : {
        pl_cas_gun_rocket_cd = time + 240;
        // playSound "beep";
        // [playerSide, "HQ"] sideChat format ["%1 will be back on Station in 4 MINUTES, over", _cs];
        waitUntil {sleep 1; time > pl_cas_gun_rocket_cd};
        pl_gun_rocket_enabled = 1;
     }; 
        case 3 : {
        pl_cas_cluster_cd = time + 480;
        // playSound "beep";
        // [playerSide, "HQ"] sideChat format ["%1 will be back on Station in 8 MINUTES, over", _cs];
        waitUntil {sleep 1; time > pl_cas_cluster_cd};
        pl_cluster_enabled = 1;
    };
        case 4 : {
        pl_cas_jdam_cd = time + 720;
        // playSound "beep";
        // [playerSide, "HQ"] sideChat format ["%1 will be back on Station in 12 MINUTES, over", _cs];
        waitUntil {sleep 1; time > pl_cas_jdam_cd};
        pl_jdam_enabled = 1;
    };
        default {pl_cas_cd = time + 240;}; 
    };
    playSound "beep";
    [playerSide, "HQ"] sideChat format ["%1, is back on Station", _cs];