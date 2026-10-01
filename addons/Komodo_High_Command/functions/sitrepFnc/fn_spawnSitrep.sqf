/*
Original name: pl_spawn_sitrep
New name:      KMD_fnc_spawnSitrep
Original url: "Plmod\pl_sitrep_fnc.sqf"
*/
if (count (hcSelected player) == 1) then {
    [(hcSelected player select 0)] spawn KMD_fnc_sitrepSolo;
};

if (count (hcSelected player) > 1) then {
    [hcSelected player] spawn KMD_fnc_sitrepMulti;
};