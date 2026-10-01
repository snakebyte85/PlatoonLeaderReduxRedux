params ["_group"];
private["_display_name", "_leader"];

_displayName = getText (configFile >> 'CfgVehicles' >> typeOf (units _group select 0)>> 'displayName');
_leader = leader _group;

if (count (units _group) == 1 && vehicle _leader != _leader ) then {
    _displayName = getText (configFile >> 'CfgVehicles' >> typeOf  (vehicle _leader) >> 'displayName');
};

if (count (units _group) > 1 ) then {
    
    _displayName = "Infantry unit";
    _groupVehicles = [_group, true] call BIS_fnc_groupVehicles;
    
    if (count _groupVehicles == 1) then {
        _primaryVehicle = _groupVehicles select 0;
    
        _displayName = getText (configFile >> 'CfgVehicles' >> typeOf  _primaryVehicle >> 'displayName');
    };
    
    if (count _groupVehicles > 1) then {
        _primaryVehicle = _groupVehicles select 0;
    
        _displayName = switch (true) do {
            case (_primaryVehicle isKindOf "Tank"): { "Armor units"; };
            case (_primaryVehicle isKindOf "Wheeled_APC_F"): { "Mechanized units"; };
            case (_primaryVehicle isKindOf "Car"): { "Motorized units"; };
            case (_primaryVehicle isKindOf "Air"): { "Air units"; };
        };
    };
};
    
_displayName;