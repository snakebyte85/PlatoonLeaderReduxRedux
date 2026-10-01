/*
Original name: pl_create_new_vic
New name:      KMD_fnc_createNewVic
Original url: "Plmod\pl_repair_fnc.sqf"
*/
    params ["_type", "_pos", "_dir", "_appereance", "_loadout", "_groupId", "_lives"];
    private ["_newVic"];

    sleep 0.3;

    _newVic = _type createVehicle _pos;
    _newVic setPos _pos;
    _newVic setDir _dir;

    _newVic setCaptive true;
    _newVic setDamage 0.9;
    _newVic allowDamage false;
    _newVic setVehicleLock "LOCKED";

    {
        _newVic animateSource [_x#0, _x#1];
    } forEach _appereance;

    [_loadout, _newVic] call KMD_fnc_setVicLoadOut;

    _smokeGroup = createGroup east;
    _smoke = _smokeGroup createUnit ["ModuleEffectsSmoke_F", _pos, [],0 , ""];
    // _smoke setVariable ["timeout", 80];
    _fire = _smokeGroup createUnit ["ModuleEffectsFire_F", _pos, [],0 , ""];
    // _fire setVariable ["timeout", 80];
    _fire setPos _pos;
    _smoke setPos _pos;

    _markerName = format ["disabled%1", _newVic];
    createMarker [_markerName, _pos];
    _markerName setMarkerType "mil_destroy";
    _vicName = getText (configFile >> "CfgVehicles" >> _type >> "displayName");
    _markerName setMarkerText format ["Disabled %1", _vicName];

    _lives = _lives - 1;
    _newVic setVariable ["pl_repair_lifes", _lives];
    [_newVic] call KMD_fnc_vehicleSetup;

    pl_destroyed_vics_data pushBack [_pos, _newVic, _markerName, _groupId, _smokeGroup];
