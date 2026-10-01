/*
I am using an external thread here to avoid suspension at the start of the mission.
*/
[]spawn{
    sleep 1;
/*
Added a delay (1s) since it seems that some of Jelly's functions require the game to have started before
they can be executed properly.
Once the delay is complete the rest of the functions are called in an unscheduled environment since this is 14x faster.
*/
isNil{

    call KMD_fnc_globalVariables;
    call KMD_fnc_initMapDrawing;
    call KMD_fnc_initTransportAndEvents; // The code called at the end of "Plmod\pl_vehicle_fnc.sqf"
    call KMD_fnc_repKilledEh;            // The code called at the start of "Plmod\pl_repair_fnc.sqf"
    call KMD_fnc_showFireSupportMenu;
    call KMD_fnc_showCssMenu;
    call KMD_fnc_icons3D;
    call KMD_fnc_groupIconClickEh;
    call KMD_fnc_entityKilledEh;
    call KMD_fnc_vehicleGroupCheck;
};

/*
Since these functions are spawned in external threads there is no need to include them in the unscheduled bracket.
*/
[] spawn KMD_fnc_disableHcElements;
[] spawn KMD_fnc_aiSetupLoop;

};
