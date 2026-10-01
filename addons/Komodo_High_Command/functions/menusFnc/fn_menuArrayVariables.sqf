/*
Original name: (Called directly in the file)
New name:      KMD_fnc_menuArrayVariables
Original url: "Plmod\pl_menus_fnc.sqf"
*/

pl_arty_round_menu = 
[
    ['Rounds',true],
    ['1', [2], '', -5, [['expression', 'pl_arty_rounds = 1;    [] spawn KMD_fnc_showArtyMenu']], '1', '1'],
    ['3', [3], '', -5, [['expression', 'pl_arty_rounds = 3;    [] spawn KMD_fnc_showArtyMenu']], '1', '1'],
    ['6', [4], '', -5, [['expression', 'pl_arty_rounds = 6;    [] spawn KMD_fnc_showArtyMenu']], '1', '1'],
    ['9', [5], '', -5, [['expression', 'pl_arty_rounds = 9;    [] spawn KMD_fnc_showArtyMenu']], '1', '1'],
    ['12', [6], '', -5, [['expression', 'pl_arty_rounds = 12;  [] spawn KMD_fnc_showArtyMenu']], '1', '1'],
    ['15', [7], '', -5, [['expression', 'pl_arty_rounds = 15;  [] spawn KMD_fnc_showArtyMenu']], '1', '1'],
    ['18', [8], '', -5, [['expression', 'pl_arty_rounds = 18;  [] spawn KMD_fnc_showArtyMenu']], '1', '1'],
    ['21', [9], '', -5, [['expression', 'pl_arty_rounds = 21;  [] spawn KMD_fnc_showArtyMenu']], '1', '1'],
    ['24', [10], '', -5, [['expression', 'pl_arty_rounds = 24; [] spawn KMD_fnc_showArtyMenu']], '1', '1']
];

pl_arty_dispersion_menu = 
[
    ['Dispersion',false],
    ['50 m', [2], '', -5, [['expression', 'pl_arty_dispersion = 50;   [] spawn KMD_fnc_showArtyMenu']], '1', '1'],
    ['75 m', [3], '', -5, [['expression', 'pl_arty_dispersion = 75;   [] spawn KMD_fnc_showArtyMenu']], '1', '1'],
    ['100 m', [4], '', -5, [['expression', 'pl_arty_dispersion = 100; [] spawn KMD_fnc_showArtyMenu']], '1', '1'],
    ['125 m', [5], '', -5, [['expression', 'pl_arty_dispersion = 125; [] spawn KMD_fnc_showArtyMenu']], '1', '1'],
    ['150 m', [6], '', -5, [['expression', 'pl_arty_dispersion = 150; [] spawn KMD_fnc_showArtyMenu']], '1', '1'],
    ['200 m', [7], '', -5, [['expression', 'pl_arty_dispersion = 200; [] spawn KMD_fnc_showArtyMenu']], '1', '1'],
    ['250 m', [8], '', -5, [['expression', 'pl_arty_dispersion = 250; [] spawn KMD_fnc_showArtyMenu']], '1', '1'],
    ['300 m', [9], '', -5, [['expression', 'pl_arty_dispersion = 300; [] spawn KMD_fnc_showArtyMenu']], '1', '1']
];

pl_arty_delay_menu = [
    ['Delay',true],
    ['1 s', [2], '', -5, [['expression', 'pl_arty_delay = 1;   [] spawn KMD_fnc_showArtyMenu']], '1', '1'],
    ['5 s', [3], '', -5, [['expression', 'pl_arty_delay = 5;   [] spawn KMD_fnc_showArtyMenu']], '1', '1'],
    ['10 s', [4], '', -5, [['expression', 'pl_arty_delay = 10; [] spawn KMD_fnc_showArtyMenu']], '1', '1'],
    ['15 s', [5], '', -5, [['expression', 'pl_arty_delay = 15; [] spawn KMD_fnc_showArtyMenu']], '1', '1'],
    ['20 s', [6], '', -5, [['expression', 'pl_arty_delay = 20; [] spawn KMD_fnc_showArtyMenu']], '1', '1'],
    ['30 s', [7], '', -5, [['expression', 'pl_arty_delay = 30; [] spawn KMD_fnc_showArtyMenu']], '1', '1']
];

pl_mortar_round_menu = 
[
    ['Rounds',true],
    ['4', [2], '', -5, [['expression', 'pl_mortar_rounds = 4; [] spawn KMD_fnc_showMortarMenu']], '1', '1'],
    ['8', [3], '', -5, [['expression', 'pl_mortar_rounds = 8; [] spawn KMD_fnc_showMortarMenu']], '1', '1']

];
