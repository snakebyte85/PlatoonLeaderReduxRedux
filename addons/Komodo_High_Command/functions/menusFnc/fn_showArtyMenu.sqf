/*
Original name: pl_show_arty_menu
New name:      KMD_fnc_showArtyMenu
Original url: "Plmod\pl_menus_fnc.sqf"
*/
call compile format ["
pl_arty_menu = [
    ['Artillery',true],
    ['Call 155m Artillery Strike (%1)', [2], '', -5, [['expression', '[] spawn KMD_fnc_arty']], '1', '%5'],
    ['', [], '', -5, [['expression', '']], '1', '0'],
    ['Rounds:           %2', [3], '#USER:pl_arty_round_menu', -5, [['expression', '']], '1', '%5'],
    ['Dispersion:      %3 m', [4], '#USER:pl_arty_dispersion_menu', -5, [['expression', '']], '1', '%5'],
    ['Delay:               %4 s', [5], '#USER:pl_arty_delay_menu', -5, [['expression', '']], '1', '%5'],
    ['', [], '', -5, [['expression', '']], '1', '0']
];",pl_arty_ammo, pl_arty_rounds, pl_arty_dispersion, pl_arty_delay, pl_arty_enabled];
showCommandingMenu "#USER:pl_arty_menu";