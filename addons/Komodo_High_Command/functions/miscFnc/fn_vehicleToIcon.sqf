    params ["_vehicle"];
    private _icon = switch (true) do {
    case (_vehicle isKindOf "Air") : { "\A3\ui_f\data\igui\cfg\simpleTasks\types\heli_ca.paa" };    
    case (_vehicle isKindOf "Truck"): { "\A3\ui_f\data\igui\cfg\simpleTasks\types\truck_ca.paa" };      
    case (_vehicle isKindOf "Car") : { "\A3\ui_f\data\igui\cfg\simpleTasks\types\car_ca.paa" }; 
    case (_vehicle isKindOf "Ship"): { "\A3\ui_f\data\igui\cfg\simpleTasks\types\boat_ca.paa" };
    default { "\A3\ui_f\data\igui\cfg\simpleTasks\types\truck_ca.paa" };
    };
    _icon;
