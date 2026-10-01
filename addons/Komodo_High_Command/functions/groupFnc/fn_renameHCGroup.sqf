params["_group"];

format ["Starting renaming for %1", _group] call KMD_fnc_debug;

pl_group_rename = nil;
disableSerialization;
private _display = findDisplay 0 createDisplay "RscDisplayEmpty";
private _ctrlGroup = _display ctrlCreate ["RscControlsGroupNoScrollbars", -1];
private _ctrlBackground = _display ctrlCreate ["RscTextMulti", -1, _ctrlGroup];
IDD_EDIT_BOX = 123;
private _ctrlEdit = _display ctrlCreate ["RscEdit", IDD_EDIT_BOX, _ctrlGroup];
private _ctrlButton = _display ctrlCreate ["RscShortcutButton", -1, _ctrlGroup];
_ctrlGroup ctrlSetPosition [0.5, 0.5, 0, 0];
_ctrlGroup ctrlCommit 0;
_ctrlBackground ctrlSetPosition [0, 0, 0.5, 0.2];
_ctrlBackground ctrlSetBackgroundColor [0.46, 0.46, 0.31, 0.9];
_ctrlBackground ctrlSetText "Rename group";
_ctrlBackground ctrlEnable false;
_ctrlBackground ctrlCommit 0;
_ctrlEdit ctrlSetPosition [0.01, 0.05, 0.48, 0.05];
_ctrlEdit ctrlSetBackgroundColor [0, 0, 0, 0.8];
_ctrlEdit ctrlCommit 0;
_ctrlEdit ctrlSetText (groupId _group);
_ctrlButton ctrlSetPosition [0.185, 0.12, 0.13, 0.05];
_ctrlButton ctrlCommit 0;
_ctrlButton ctrlSetText "Ok";
_ctrlButton ctrlAddEventHandler ["ButtonClick",
{
	params ["_ctrl"];
	_display = ctrlParent _ctrl;
	_text = ctrlText (_display displayCtrl IDD_EDIT_BOX);
    _text = trim _text;
	if (_text != "") then { 
		pl_group_rename = _text;
		_display closeDisplay 1;
	};
}];
ctrlSetFocus _ctrlEdit;
_ctrlGroup ctrlSetPosition [0.25, 0.25, 0.5, 0.5];
_ctrlGroup ctrlCommit 0.1;

waitUntil {!isNil "pl_group_rename"};

format ["New name for %1 is %2", _group, pl_group_rename] call KMD_fnc_debug;

_group setGroupId [pl_group_rename];
