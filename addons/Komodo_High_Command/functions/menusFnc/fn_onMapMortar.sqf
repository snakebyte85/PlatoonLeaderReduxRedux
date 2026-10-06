/*
Original name: pl_on_map_mortar
New name:      KMD_fnc_onMapMortar
Original url: "Plmod\pl_menus_fnc.sqf"
*/
    private ["_mortars"];

    pl_mortars = [];
    _mortars = [];
    {
        if ((typeOf _x) in pl_mortar_names and (count (crew _x)) > 0) then {
            _mortars pushBack _x;
        };
    } forEach (vehicles select {side _x isEqualTo playerSide});

    if (count _mortars == 0) exitWith {0};
    pl_mortars append _mortars;
    1
