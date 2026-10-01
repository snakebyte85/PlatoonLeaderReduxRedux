/*
Original name: pl_medic_heal
New name:      KMD_fnc_medicHeal
Original url: "Plmod\pl_heal_fnc.sqf"
*/
    params ["_medic", "_target", "_ccpPos"];
    _healPos = (getPos _target) findEmptyPosition [0, 40];
    _moveToPos = {
        params ["_unit", "_pos", "_isMedic", "_secUnit"];
        _unit disableAI "AUTOCOMBAT";
        _unit doMove _pos;
        _unit moveTo _pos;
        sleep 2;
        if (_isMedic) then {
            waitUntil {sleep 0.1; (_unit distance2D _pos < 2) or (unitReady _unit) or (!alive _unit) or !((group _unit) getVariable ["onTask", true]) or (_unit getVariable ["pl_wia", false]) or (!alive _secUnit) or (_secUnit getVariable ["pl_wia", false])};
        }
        else
        {
            waitUntil {sleep 0.1; (_unit distance2D _pos < 2) or (unitReady _unit) or (!alive _unit) or (_unit getVariable ["pl_wia", false]) or (!alive _secUnit) or (_secUnit getVariable ["pl_wia", false]) or !((group _secUnit) getVariable ["onTask", true])};
        };
        doStop _unit;
        _unit disableAI "PATH";
        _unit setUnitPos "MIDDLE";
    };
    if (_target == player) then {
        _h1 = [_medic, _healPos, true, player] spawn _moveToPos;
        _medic sideChat "Hold Position Sir, Help is on the Way!";
        // Idicator for player at _healPos
        waitUntil {(scriptDone _h1) or !((group _medic) getVariable "onTask")};
    }
    else
    {
        _h1 = [_medic, _healPos, true, _target] spawn _moveToPos;
        _h2 = [_target, _healPos, false, _medic] spawn _moveToPos;
        _time = time + 20;
        waitUntil {sleep 0.1; ((scriptDone _h1) and (scriptDone _h2)) or !((group _medic) getVariable ["onTask", true]) or (time >= _time)};
    };
    if ((!alive _target) or (_target getVariable "pl_wia")) exitWith {
        _medic enableAI "PATH";
        // _medic enableAI "AUTOCOMBAT";
        _medic setUnitPos "AUTO";
        _medic doFollow leader (group _medic);
    };
    if ((!alive _medic) or (_medic getVariable ["pl_wia", false])) exitWith {(group _medic) setVariable ["onTask", false]};
    if (_medic distance2D _target < 3) then {
        _medic playAction "MedicOther";
        sleep 6;
        _target setDamage 0;
        _target setVariable ["pl_injured", false];
    };
    _medic enableAI "PATH";
    _medic enableAI "AUTOCOMBAT";
    _target enableAI "PATH";
    _target enableAI "AUTOCOMBAT";
    _medic setUnitPos "AUTO";
    _target setUnitPos "AUTO";
    if (isNil "_ccpPos") then {
        _medic doFollow leader (group _medic);
    }
    else
    {
        _medic doMove _ccpPos;
        _medic moveTo _ccpPos;
    };

_target doFollow leader (group _target);
