
private["_hcGroups"];


_hcGroups = hcAllGroups player;

hcRemoveAllGroups player;

{
    player hcSetGroup[_x];
} forEach _hcGroups;
