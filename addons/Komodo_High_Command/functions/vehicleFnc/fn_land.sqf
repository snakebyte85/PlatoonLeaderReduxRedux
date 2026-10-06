
    private ["_air_vics"];
    
    _air_vics = [];
    
    {
        _group = _x;
        _vics = [_group, false] call BIS_fnc_groupVehicles;
        
        {
            _vic = _x;
            if ( _vic IsKindOf "Air") then {
                _air_vics pushback _vic;          
            };       
        
        } forEach _vics;   
    } forEach hcSelected player;
    
    
    if ( count _air_vics == 0) then {
        hint "Vehicle is not a plane or an helicopter!";   
    } else {
    
        if (visibleMap) then {
            hintSilent "Select LANDING ZONE on MAP";
            onMapSingleClick {
                pl_mapClicked = true;
                pl_lz_cords = (findDisplay 12 displayCtrl 51) ctrlMapScreenToWorld getMousePosition;
                pl_lz_marker_cords = pl_lz_cords;
                hintSilent "";
                onMapSingleClick "";
            };
            waitUntil {pl_mapClicked};
            
            sleep 0.1;
            pl_mapClicked = false;
        } else {
            pl_lz_cords = screenToWorld [0.5,0.5];
            pl_lz_marker_cords = pl_lz_cords;
        };
        
        _markerName = format ["lzmarker%1", groupId (group (_air_vics select 0))];
        createMarker [_markerName, pl_lz_marker_cords];            
        _markerName setMarkerType "mil_marker";
        _markerName setMarkerType "hd_end";
        _markerName setMarkerText "LZ";
        _markerName setMarkerColor ([side (_air_vics select 0)] call KMD_fnc_sideToMarkerColor);
        {
            _vic = _x;
            {
                _x disableAI "AUTOCOMBAT";
                _x disableAI "TARGET";
                _x disableAI "AUTOTARGET";
            } forEach (units (group (driver _vic)));
            group (driver _vic) addWaypoint [pl_lz_cords, 0];
            (group (driver _vic)) setVariable ["setSpecial", true];
            (group (driver _vic)) setVariable ["specialIcon", "\A3\ui_f\data\igui\cfg\simpleTasks\types\land_ca.paa"];
            playSound "beep";
            driver _vic sideChat "Moving to the LZ";
            
        } forEach _air_vics;
        
        sleep 20;
        
        {
            _vic = _x;
            waitUntil {sleep 0.1; unitReady _vic or !alive _vic};
            playSound "beep";
            driver _vic sideChat "Beginning landing";
            _vic land "LAND";
            sleep 10;
            waitUntil {sleep 0.1; (isTouchingGround _vic) or !alive _vic};
            sleep 1;
            [group _vic] call KMD_fnc_reset;
            
        } forEach _air_vics;
    };
    

    
    
