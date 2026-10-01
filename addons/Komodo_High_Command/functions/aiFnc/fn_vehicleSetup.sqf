/*
Original name: pl_vehicle_setup
New name:      KMD_fnc_vehicleSetup
Original url: "Plmod\pl_ai_fnc.sqf"
*/
params ["_vic"];

if (_vic isKindOf "Air") exitWith {};

_vic setUnloadInCombat [false, false];
    
if (isNil {_vic getVariable "pl_vehicle_setup_complete"}) then {
    _vic limitSpeed 50;
    
	if (isNil {_vic getVariable "pl_repair_lifes"})then{
        if (_vic isKindOf "Tank") 
		then{_vic setVariable ["pl_repair_lifes", 3]}
        else{_vic setVariable ["pl_repair_lifes", 1]};
    };

if(isNil {_vic getVariable "pl_appereance"})then{
        _animations = "true" configClasses (configFile >> "CfgVehicles" >> typeOf _vic >> "AnimationSources");
        _animationPhases = [];
    {
        _s = (str _x) splitString "/";
        _a =  _s select ((count _s) - 1);
        _animationPhases pushBack [_a, (_vic animationSourcePhase _a)];

    } forEach _animations;

    _vic setVariable ["pl_appereance", _animationPhases];
};
    
_vic addEventHandler ["IncomingMissile", {
    params ["_target", "_ammo", "_vehicle", "_instigator"];

    _pos = getPos _vehicle;
    _markerPos = [[[_pos, 50]],[]] call BIS_fnc_randomPos;
    _markerDir =  (_target getDir _markerPos) + 90;
    _markerName = format ["%1at", _vehicle];
    
	[_markerPos, _markerDir, _markerName] spawn {
        params ["_markerPos", "_markerDir", "_markerName"];
        createMarker [_markerName, _markerPos];
        _markerName setMarkerType "mil_ambush";
        _markerName setMarkerSize [0.5, 0.5];
        _markerName setMarkerDir _markerDir;
        _markerName setMarkerColor "ColorRed";
        _markerName setMarkerText "AT";
        sleep 30;
        deleteMarker _markerName;
    };
}];

_vic setVariable ["pl_vehicle_setup_complete", true];
};

_w = getWeaponCargo _vic;
_t = getItemCargo _vic;
_m = getMagazineCargo _vic;
_b = getBackpackCargo _vic;
_vicInv = [_w, _t, _m ,_b];

_vic setVariable ["pl_vic_inv", _vicInv];