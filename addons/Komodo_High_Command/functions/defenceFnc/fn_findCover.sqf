/*
Original name: pl_find_cover
New name:      KMD_fnc_findCover
Original url: "Plmod/pl_defence_fnc.sqf"
*/
    params ["_unit", "_watchPos", "_watchDir", "_radius", "_moveBehind"];

    _covers = nearestTerrainObjects [getPos _unit, [], _radius, true, true];
    // _unit enableAI "AUTOCOMBAT";
    _watchPos = [1000*(sin _watchDir), 1000*(cos _watchDir), 0] vectorAdd _watchPos;
    if ((count _covers) > 0) then {
        {
            if !(_x in pl_covers) exitWith {
                pl_covers pushBack _x;
                _unit doMove (getPos _x);
                waitUntil {sleep 0.1; (unitReady _unit) or (!alive _unit)};
                _unit setUnitPos "MIDDLE";
                sleep 1;
                if (_moveBehind) then {
                    _moveDir = [(_watchDir - 180)] call KMD_fnc_angleSwitcher;
                    _coverPos =  [2*(sin _moveDir), 2*(cos _moveDir), 0] vectorAdd (getPos _unit);
                    _unit doMove _coverPos;
                    sleep 1;
                    waitUntil {sleep 0.1; (unitReady _unit) or (!alive _unit)};
                    doStop _unit;
                    _unit doWatch _watchPos;
                _unit disableAI "PATH";
                }
                else
                {
                    doStop _unit;
                    _unit doWatch _watchPos;
                };
            };
        } forEach _covers;
        if (unitPos _unit == "AUTO") then {
            _unit setUnitPos "DOWN";
            if (_moveBehind) then {
                sleep 2;
                _checkPos = [15*(sin _watchDir), 15*(cos _watchDir), 0.25] vectorAdd (getPosASL _unit);

                // _helper = createVehicle ["Sign_Sphere25cm_F", _checkPos, [], 0, "none"];
                // _helper setObjectTexture [0,'#(argb,8,8,3)color(1,0,1,1)'];
                // _helper setposASL _checkPos;
                // _cansee = [_helper, "VIEW"] checkVisibility [(eyePos _unit), _checkPos];

                _cansee = [objNull, "VIEW"] checkVisibility [(eyePos _unit), _checkPos];
                // _unit sideChat str _cansee;
                if (_cansee < 0.6) then {
                    _unit setUnitPos "MIDDLE";
                };
            };
            doStop _unit;
            _unit doWatch _watchPos;
            _unit disableAI "PATH";
        };
    }
    else
    {
        _unit setUnitPos "DOWN";
       if (_moveBehind) then {
            sleep 2;
            _checkPos = [15*(sin _watchDir), 15*(cos _watchDir), 0.25] vectorAdd (getPosASL _unit);

            // _helper = createVehicle ["Sign_Sphere25cm_F", _checkPos, [], 0, "none"];
            // _helper setObjectTexture [0,'#(argb,8,8,3)color(1,0,1,1)'];
            // _helper setposASL _checkPos;
            // _cansee = [_helper, "VIEW"] checkVisibility [(eyePos _unit), _checkPos];

            _cansee = [objNull, "VIEW"] checkVisibility [(eyePos _unit), _checkPos];
            // _unit sideChat str _cansee;
            if (_cansee < 0.6) then {
                _unit setUnitPos "MIDDLE";
            };
        };
        doStop _unit;
        _unit doWatch _watchPos;
        _unit disableAI "PATH";
    };