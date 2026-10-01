/*
Original name: pl_arty
New name:      KMD_fnc_arty
Original url: "Plmod\pl_support_fnc.sqf"
*/
    private ["_salvos", "_markerName"];

    if (pl_arty_ammo < pl_arty_rounds) exitWith {
        // playSound "beep";
        hint "Not enough ammunition left!";
    };
    if (visibleMap) then {

        _message = "Select STRIKE Location <br /><br />
        <t size='0.8' align='left'> -> SHIFT + LMB</t><t size='0.8' align='right'>CANCEL</t>";
        hint parseText _message;

        _markerName = createMarker ["pl_arty_marker", pl_arty_cords];
        _markerName setMarkerColor "colorRed";
        _markerName setMarkerShape "ELLIPSE";
        _markerName setMarkerBrush "BDiagonal";
        _markerName setMarkerAlpha 0.9;
        _markerName setMarkerSize [pl_arty_dispersion, pl_arty_dispersion];
        onMapSingleClick {
            pl_arty_cords = _pos;
            pl_mapClicked = true;
            if (_shift) then {pl_cancel_strike = true};
            hint "";
            onMapSingleClick "";
        };
        while {!pl_mapClicked} do {
            _mPos = (findDisplay 12 displayCtrl 51) ctrlMapScreenToWorld getMousePosition;
            _markerName setMarkerPos _mPos;
        };
        pl_mapClicked = false;
        if (pl_cancel_strike) exitWith {pl_cancel_strike = false; deleteMarker _markerName};
    }
    else
    {
        pl_arty_cords = screenToWorld [0.5,0.5];
    };
    pl_arty_enabled = 0;
    
    _markerName setMarkerAlpha 0.4;
    createMarker ["pl_arty_center", pl_arty_cords];
    "pl_arty_center" setMarkerType "mil_destroy";
    "pl_arty_center" setMarkerText format ["%1 R / %2 m / %3 s", pl_arty_rounds, pl_arty_dispersion, pl_arty_delay];

    pl_arty_ammo = pl_arty_ammo - pl_arty_rounds;
    playSound "beep";
    [playerSide, "HQ"] sideChat format ["Fire Mission Confirmend // ETA 40 Seconds"];
    sleep 40;
    playSound "beep";
    [playerSide, "HQ"] sideChat format ["Splash"];

    _artyGroup = createGroup east;

    _salvos = pl_arty_rounds / 3;
    if (pl_arty_rounds == 1) then {
        _salvos = 1;
    };
    for "_i" from 1 to (_salvos) do {
        for "_j" from 1 to 3 do {
            _cords = [[[(pl_arty_cords), (pl_arty_dispersion + 45)]],[]] call BIS_fnc_randomPos;
            _support = _artyGroup createUnit ["ModuleOrdnance_F", _cords, [],0 , ""];
            _support setVariable ["type", "ModuleOrdnanceHowitzer_F_Ammo"];
            if (pl_arty_rounds == 1) exitWith {};
            sleep 0.8;
        };
        sleep pl_arty_delay; 
    };

    sleep 5;

    deleteMarker _markerName;
    deleteMarker "pl_arty_center";
    sleep 30;
    pl_arty_enabled = 1;
    [] call KMD_fnc_showFireSupportMenu;
    // [playerSide, "HQ"] sideChat format ["Battery is ready for Fire Mission, over"];
