
params ["_msg"];

if (pl_debug) then { 
    _finalMsg = format["[PL]-> %1", _msg];
    //systemChat _finalMsg;
    diag_log _finalMsg;
};