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
    _markerName setMarkerType "mil_warning";
    _markerName setMarkerColor "ColorBlufor";
    _time = time + 60;
    waitUntil {time >= _time};
    deleteMarker _markerName;