#include "\a3\ui_f\hpp\definedikcodes.inc"

[
	_category,
	"Select HC Group", 
	"Selects the HC-Group of the Unit the player aims at", 
	{_this spawn KMD_fnc_selectGroup}, 
	"", 
	[DIK_T, [false, false, false]]

] call CBA_fnc_addKeybind;

[
	_category,
	"hcSquadIn_key", 
	"Remote View Leader of HC Group", 
	{_this spawn KMD_fnc_spawnCam}, 
	"", 
	[DIK_HOME, [false, false, false]]

] call CBA_fnc_addKeybind;

[
	_category,
	"hcSquadOut_key", 
	"Release Remote View", 
	{_this spawn KMD_fnc_remoteCameraOut}, 
	"", 
	[DIK_END, [false, false, false]]

] call CBA_fnc_addKeybind;
