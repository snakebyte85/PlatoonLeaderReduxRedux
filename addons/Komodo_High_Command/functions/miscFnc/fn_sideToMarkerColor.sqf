    params ["_side"];
    private _color = switch (_side) do {
    case west: { "colorBLUFOR" };       // BLUFOR
    case east: { "colorOPFOR" };        // OPFOR
    case independent: { "colorGUER" }; // Independent (Res)
    case civilian: { "ColorCIV" };// Civilian
    default { "ColorUNKNOWN" };
    };
    _color;