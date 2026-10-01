/*
Original name: pl_fire_mortar
New name:      KMD_fnc_fireMortar
Original url: "Plmod\pl_support_fnc.sqf"
*/
    private ["_cords"];

    if (visibleMap) then {
        _message = "Select STRIKE Location <br /><br />
        <t size='0.8' align='left'> -> SHIFT + LMB</t><t size='0.8' align='right'>CANCEL</t>";
        hint parseText _message;
        onMapSingleClick {
            pl_arty_cords = _pos;
            pl_mapClicked = true;
            hintSilent "";
            onMapSingleClick "";
            if (_shift) then {pl_cancel_strike = true};
        };
        while {!pl_mapClicked} do {sleep 0.5;};
        pl_mapClicked = false;
        if (pl_cancel_strike) exitWith {pl_cancel_strike = false};
    }
    else
    {
        pl_arty_cords = screenToWorld [0.5,0.5];
    };

    _cords = pl_arty_cords;
    _markerName = str random 1;
    createMarker [_markerName, _cords];
    _markerName setMarkerType "mil_destroy";
    _markerName setMarkerText format ["%1 R", pl_mortar_rounds];

    playSound "beep";
    (gunner (pl_mortars#0)) sideChat "Fire Mission Confirmed, over";

    sleep 3,
    {
        _x commandArtilleryFire [_cords, "8Rnd_82mm_Mo_shells", pl_mortar_rounds];
        sleep 0.7;
    } forEach pl_mortars;
    sleep 20;
    deleteMarker _markerName;