/*
Original name: pl_draw_kia
New name:      KMD_fnc_drawKia
Original url: "Plmod\pl_map_icons.sqf"
*/
    params ["_unit"];
    _pos = getPos _unit;
    _markerName = str _unit;
    _marker = createMarker [_markerName, _pos];
    _markerName setMarkerSize [0.5, 0.5];
    _markerName setMarkerType "KIA";
    _markerName setMarkerColor ([side (group _unit)] call KMD_fnc_sideToMarkerColor);
    _time = time + 60;
    waitUntil {time >= _time};
    deleteMarker _markerName;
