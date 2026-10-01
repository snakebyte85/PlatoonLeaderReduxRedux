/*
Original name: pl_spawn_proximity_supression
New name:      KMD_fnc_spawnProximitySuppression
Original url: "Plmod\pl_attack_fnc.sqf"
*/
player sideRadio "SentCmdSuppress";
_allMen = (getPos player) nearObjects ["Man", 25];
{
    [[_x]] spawn KMD_fnc_suppressiveFire;

} forEach (_allMen select {(side _x isEqualTo playerSide)});